import QtQuick 2.12
import Lomiri.Components 1.3
import "ut_components"

Page {
    id: numberOptionPage
    visible: false
    anchors.fill: parent

    header: AppHeader {
        id: pageHeader
        pageTitle: "NumberOption"
        isRootPage: false
        appIconName: ""
        showSettingsButton: false
    }

    Label {
        id: feedbackLabel
        anchors {
            top: pageHeader.bottom
            left: parent.left
            right: parent.right
            margins: units.gu(2)
        }
        text: "Interact with any NumberOption to see feedback"
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
            spacing: units.gu(2)

            Label {
                text: "Basic Number Input"
                fontSize: "large"
                color: theme.palette.normal.backgroundText
            }

            NumberOption {
                title: "Age"
                subtitle: "Enter your age"
                value: 25
                minimumValue: 0
                maximumValue: 120
                onValueUpdated: feedbackLabel.text = "Age changed to: " + newValue
            }

            NumberOption {
                title: "Quantity"
                value: 10
                minimumValue: 1
                maximumValue: 100
                onValueUpdated: feedbackLabel.text = "Quantity changed to: " + newValue
            }

            Item {
                width: parent.width
                height: units.gu(2)
            }

            Label {
                text: "With Units/Suffix"
                fontSize: "large"
                color: theme.palette.normal.backgroundText
            }

            NumberOption {
                title: "Temperature"
                subtitle: "Current temperature"
                value: 20
                minimumValue: -50
                maximumValue: 60
                suffix: "°C"
                onValueUpdated: feedbackLabel.text = "Temperature set to: " + newValue + "°C"
            }

            NumberOption {
                title: "Distance"
                subtitle: "Travel distance"
                value: 150
                minimumValue: 0
                maximumValue: 1000
                suffix: "km"
                onValueUpdated: feedbackLabel.text = "Distance set to: " + newValue + " km"
            }

            NumberOption {
                title: "Progress"
                value: 75
                minimumValue: 0
                maximumValue: 100
                suffix: "%"
                onValueUpdated: feedbackLabel.text = "Progress: " + newValue + "%"
            }

            Item {
                width: parent.width
                height: units.gu(2)
            }

            Label {
                text: "Negative Values Support"
                fontSize: "large"
                color: theme.palette.normal.backgroundText
            }

            NumberOption {
                title: "Account Balance"
                subtitle: "Can be negative"
                value: -50
                minimumValue: -1000
                maximumValue: 10000
                suffix: "$"
                onValueUpdated: feedbackLabel.text = "Balance: $" + newValue
            }

            NumberOption {
                title: "Elevation"
                subtitle: "Above/below sea level"
                value: 0
                minimumValue: -500
                maximumValue: 9000
                suffix: "m"
                onValueUpdated: feedbackLabel.text = "Elevation: " + newValue + "m"
            }

            Item {
                width: parent.width
                height: units.gu(2)
            }

            Label {
                text: "Large Range Values"
                fontSize: "large"
                color: theme.palette.normal.backgroundText
            }

            NumberOption {
                title: "Year"
                subtitle: "Select a year"
                value: 2025
                minimumValue: 1900
                maximumValue: 2100
                onValueUpdated: feedbackLabel.text = "Year selected: " + newValue
            }

            NumberOption {
                title: "Port Number"
                subtitle: "Network port"
                value: 8080
                minimumValue: 1
                maximumValue: 65535
                onValueUpdated: feedbackLabel.text = "Port: " + newValue
            }

            Item {
                width: parent.width
                height: units.gu(2)
            }

            Label {
                text: "Disabled/Read-only State"
                fontSize: "large"
                color: theme.palette.normal.backgroundText
            }

            NumberOption {
                title: "Fixed Value"
                subtitle: "Cannot be changed"
                value: 42
                minimumValue: 0
                maximumValue: 100
                enabled: false
            }

            NumberOption {
                title: "System Memory"
                subtitle: "Read-only value"
                value: 8192
                suffix: "MB"
                enabled: false
            }

            Item {
                width: parent.width
                height: units.gu(2)
            }

            Label {
                text: "Edge Cases"
                fontSize: "large"
                color: theme.palette.normal.backgroundText
            }

            NumberOption {
                title: "Small Range"
                subtitle: "Only 0-5 allowed"
                value: 3
                minimumValue: 0
                maximumValue: 5
                onValueUpdated: feedbackLabel.text = "Small range value: " + newValue
            }

            NumberOption {
                title: "Binary"
                subtitle: "0 or 1 only"
                value: 0
                minimumValue: 0
                maximumValue: 1
                onValueUpdated: feedbackLabel.text = "Binary value: " + newValue
            }

            NumberOption {
                title: "No subtitle"
                value: 50
                minimumValue: 0
                maximumValue: 100
                onValueUpdated: feedbackLabel.text = "Value without subtitle: " + newValue
            }

            Item {
                width: parent.width
                height: units.gu(2)
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
            onClicked: pageStack.pop()
        }
    }
}
