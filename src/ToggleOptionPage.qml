import QtQuick 2.12
import Lomiri.Components 1.3
import "qml"

Page {
    id: toggleOptionPage
    visible: false
    anchors.fill: parent

    header: AppHeader {
        id: pageHeader
        pageTitle: "ToggleOption"
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
                text: "Basic Toggle Options"
                fontSize: "large"
                font.bold: true
                width: parent.width
            }

            ToggleOption {
                title: "Enable Notifications"
                checked: true
                onToggled: feedbackLabel.text = "Notifications toggled: " + checked
            }

            ToggleOption {
                title: "Auto-sync"
                subtitle: "Sync data automatically with the cloud"
                checked: false
                onToggled: feedbackLabel.text = "Auto-sync toggled: " + checked
            }

            Label {
                text: "Toggle with Long Text"
                fontSize: "large"
                font.bold: true
                width: parent.width
            }

            ToggleOption {
                title: "This is a very long title that should be elided when it reaches the toggle switch control"
                checked: false
                onToggled: feedbackLabel.text = "Long title toggle: " + checked
            }

            ToggleOption {
                title: "Location Services"
                subtitle: "This is a very long subtitle text that should be elided when it doesn't fit in the available space next to the toggle switch"
                checked: true
                onToggled: feedbackLabel.text = "Location Services toggled: " + checked
            }

            Label {
                text: "Disabled State"
                fontSize: "large"
                font.bold: true
                width: parent.width
            }

            ToggleOption {
                title: "Disabled Toggle (Off)"
                subtitle: "This toggle cannot be changed"
                checked: false
                enabled: false
                onToggled: feedbackLabel.text = "This shouldn't appear!"
            }

            ToggleOption {
                title: "Disabled Toggle (On)"
                subtitle: "This toggle is locked in the on position"
                checked: true
                enabled: false
                onToggled: feedbackLabel.text = "This shouldn't appear!"
            }

            Label {
                text: "Settings List Example"
                fontSize: "large"
                font.bold: true
                width: parent.width
            }

            Column {
                width: parent.width
                spacing: 0

                ToggleOption {
                    title: "Wi-Fi"
                    subtitle: "Connect to wireless networks"
                    checked: true
                    onToggled: feedbackLabel.text = "Wi-Fi toggled: " + checked
                }

                ToggleOption {
                    title: "Bluetooth"
                    subtitle: "Connect to Bluetooth devices"
                    checked: false
                    onToggled: feedbackLabel.text = "Bluetooth toggled: " + checked
                }

                ToggleOption {
                    title: "Airplane Mode"
                    subtitle: "Disable all wireless connections"
                    checked: false
                    onToggled: feedbackLabel.text = "Airplane Mode toggled: " + checked
                }

                ToggleOption {
                    title: "Mobile Data"
                    subtitle: "Use cellular data for internet"
                    checked: true
                    onToggled: feedbackLabel.text = "Mobile Data toggled: " + checked
                }
            }

            Label {
                text: "Interactive Demo"
                fontSize: "large"
                font.bold: true
                width: parent.width
            }

            ToggleOption {
                id: masterToggle
                title: "Master Switch"
                subtitle: "Enable/disable all child toggles below"
                checked: true
                onToggled: {
                    feedbackLabel.text = "Master Switch toggled: " + checked;
                    childToggle1.enabled = checked;
                    childToggle2.enabled = checked;
                    childToggle3.enabled = checked;
                }
            }

            ToggleOption {
                id: childToggle1
                title: "Child Option 1"
                checked: false
                onToggled: feedbackLabel.text = "Child Option 1 toggled: " + checked
            }

            ToggleOption {
                id: childToggle2
                title: "Child Option 2"
                subtitle: "Depends on master switch"
                checked: true
                onToggled: feedbackLabel.text = "Child Option 2 toggled: " + checked
            }

            ToggleOption {
                id: childToggle3
                title: "Child Option 3"
                subtitle: "Also depends on master switch"
                checked: false
                onToggled: feedbackLabel.text = "Child Option 3 toggled: " + checked
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
