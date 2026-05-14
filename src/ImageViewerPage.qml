import Lomiri.Components 1.3
import QtQuick 2.12
import "qml"

Page {
    id: imageViewerPage

    property bool galleryMode: true
    property bool showArrows: true
    property bool swipeNavigation: true
    property string interactionMessage: i18n.tr("Pinch to zoom, double tap to reset, and swipe horizontally to request navigation")
    property string providerMessage: i18n.tr("Waiting for the viewer to request adjacent images")
    property var singleImageSet: [{
        "source": "https://picsum.photos/id/1069/1200/900"
    }]
    property var galleryImages: [{
        "source": "https://picsum.photos/id/237/1200/900"
    }, {
        "filePath": "https://picsum.photos/id/1025/1200/900"
    }, {
        "imagePath": "https://picsum.photos/id/1074/1200/900"
    }]
    property int currentIndex: -1
    property var currentItem: null
    property var previousItem: undefined
    property var nextItem: undefined
    readonly property var activeImages: galleryMode ? galleryImages : singleImageSet

    function itemAt(index) {
        if (index < 0 || index >= activeImages.length)
            return null;

        return activeImages[index];
    }

    function adjacentStateLabel(item) {
        if (item === undefined)
            return i18n.tr("loading");

        if (item === null)
            return i18n.tr("none");

        return i18n.tr("ready");
    }

    function updateProviderMessage(action) {
        providerMessage = action + " • " + i18n.tr("prev %1 • next %2").arg(adjacentStateLabel(previousItem)).arg(adjacentStateLabel(nextItem));
    }

    function showIndex(index, action) {
        if (activeImages.length === 0) {
            currentIndex = -1;
            currentItem = null;
            previousItem = null;
            nextItem = null;
            updateProviderMessage(action);
            return ;
        }
        currentIndex = Math.max(0, Math.min(index, activeImages.length - 1));
        previousItem = undefined;
        nextItem = undefined;
        currentItem = itemAt(currentIndex);
        updateProviderMessage(action);
    }

    function selectSingleMode() {
        galleryMode = false;
        showIndex(0, i18n.tr("Page switched to a single-image provider"));
    }

    function selectGalleryMode() {
        galleryMode = true;
        showIndex(0, i18n.tr("Page switched to a gallery provider"));
    }

    visible: false
    anchors.fill: parent
    Component.onCompleted: showIndex(0, i18n.tr("Page set the initial current image"))

    Item {
        id: controls

        height: contentColumn.height

        anchors {
            top: pageHeader.bottom
            left: parent.left
            right: parent.right
            margins: units.gu(2)
        }

        Column {
            id: contentColumn

            width: parent.width
            spacing: units.gu(1.5)

            Label {
                width: parent.width
                wrapMode: Text.WordWrap
                text: (imageViewerPage.galleryMode ? i18n.tr("Gallery provider") : i18n.tr("Single-image provider")) + " • " + (imageViewerPage.currentIndex >= 0 ? (imageViewerPage.currentIndex + 1) + "/" + imageViewerPage.activeImages.length : "0/0") + " • " + i18n.tr("max zoom %1x").arg(viewer.maximumZoom)
                font.bold: true
            }

            Label {
                width: parent.width
                wrapMode: Text.WordWrap
                text: providerMessage
                color: theme.palette.normal.backgroundSecondaryText
            }

            Label {
                width: parent.width
                wrapMode: Text.WordWrap
                text: imageViewerPage.interactionMessage
                color: theme.palette.normal.backgroundSecondaryText
            }

            Row {
                spacing: units.gu(1)

                Button {
                    text: i18n.tr("Single")
                    color: !imageViewerPage.galleryMode ? theme.palette.normal.positive : theme.palette.normal.background
                    onClicked: imageViewerPage.selectSingleMode()
                }

                Button {
                    text: i18n.tr("Gallery")
                    color: imageViewerPage.galleryMode ? theme.palette.normal.positive : theme.palette.normal.background
                    onClicked: imageViewerPage.selectGalleryMode()
                }

                Button {
                    text: i18n.tr("Reset zoom")
                    onClicked: viewer.resetZoom()
                }

            }

            Row {
                spacing: units.gu(2)

                Row {
                    spacing: units.gu(1)

                    Label {
                        anchors.verticalCenter: parent.verticalCenter
                        text: i18n.tr("Arrows")
                    }

                    Switch {
                        checked: imageViewerPage.showArrows
                        onClicked: imageViewerPage.showArrows = checked
                    }

                }

                Row {
                    spacing: units.gu(1)

                    Label {
                        anchors.verticalCenter: parent.verticalCenter
                        text: i18n.tr("Swipe")
                    }

                    Switch {
                        checked: imageViewerPage.swipeNavigation
                        onClicked: imageViewerPage.swipeNavigation = checked
                    }

                }

            }

        }

    }

    ImageViewer {
        id: viewer

        currentItem: imageViewerPage.currentItem
        previousItem: imageViewerPage.previousItem
        nextItem: imageViewerPage.nextItem
        maximumZoom: 6
        showNavigationButtons: imageViewerPage.showArrows
        swipeNavigationEnabled: imageViewerPage.swipeNavigation
        onClicked: imageViewerPage.interactionMessage = i18n.tr("Image tapped at %1x zoom").arg(viewer.zoomFactor.toFixed(1))
        onRequestPrevious: {
            imageViewerPage.previousItem = imageViewerPage.currentIndex > 0 ? imageViewerPage.itemAt(imageViewerPage.currentIndex - 1) : null;
            imageViewerPage.updateProviderMessage(i18n.tr("Viewer requested the previous image for item %1").arg(imageViewerPage.currentIndex + 1));
        }
        onRequestNext: {
            imageViewerPage.nextItem = imageViewerPage.currentIndex < imageViewerPage.activeImages.length - 1 ? imageViewerPage.itemAt(imageViewerPage.currentIndex + 1) : null;
            imageViewerPage.updateProviderMessage(i18n.tr("Viewer requested the next image for item %1").arg(imageViewerPage.currentIndex + 1));
        }
        onPreviousTriggered: {
            imageViewerPage.interactionMessage = i18n.tr("Viewer requested navigation to the previous image");
            imageViewerPage.showIndex(imageViewerPage.currentIndex - 1, i18n.tr("Page accepted backward navigation"));
        }
        onNextTriggered: {
            imageViewerPage.interactionMessage = i18n.tr("Viewer requested navigation to the next image");
            imageViewerPage.showIndex(imageViewerPage.currentIndex + 1, i18n.tr("Page accepted forward navigation"));
        }

        anchors {
            top: controls.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            topMargin: units.gu(1)
        }

    }

    header: AppHeader {
        id: pageHeader

        pageTitle: "ImageViewerPage"
        isRootPage: false
        appIconName: ""
        showSettingsButton: false
    }

}
