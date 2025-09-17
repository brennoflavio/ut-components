import QtQuick 2.12
import Lomiri.Components 1.3
import "ut_components"

Page {
    id: keyboardSpacerPage
    visible: false
    anchors.fill: parent

    header: AppHeader {
        id: pageHeader
        pageTitle: "KeyboardSpacerPage"
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
                text: "Example 1: Text field with automatic keyboard spacing"
                font.bold: true
                width: parent.width
            }

            TextField {
                id: textField1
                width: parent.width
                placeholderText: "Tap here to show keyboard..."
                onTextChanged: feedbackLabel.text = "Text changed: " + text
                onActiveFocusChanged: {
                    if (activeFocus) {
                        feedbackLabel.text = "Text field focused - keyboard should appear";
                    } else {
                        feedbackLabel.text = "Text field unfocused - keyboard should hide";
                    }
                }
            }

            Label {
                text: "Example 2: Multiple text fields with shared spacer"
                font.bold: true
                width: parent.width
            }

            TextField {
                id: textField2
                width: parent.width
                placeholderText: "First name..."
                onActiveFocusChanged: {
                    if (activeFocus)
                        feedbackLabel.text = "First name field focused";
                }
            }

            TextField {
                id: textField3
                width: parent.width
                placeholderText: "Last name..."
                onActiveFocusChanged: {
                    if (activeFocus)
                        feedbackLabel.text = "Last name field focused";
                }
            }

            TextField {
                id: textField4
                width: parent.width
                placeholderText: "Email address..."
                onActiveFocusChanged: {
                    if (activeFocus)
                        feedbackLabel.text = "Email field focused";
                }
            }

            Label {
                text: "Example 3: Text area with keyboard spacer"
                font.bold: true
                width: parent.width
            }

            TextArea {
                id: textArea
                width: parent.width
                height: units.gu(15)
                placeholderText: "Type a longer message here..."
                onActiveFocusChanged: {
                    if (activeFocus) {
                        feedbackLabel.text = "Text area focused - keyboard appears";
                    } else {
                        feedbackLabel.text = "Text area unfocused";
                    }
                }
            }

            Label {
                text: "The KeyboardSpacer below prevents keyboard overlap"
                width: parent.width
                wrapMode: Text.Wrap
                color: theme.palette.normal.backgroundSecondaryText
            }

            KeyboardSpacer {
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
}
