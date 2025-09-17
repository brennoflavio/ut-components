import QtQuick 2.12
import Lomiri.Components 1.3
import "ut_components"

Page {
    id: actionableListPage
    visible: false
    anchors.fill: parent

    header: AppHeader {
        id: pageHeader
        pageTitle: "ActionableListPage"
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
                text: "ActionableList without actions"
                font.bold: true
            }

            ActionableList {
                width: parent.width
                height: units.gu(24)
                items: [{
                        "id": 1,
                        "title": "System Update",
                        "subtitle": "Check for the latest patches",
                        "icon": "system-software-update"
                    }, {
                        "id": 2,
                        "title": "Storage",
                        "subtitle": "Manage device space",
                        "icon": "drive-harddisk"
                    }, {
                        "id": 3,
                        "title": "Display",
                        "subtitle": "Brightness and colors",
                        "icon": "video-display"
                    }]
                onItemClicked: feedbackLabel.text = "ActionableList: Selected " + item.title
            }

            Label {
                text: "ActionableList with search"
                font.bold: true
            }

            ActionableList {
                width: parent.width
                height: units.gu(26)
                showSearchBar: true
                searchPlaceholder: "Search settings"
                searchFields: ["title", "subtitle"]
                items: [{
                        "id": 11,
                        "title": "Wi-Fi",
                        "subtitle": "Connected to Home",
                        "icon": "network-wireless"
                    }, {
                        "id": 12,
                        "title": "Bluetooth",
                        "subtitle": "Discoverable",
                        "icon": "bluetooth"
                    }, {
                        "id": 13,
                        "title": "Cellular",
                        "subtitle": "Roaming disabled",
                        "icon": "network-cellular-3g"
                    }, {
                        "id": 14,
                        "title": "Hotspot",
                        "subtitle": "Off",
                        "icon": "preferences-network-wifi-active-symbolic"
                    }, {
                        "id": 15,
                        "title": "VPN",
                        "subtitle": "Not connected",
                        "icon": "network-vpn"
                    }]
                onItemClicked: feedbackLabel.text = "ActionableList: Opened " + item.title
            }

            Label {
                text: "ActionableList with actions"
                font.bold: true
            }

            ActionableList {
                width: parent.width
                height: units.gu(30)
                emptyMessage: "No services configured"
                itemActions: [{
                        "id": "view",
                        "iconName": "view-grid-symbolic",
                        "text": "View"
                    }, {
                        "id": "disable",
                        "iconName": "lock",
                        "text": "Disable"
                    }, {
                        "id": "delete",
                        "iconName": "delete",
                        "text": "Remove",
                        "enabled": false
                    }]
                items: [{
                        "id": 21,
                        "title": "Calendar Sync",
                        "subtitle": "Last sync 2 hours ago",
                        "icon": "office-calendar"
                    }, {
                        "id": 22,
                        "title": "Mail Account",
                        "subtitle": "Primary inbox",
                        "icon": "mail-unread"
                    }, {
                        "id": 23,
                        "title": "Team Chat",
                        "subtitle": "Notifications enabled",
                        "icon": "wechat-symbolic"
                    }]
                onActionTriggered: feedbackLabel.text = "ActionableList: " + actionId + " on " + item.title
            }

            Label {
                text: "ActionableList with custom item actions"
                font.bold: true
            }

            ActionableList {
                width: parent.width
                height: units.gu(30)
                itemActions: [{
                        "id": "open",
                        "iconName": "view-grid-symbolic",
                        "text": "Open"
                    }, {
                        "id": "share",
                        "iconName": "share",
                        "text": "Share"
                    }]
                items: [{
                        "id": 31,
                        "title": "Saved Article",
                        "subtitle": "Read later list"
                    }, {
                        "id": 32,
                        "title": "Locked Note",
                        "subtitle": "Requires passcode",
                        "customActions": [{
                                "id": "unlock",
                                "iconName": "lock-broken",
                                "text": "Unlock"
                            }]
                    }, {
                        "id": 33,
                        "title": "Shared Album",
                        "subtitle": "Visible to family",
                        "customActions": [{
                                "id": "share",
                                "iconName": "share",
                                "text": "Invite"
                            }, {
                                "id": "remove",
                                "iconName": "delete",
                                "text": "Remove",
                                "visible": false
                            }]
                    }]
                onActionTriggered: feedbackLabel.text = "ActionableList: " + actionId + " for " + item.title
            }

            Label {
                text: "ActionableList empty state"
                font.bold: true
            }

            ActionableList {
                width: parent.width
                height: units.gu(16)
                showSearchBar: true
                searchPlaceholder: "Search downloads"
                emptyMessage: "No downloads available"
                items: []
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
