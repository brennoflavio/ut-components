import Lomiri.Components 1.3
import QtQuick 2.12
import "qml"

Page {
    id: loadingSpinnerPage

    visible: false
    anchors.fill: parent

    Flickable {
        id: pageFlickable

        contentHeight: content.height
        clip: true

        anchors {
            top: pageHeader.bottom
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
                text: "LoadingSpinner Examples"
                fontSize: "large"
                font.bold: true
            }

            Label {
                text: "Original ActivityIndicator"
                fontSize: "medium"
                color: theme.palette.normal.backgroundSecondaryText
            }

            ActivityIndicator {
                anchors.horizontalCenter: parent.horizontalCenter
                running: true
            }

            Label {
                text: "Default Spinner"
                fontSize: "medium"
                color: theme.palette.normal.backgroundSecondaryText
            }

            LoadingSpinner {
                anchors.horizontalCenter: parent.horizontalCenter
                running: true
            }

            Label {
                text: "Custom Size (10 gu)"
                fontSize: "medium"
                color: theme.palette.normal.backgroundSecondaryText
            }

            LoadingSpinner {
                anchors.horizontalCenter: parent.horizontalCenter
                running: true
                width: units.gu(10)
                height: units.gu(10)
            }

            Label {
                text: "Toggle Spinner"
                fontSize: "medium"
                color: theme.palette.normal.backgroundSecondaryText
            }

            Button {
                text: toggleSpinner.running ? "Stop Spinner" : "Start Spinner"
                width: parent.width
                onClicked: toggleSpinner.running = !toggleSpinner.running
            }

            LoadingSpinner {
                id: toggleSpinner

                anchors.horizontalCenter: parent.horizontalCenter
                running: false
            }

        }

    }

    header: AppHeader {
        id: pageHeader

        pageTitle: "LoadingSpinnerPage"
        isRootPage: false
        appIconName: ""
        showSettingsButton: false
    }

}
