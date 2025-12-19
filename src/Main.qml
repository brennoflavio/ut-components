import Lomiri.Components 1.3
import QtQuick 2.12
import "qml"

MainView {
    id: mainView

    objectName: "mainView"
    applicationName: "ut-components.brennoflavio"
    width: units.gu(45)
    height: units.gu(75)

    PageStack {
        id: pageStack

        Component.onCompleted: push(mainPage)

        Page {
            id: mainPage

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

                clip: true
                contentHeight: content.height

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
                        text: "Components"
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        width: parent.width
                    }

                    ActionButton {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "ActionableList"
                        iconName: "view-grid-symbolic"
                        onClicked: {
                            pageStack.push(Qt.resolvedUrl("ActionableListPage.qml"));
                        }
                    }

                    ActionButton {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "ActionButton"
                        iconName: "view-grid-symbolic"
                        onClicked: {
                            pageStack.push(Qt.resolvedUrl("ActionButtonPage.qml"));
                        }
                    }

                    ActionButton {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "CardList"
                        iconName: "view-grid-symbolic"
                        onClicked: {
                            pageStack.push(Qt.resolvedUrl("CardListPage.qml"));
                        }
                    }

                    ActionButton {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "ConfigurationGroup"
                        iconName: "view-grid-symbolic"
                        onClicked: {
                            pageStack.push(Qt.resolvedUrl("ConfigurationGroupPage.qml"));
                        }
                    }

                    ActionButton {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "Form"
                        iconName: "view-grid-symbolic"
                        onClicked: {
                            pageStack.push(Qt.resolvedUrl("FormPage.qml"));
                        }
                    }

                    ActionButton {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "IconButton"
                        iconName: "view-grid-symbolic"
                        onClicked: {
                            pageStack.push(Qt.resolvedUrl("IconButtonPage.qml"));
                        }
                    }

                    ActionButton {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "InputField"
                        iconName: "view-grid-symbolic"
                        onClicked: {
                            pageStack.push(Qt.resolvedUrl("InputFieldPage.qml"));
                        }
                    }

                    ActionButton {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "KeyboardSpacer"
                        iconName: "view-grid-symbolic"
                        onClicked: {
                            pageStack.push(Qt.resolvedUrl("KeyboardSpacerPage.qml"));
                        }
                    }

                    ActionButton {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "LoadToast"
                        iconName: "view-grid-symbolic"
                        onClicked: {
                            pageStack.push(Qt.resolvedUrl("LoadToastPage.qml"));
                        }
                    }

                    ActionButton {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "NumberOption"
                        iconName: "view-grid-symbolic"
                        onClicked: {
                            pageStack.push(Qt.resolvedUrl("NumberOptionPage.qml"));
                        }
                    }

                    ActionButton {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "ToggleOption"
                        iconName: "view-grid-symbolic"
                        onClicked: {
                            pageStack.push(Qt.resolvedUrl("ToggleOptionPage.qml"));
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

                pageTitle: "UT Components Demo"
                isRootPage: true
                appIconName: "ubuntu-store-symbolic"
                showSettingsButton: true
                onSettingsClicked: {
                    feedbackLabel.text = "Header: Settings button clicked!";
                }
            }

        }

    }

}
