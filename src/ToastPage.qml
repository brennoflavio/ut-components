import Lomiri.Components 1.3
import QtQuick 2.12
import "qml"

Page {
    id: toastPage

    visible: false
    anchors.fill: parent

    Label {
        id: feedbackLabel

        text: "Click any button to show a toast"
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
            bottom: parent.bottom
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
                text: "Default Toast"
                fontSize: "small"
                color: theme.palette.normal.backgroundSecondaryText
            }

            ActionButton {
                text: "Show Default Toast"
                iconName: "info"
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    feedbackLabel.text = "Showing default toast";
                    defaultToast.show("This is a default toast");
                }
            }

            Label {
                text: "Short Duration Toast (500ms)"
                fontSize: "small"
                color: theme.palette.normal.backgroundSecondaryText
            }

            ActionButton {
                text: "Show Short Toast"
                iconName: "timer"
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    feedbackLabel.text = "Showing short duration toast";
                    shortToast.show("Quick message!");
                }
            }

            Label {
                text: "Long Duration Toast (2000ms)"
                fontSize: "small"
                color: theme.palette.normal.backgroundSecondaryText
            }

            ActionButton {
                text: "Show Long Toast"
                iconName: "history"
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    feedbackLabel.text = "Showing long duration toast";
                    longToast.show("This toast stays longer on screen");
                }
            }

            Label {
                text: "Custom Position Toast"
                fontSize: "small"
                color: theme.palette.normal.backgroundSecondaryText
            }

            ActionButton {
                text: "Show Higher Toast"
                iconName: "up"
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    feedbackLabel.text = "Showing toast with custom position";
                    highToast.show("I'm positioned higher!");
                }
            }

            Label {
                text: "Success Message"
                fontSize: "small"
                color: theme.palette.normal.backgroundSecondaryText
            }

            ActionButton {
                text: "Show Success Toast"
                iconName: "ok"
                backgroundColor: theme.palette.normal.positive
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    feedbackLabel.text = "Showing success toast";
                    defaultToast.show("Action completed successfully!");
                }
            }

            Label {
                text: "Error Message"
                fontSize: "small"
                color: theme.palette.normal.backgroundSecondaryText
            }

            ActionButton {
                text: "Show Error Toast"
                iconName: "dialog-warning-symbolic"
                backgroundColor: theme.palette.normal.negative
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    feedbackLabel.text = "Showing error toast";
                    defaultToast.show("Something went wrong!");
                }
            }

        }

    }

    Toast {
        id: defaultToast
    }

    Toast {
        id: shortToast

        duration: 500
    }

    Toast {
        id: longToast

        duration: 2000
    }

    Toast {
        id: highToast

        bottomMargin: units.gu(20)
    }

    header: AppHeader {
        id: pageHeader

        pageTitle: "ToastPage"
        isRootPage: false
        appIconName: ""
        showSettingsButton: false
    }

}
