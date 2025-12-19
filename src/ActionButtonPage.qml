import Lomiri.Components 1.3
import QtQuick 2.12
import "qml"

Page {
    id: actionButtonPage

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
                text: "Default ActionButton"
                fontSize: "small"
                color: theme.palette.normal.backgroundSecondaryText
            }

            ActionButton {
                text: "Add New Item"
                iconName: "add"
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: feedbackLabel.text = "Default button clicked: Add New Item"
            }

            Label {
                text: "Destructive ActionButton"
                fontSize: "small"
                color: theme.palette.normal.backgroundSecondaryText
            }

            ActionButton {
                text: "Delete All"
                iconName: "delete"
                backgroundColor: theme.palette.normal.negative
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: feedbackLabel.text = "Destructive button clicked: Delete All"
            }

            Label {
                text: "Save ActionButton"
                fontSize: "small"
                color: theme.palette.normal.backgroundSecondaryText
            }

            ActionButton {
                text: "Save Document"
                iconName: "save"
                backgroundColor: theme.palette.normal.activity
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: feedbackLabel.text = "Save button clicked: Document saved"
            }

            Label {
                text: "Custom Styled ActionButton"
                fontSize: "small"
                color: theme.palette.normal.backgroundSecondaryText
            }

            ActionButton {
                text: "Custom Style"
                iconName: "starred"
                backgroundColor: "#FF9800"
                textColor: "#000000"
                iconColor: "#000000"
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: feedbackLabel.text = "Custom styled button clicked"
            }

            Label {
                text: "Disabled ActionButton"
                fontSize: "small"
                color: theme.palette.normal.backgroundSecondaryText
            }

            ActionButton {
                text: "Disabled Action"
                iconName: "lock"
                enabled: false
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: feedbackLabel.text = "This should never appear"
            }

            Label {
                text: "Different Icons"
                fontSize: "small"
                color: theme.palette.normal.backgroundSecondaryText
            }

            ActionButton {
                text: "Edit Profile"
                iconName: "edit"
                backgroundColor: theme.palette.normal.backgroundTertiaryText
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: feedbackLabel.text = "Edit button clicked: Edit Profile"
            }

            ActionButton {
                text: "Share Content"
                iconName: "share"
                backgroundColor: "#4CAF50"
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: feedbackLabel.text = "Share button clicked: Content shared"
            }

            ActionButton {
                text: "Settings"
                iconName: "settings"
                backgroundColor: "#607D8B"
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: feedbackLabel.text = "Settings button clicked"
            }

            Label {
                text: "Toggle Enabled State"
                fontSize: "small"
                color: theme.palette.normal.backgroundSecondaryText
            }

            ActionButton {
                id: toggleableButton

                text: "Toggle Me"
                iconName: "reload"
                enabled: toggleSwitch.checked
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: feedbackLabel.text = "Toggleable button clicked!"
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: units.gu(1)

                Label {
                    text: "Enable button:"
                    anchors.verticalCenter: toggleSwitch.verticalCenter
                }

                Switch {
                    id: toggleSwitch

                    checked: true
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

        pageTitle: "ActionButtonPage"
        isRootPage: false
        appIconName: ""
        showSettingsButton: true
        onSettingsClicked: {
            feedbackLabel.text = "Header: Settings button clicked!";
        }
    }

}
