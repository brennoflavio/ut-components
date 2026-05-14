import Lomiri.Components 1.3
import QtQuick 2.12
import "qml"

Page {
    id: videoViewerPage

    property bool galleryMode: true
    property bool showArrows: true
    property bool swipeNavigation: true
    property bool autoHideControls: true
    property string interactionMessage: i18n.tr("Tap to show or hide controls, use play/pause to control playback, and drag the timeline to seek")
    property string providerMessage: i18n.tr("Waiting for the viewer to request adjacent videos")
    property var singleVideoSet: [{
        "source": "https://samplelib.com/lib/preview/mp4/sample-5s.mp4"
    }]
    property var galleryVideos: [{
        "source": "https://samplelib.com/lib/preview/mp4/sample-5s.mp4"
    }, {
        "videoPath": "https://samplelib.com/lib/preview/mp4/sample-5s.mp4"
    }, {
        "filePath": "https://samplelib.com/lib/preview/mp4/sample-15s.mp4"
    }]
    property int currentIndex: -1
    property var currentItem: null
    property var previousItem: undefined
    property var nextItem: undefined
    readonly property var activeVideos: galleryMode ? galleryVideos : singleVideoSet

    function formatTime(milliseconds) {
        if (!milliseconds || milliseconds < 0)
            return "0:00";

        var totalSeconds = Math.floor(milliseconds / 1000);
        var hours = Math.floor(totalSeconds / 3600);
        var minutes = Math.floor((totalSeconds % 3600) / 60);
        var seconds = totalSeconds % 60;
        if (hours > 0)
            return hours + ":" + (minutes < 10 ? "0" : "") + minutes + ":" + (seconds < 10 ? "0" : "") + seconds;

        return minutes + ":" + (seconds < 10 ? "0" : "") + seconds;
    }

    function itemAt(index) {
        if (index < 0 || index >= activeVideos.length)
            return null;

        return activeVideos[index];
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
        if (activeVideos.length === 0) {
            currentIndex = -1;
            currentItem = null;
            previousItem = null;
            nextItem = null;
            updateProviderMessage(action);
            return ;
        }
        currentIndex = Math.max(0, Math.min(index, activeVideos.length - 1));
        previousItem = undefined;
        nextItem = undefined;
        currentItem = itemAt(currentIndex);
        updateProviderMessage(action);
    }

    function selectSingleMode() {
        galleryMode = false;
        showIndex(0, i18n.tr("Page switched to a single-video provider"));
    }

    function selectGalleryMode() {
        galleryMode = true;
        showIndex(0, i18n.tr("Page switched to a gallery provider"));
    }

    visible: false
    anchors.fill: parent
    Component.onCompleted: showIndex(0, i18n.tr("Page set the initial current video"))

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
                text: (videoViewerPage.galleryMode ? i18n.tr("Gallery provider") : i18n.tr("Single-video provider")) + " • " + (videoViewerPage.currentIndex >= 0 ? (videoViewerPage.currentIndex + 1) + "/" + videoViewerPage.activeVideos.length : "0/0") + " • " + (viewer.playing ? i18n.tr("Playing") : i18n.tr("Paused"))
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
                text: formatTime(viewer.position) + " / " + formatTime(viewer.duration)
                color: theme.palette.normal.backgroundSecondaryText
            }

            Label {
                width: parent.width
                wrapMode: Text.WordWrap
                text: interactionMessage + "\n" + i18n.tr("Demo note: sample videos are loaded from remote MP4 URLs.")
                color: theme.palette.normal.backgroundSecondaryText
            }

            Row {
                spacing: units.gu(1)

                Button {
                    text: i18n.tr("Single")
                    color: !videoViewerPage.galleryMode ? theme.palette.normal.positive : theme.palette.normal.background
                    onClicked: videoViewerPage.selectSingleMode()
                }

                Button {
                    text: i18n.tr("Gallery")
                    color: videoViewerPage.galleryMode ? theme.palette.normal.positive : theme.palette.normal.background
                    onClicked: videoViewerPage.selectGalleryMode()
                }

                Button {
                    text: viewer.playing ? i18n.tr("Pause") : i18n.tr("Play")
                    onClicked: viewer.togglePlayback()
                }

                Button {
                    text: i18n.tr("Reset")
                    onClicked: viewer.resetPlayback()
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
                        checked: videoViewerPage.showArrows
                        onClicked: videoViewerPage.showArrows = checked
                    }

                }

                Row {
                    spacing: units.gu(1)

                    Label {
                        anchors.verticalCenter: parent.verticalCenter
                        text: i18n.tr("Swipe")
                    }

                    Switch {
                        checked: videoViewerPage.swipeNavigation
                        onClicked: videoViewerPage.swipeNavigation = checked
                    }

                }

                Row {
                    spacing: units.gu(1)

                    Label {
                        anchors.verticalCenter: parent.verticalCenter
                        text: i18n.tr("Auto hide")
                    }

                    Switch {
                        checked: videoViewerPage.autoHideControls
                        onClicked: videoViewerPage.autoHideControls = checked
                    }

                }

            }

        }

    }

    VideoViewer {
        id: viewer

        currentItem: videoViewerPage.currentItem
        previousItem: videoViewerPage.previousItem
        nextItem: videoViewerPage.nextItem
        showNavigationButtons: videoViewerPage.showArrows
        swipeNavigationEnabled: videoViewerPage.swipeNavigation
        autoHideControls: videoViewerPage.autoHideControls
        onClicked: interactionMessage = i18n.tr("Viewer tapped • controls are %1").arg(viewer.controlsVisible ? i18n.tr("visible") : i18n.tr("hidden"))
        onRequestPrevious: {
            videoViewerPage.previousItem = videoViewerPage.currentIndex > 0 ? videoViewerPage.itemAt(videoViewerPage.currentIndex - 1) : null;
            videoViewerPage.updateProviderMessage(i18n.tr("Viewer requested the previous video for item %1").arg(videoViewerPage.currentIndex + 1));
        }
        onRequestNext: {
            videoViewerPage.nextItem = videoViewerPage.currentIndex < videoViewerPage.activeVideos.length - 1 ? videoViewerPage.itemAt(videoViewerPage.currentIndex + 1) : null;
            videoViewerPage.updateProviderMessage(i18n.tr("Viewer requested the next video for item %1").arg(videoViewerPage.currentIndex + 1));
        }
        onPreviousTriggered: {
            videoViewerPage.interactionMessage = i18n.tr("Viewer requested navigation to the previous video");
            videoViewerPage.showIndex(videoViewerPage.currentIndex - 1, i18n.tr("Page accepted backward navigation"));
        }
        onNextTriggered: {
            videoViewerPage.interactionMessage = i18n.tr("Viewer requested navigation to the next video");
            videoViewerPage.showIndex(videoViewerPage.currentIndex + 1, i18n.tr("Page accepted forward navigation"));
        }
        onPlaybackChanged: {
            if (playing)
                interactionMessage = i18n.tr("Playback started");
            else if (viewer.duration > 0 || viewer.position > 0)
                interactionMessage = i18n.tr("Playback paused");
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

        pageTitle: "VideoViewerPage"
        isRootPage: false
        appIconName: ""
        showSettingsButton: false
    }

}
