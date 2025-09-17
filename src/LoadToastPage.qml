import QtQuick 2.12
import Lomiri.Components 1.3
import "qml"

Page {
    id: loadToastPage
    visible: false
    anchors.fill: parent

    header: AppHeader {
        id: pageHeader
        pageTitle: "LoadToastPage"
        isRootPage: false
        appIconName: ""
        showSettingsButton: true

        onSettingsClicked: {
            feedbackLabel.text = "Header: Settings button clicked!";
        }
    }

    Label {
        id: feedbackLabel
        anchors {
            top: pageHeader.bottom
            left: parent.left
            right: parent.right
            margins: units.gu(2)
        }
        text: "Click any button to test interaction"
        font.bold: true
        visible: true
        horizontalAlignment: Text.AlignHCenter
    }

    Flickable {
        id: pageFlickable
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
        contentHeight: content.height
        clip: true

        Column {
            id: content
            width: parent.width
            spacing: units.gu(3)

            Label {
                text: "LoadToast Examples"
                fontSize: "large"
                font.bold: true
            }

            Label {
                text: "Basic Loading Toast"
                fontSize: "medium"
                color: theme.palette.normal.backgroundSecondaryText
            }

            Button {
                text: "Show Basic Loading (3 seconds)"
                width: parent.width
                onClicked: {
                    basicToast.showing = true;
                    feedbackLabel.text = "Basic LoadToast shown";
                    basicTimer.start();
                }
            }

            Label {
                text: "Loading with Message"
                fontSize: "medium"
                color: theme.palette.normal.backgroundSecondaryText
            }

            Button {
                text: "Show Loading with Message (6 seconds)"
                width: parent.width
                onClicked: {
                    messageToast.showing = true;
                    feedbackLabel.text = "LoadToast with message shown";
                    messageTimer.start();
                }
            }

            Label {
                text: "Dynamic Message Loading"
                fontSize: "medium"
                color: theme.palette.normal.backgroundSecondaryText
            }

            Button {
                text: "Show Dynamic Message Loading"
                width: parent.width
                onClicked: {
                    dynamicToast.message = "Initializing...";
                    dynamicToast.showing = true;
                    feedbackLabel.text = "Dynamic LoadToast shown";
                    dynamicUpdateTimer.start();
                }
            }

            Label {
                text: "Long Message Example"
                fontSize: "medium"
                color: theme.palette.normal.backgroundSecondaryText
            }

            Button {
                text: "Show Long Message Loading (3 seconds)"
                width: parent.width
                onClicked: {
                    longMessageToast.showing = true;
                    feedbackLabel.text = "Long message LoadToast shown";
                    longMessageTimer.start();
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

        leftButton: IconButton {
            iconName: "back"
            onClicked: feedbackLabel.text = "BottomBar: Back clicked"
        }
        rightButton: IconButton {
            iconName: "info"
            text: "Info"
            onClicked: feedbackLabel.text = "BottomBar: Info clicked"
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
    }

    LoadToast {
        id: basicToast
        showing: false
    }

    LoadToast {
        id: messageToast
        showing: false
        message: "Loading your data..."
    }

    LoadToast {
        id: dynamicToast
        showing: false
        message: ""
    }

    LoadToast {
        id: toggleToast
        showing: false
        message: "Loading data..."
    }

    LoadToast {
        id: longMessageToast
        showing: false
        message: "This is a very long message to demonstrate how the LoadToast component handles text wrapping when the message is too long to fit on a single line. The component should wrap the text nicely and remain centered."
    }

    Timer {
        id: basicTimer
        interval: 3000
        repeat: false
        onTriggered: {
            basicToast.showing = false;
            feedbackLabel.text = "Basic LoadToast hidden";
        }
    }

    Timer {
        id: messageTimer
        interval: 6000
        repeat: false
        onTriggered: {
            messageToast.showing = false;
            feedbackLabel.text = "Message LoadToast hidden";
        }
    }

    Timer {
        id: longMessageTimer
        interval: 3000
        repeat: false
        onTriggered: {
            longMessageToast.showing = false;
            feedbackLabel.text = "Long message LoadToast hidden";
        }
    }

    Timer {
        id: dynamicUpdateTimer
        interval: 1000
        repeat: true
        property int step: 0
        onTriggered: {
            step++;
            if (step === 1) {
                dynamicToast.message = "Loading resources...";
                feedbackLabel.text = "Message updated: Loading resources...";
            } else if (step === 2) {
                dynamicToast.message = "Almost complete...";
                feedbackLabel.text = "Message updated: Almost complete...";
            } else {
                dynamicToast.showing = false;
                feedbackLabel.text = "Dynamic LoadToast hidden";
                step = 0;
                stop();
            }
        }
    }
}
