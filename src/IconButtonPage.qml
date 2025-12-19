import Lomiri.Components 1.3
import QtQuick 2.12
import "qml"

Page {
    id: iconButtonPage

    visible: false
    anchors.fill: parent

    Label {
        id: feedbackLabel

        text: "Click any button to test interaction"
        font.bold: true
        visible: true
        horizontalAlignment: Text.AlignHCenter

        anchors {
            top: pageHeader.bottom
            left: parent.left
            right: parent.right
            margins: units.gu(2)
        }

    }

    Flickable {
        id: pageFlickable

        contentHeight: content.height
        clip: true

        anchors {
            top: feedbackLabel.bottom
            left: parent.left
            right: parent.right
            bottom: bottomBar.top
            topMargin: units.gu(1)
            leftMargin: units.gu(2)
            rightMargin: units.gu(2)
            bottomMargin: units.gu(2)
        }

        Column {
            id: content

            width: parent.width
            spacing: units.gu(3)

            Label {
                text: "Icon Only Buttons"
                fontSize: "large"
                color: theme.palette.normal.backgroundText
            }

            Flow {
                width: parent.width
                spacing: units.gu(2)

                IconButton {
                    iconName: "add"
                    onClicked: feedbackLabel.text = "Add button clicked"
                }

                IconButton {
                    iconName: "edit"
                    onClicked: feedbackLabel.text = "Edit button clicked"
                }

                IconButton {
                    iconName: "delete"
                    onClicked: feedbackLabel.text = "Delete button clicked"
                }

                IconButton {
                    iconName: "save"
                    onClicked: feedbackLabel.text = "Save button clicked"
                }

                IconButton {
                    iconName: "share"
                    onClicked: feedbackLabel.text = "Share button clicked"
                }

                IconButton {
                    iconName: "search"
                    onClicked: feedbackLabel.text = "Search button clicked"
                }

            }

            Label {
                text: "Buttons with Text Labels"
                fontSize: "large"
                color: theme.palette.normal.backgroundText
            }

            Flow {
                width: parent.width
                spacing: units.gu(2)

                IconButton {
                    iconName: "camera-app-symbolic"
                    text: "Camera"
                    onClicked: feedbackLabel.text = "Camera with label clicked"
                }

                IconButton {
                    iconName: "document-new"
                    text: "New"
                    onClicked: feedbackLabel.text = "New document clicked"
                }

                IconButton {
                    iconName: "document-open"
                    text: "Open"
                    onClicked: feedbackLabel.text = "Open document clicked"
                }

                IconButton {
                    iconName: "document-save"
                    text: "Save"
                    onClicked: feedbackLabel.text = "Save document clicked"
                }

            }

            Label {
                text: "Media Controls"
                fontSize: "large"
                color: theme.palette.normal.backgroundText
            }

            Row {
                spacing: units.gu(2)

                IconButton {
                    iconName: "media-skip-backward"
                    onClicked: feedbackLabel.text = "Previous track"
                }

                IconButton {
                    iconName: "media-playback-start"
                    text: "Play"
                    onClicked: feedbackLabel.text = "Play pressed"
                }

                IconButton {
                    iconName: "media-playback-pause"
                    text: "Pause"
                    onClicked: feedbackLabel.text = "Pause pressed"
                }

                IconButton {
                    iconName: "media-skip-forward"
                    onClicked: feedbackLabel.text = "Next track"
                }

            }

            Label {
                text: "Navigation Icons"
                fontSize: "large"
                color: theme.palette.normal.backgroundText
            }

            Row {
                spacing: units.gu(2)

                IconButton {
                    iconName: "go-up"
                    text: "Up"
                    onClicked: feedbackLabel.text = "Navigate up"
                }

                IconButton {
                    iconName: "go-down"
                    text: "Down"
                    onClicked: feedbackLabel.text = "Navigate down"
                }

                IconButton {
                    iconName: "go-previous"
                    text: "Back"
                    onClicked: feedbackLabel.text = "Go back"
                }

                IconButton {
                    iconName: "go-next"
                    text: "Next"
                    onClicked: feedbackLabel.text = "Go next"
                }

            }

            Label {
                text: "System Actions"
                fontSize: "large"
                color: theme.palette.normal.backgroundText
            }

            Flow {
                width: parent.width
                spacing: units.gu(2)

                IconButton {
                    iconName: "settings"
                    text: "Settings"
                    onClicked: feedbackLabel.text = "Settings clicked"
                }

                IconButton {
                    iconName: "info"
                    text: "Info"
                    onClicked: feedbackLabel.text = "Info clicked"
                }

                IconButton {
                    iconName: "help"
                    text: "Help"
                    onClicked: feedbackLabel.text = "Help clicked"
                }

                IconButton {
                    iconName: "reload"
                    onClicked: feedbackLabel.text = "Reload clicked"
                }

                IconButton {
                    iconName: "close"
                    onClicked: feedbackLabel.text = "Close clicked"
                }

                IconButton {
                    iconName: "tick"
                    onClicked: feedbackLabel.text = "Confirm clicked"
                }

            }

            Label {
                text: "Communication Icons"
                fontSize: "large"
                color: theme.palette.normal.backgroundText
            }

            Row {
                spacing: units.gu(2)

                IconButton {
                    iconName: "message"
                    text: "Message"
                    onClicked: feedbackLabel.text = "Message clicked"
                }

                IconButton {
                    iconName: "call-start"
                    text: "Call"
                    onClicked: feedbackLabel.text = "Start call"
                }

                IconButton {
                    iconName: "mail-unread"
                    text: "Email"
                    onClicked: feedbackLabel.text = "Email clicked"
                }

                IconButton {
                    iconName: "contact-new"
                    onClicked: feedbackLabel.text = "New contact"
                }

            }

        }

    }

    BottomBar {
        id: bottomBar

        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        IconButton {
            iconName: "add"
            text: "Add"
            onClicked: feedbackLabel.text = "BottomBar: Add with label clicked"
        }

        IconButton {
            iconName: "delete"
            onClicked: feedbackLabel.text = "BottomBar: Delete without label clicked"
        }

        leftButton: IconButton {
            iconName: "back"
            onClicked: feedbackLabel.text = "BottomBar: Back clicked"
        }

        rightButton: IconButton {
            iconName: "info"
            text: "Info"
            onClicked: feedbackLabel.text = "BottomBar: Info clicked"
        }

    }

    header: AppHeader {
        id: pageHeader

        pageTitle: "IconButtonPage"
        isRootPage: false
        appIconName: ""
        showSettingsButton: true
        onSettingsClicked: {
            feedbackLabel.text = "Header: Settings button clicked!";
        }
    }

}
