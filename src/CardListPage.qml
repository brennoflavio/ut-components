import QtQuick 2.12
import Lomiri.Components 1.3
import "qml"

Page {
    id: cardListPage
    visible: false
    anchors.fill: parent

    header: AppHeader {
        id: pageHeader
        pageTitle: "CardListPage"
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
                text: "Basic CardList with Icons"
                fontSize: "large"
                font.bold: true
            }

            CardList {
                height: units.gu(25)
                width: parent.width
                items: [{
                        "title": "Messages",
                        "subtitle": "12 unread messages",
                        "icon": "message"
                    }, {
                        "title": "Contacts",
                        "subtitle": "45 contacts",
                        "icon": "contact"
                    }, {
                        "title": "Calendar",
                        "subtitle": "3 events today",
                        "icon": "calendar"
                    }, {
                        "title": "Settings",
                        "subtitle": "System preferences",
                        "icon": "settings"
                    }]
                emptyMessage: i18n.tr("No items available")
                onItemClicked: feedbackLabel.text = "Basic list: " + item.title + " clicked"
            }

            Label {
                text: "CardList with Search Bar"
                fontSize: "large"
                font.bold: true
            }

            CardList {
                height: units.gu(30)
                width: parent.width
                showSearchBar: true
                searchPlaceholder: i18n.tr("Search countries...")
                items: [{
                        "title": "Argentina",
                        "subtitle": "Buenos Aires",
                        "icon": "location"
                    }, {
                        "title": "Brazil",
                        "subtitle": "Brasília",
                        "icon": "location"
                    }, {
                        "title": "Canada",
                        "subtitle": "Ottawa",
                        "icon": "location"
                    }, {
                        "title": "Denmark",
                        "subtitle": "Copenhagen",
                        "icon": "location"
                    }, {
                        "title": "Egypt",
                        "subtitle": "Cairo",
                        "icon": "location"
                    }, {
                        "title": "France",
                        "subtitle": "Paris",
                        "icon": "location"
                    }, {
                        "title": "Germany",
                        "subtitle": "Berlin",
                        "icon": "location"
                    }, {
                        "title": "Hungary",
                        "subtitle": "Budapest",
                        "icon": "location"
                    }]
                onItemClicked: feedbackLabel.text = "Searched: " + item.title + " - " + item.subtitle
            }

            Label {
                text: "CardList with Thumbnails"
                fontSize: "large"
                font.bold: true
            }

            CardList {
                height: units.gu(20)
                width: parent.width
                items: [{
                        "title": "Photo Album 1",
                        "subtitle": "128 photos",
                        "thumbnailSource": "https://brennoflavio.com.br/trips/ouro-preto/10.jpg"
                    }, {
                        "title": "Photo Album 2",
                        "subtitle": "256 photos",
                        "thumbnailSource": "https://brennoflavio.com.br/trips/ouro-preto/10.jpg"
                    }, {
                        "title": "Photo Album 3",
                        "subtitle": "64 photos",
                        "thumbnailSource": "https://brennoflavio.com.br/trips/ouro-preto/10.jpg"
                    }]
                emptyMessage: i18n.tr("No albums found")
                onItemClicked: feedbackLabel.text = "Album: " + item.title + " selected"
            }

            Label {
                text: "Mixed Content CardList"
                fontSize: "large"
                font.bold: true
            }

            CardList {
                height: units.gu(25)
                width: parent.width
                showSearchBar: true
                searchPlaceholder: i18n.tr("Search files...")
                items: [{
                        "title": "Document.pdf",
                        "subtitle": "2.5 MB",
                        "icon": "text-x-generic"
                    }, {
                        "title": "Vacation.jpg",
                        "subtitle": "4.2 MB",
                        "thumbnailSource": "https://brennoflavio.com.br/trips/ouro-preto/10.jpg"
                    }, {
                        "title": "Music.mp3",
                        "subtitle": "5.8 MB",
                        "icon": "audio-x-generic"
                    }, {
                        "title": "Video.mp4",
                        "subtitle": "125 MB",
                        "icon": "video-x-generic"
                    }, {
                        "title": "Archive.zip",
                        "subtitle": "8.3 MB",
                        "icon": "package-x-generic"
                    }, {
                        "title": "Presentation.ppt",
                        "subtitle": "3.1 MB",
                        "icon": "x-office-presentation"
                    }]
                onItemClicked: feedbackLabel.text = "File: " + item.title + " (" + item.subtitle + ")"
            }

            Label {
                text: "Empty State Example"
                fontSize: "large"
                font.bold: true
            }

            CardList {
                height: units.gu(15)
                width: parent.width
                items: []
                emptyMessage: i18n.tr("No data to display")
                showSearchBar: true
                searchPlaceholder: i18n.tr("Search...")
                onItemClicked: feedbackLabel.text = "Empty list item clicked"
            }

            Label {
                text: "Long List with Scrolling"
                fontSize: "large"
                font.bold: true
            }

            CardList {
                height: units.gu(30)
                width: parent.width
                showSearchBar: true
                searchPlaceholder: i18n.tr("Search apps...")
                items: {
                    var apps = [];
                    var appNames = ["Calculator", "Camera", "Clock", "Contacts", "Documents", "Email", "Files", "Gallery", "Maps", "Messages", "Music", "Notes", "Phone", "Settings", "Terminal", "Weather", "Browser", "Calendar", "Store", "Games"];
                    for (var i = 0; i < appNames.length; i++) {
                        apps.push({
                                "title": appNames[i],
                                "subtitle": "Version " + (i + 1) + ".0",
                                "icon": i % 3 === 0 ? "application-default-icon" : i % 3 === 1 ? "starred" : "stock_application"
                            });
                    }
                    return apps;
                }
                onItemClicked: feedbackLabel.text = "App: " + item.title + " launched"
            }

            Label {
                text: "CardList without Subtitle"
                fontSize: "large"
                font.bold: true
            }

            CardList {
                height: units.gu(20)
                width: parent.width
                items: [{
                        "title": "Home",
                        "icon": "go-home"
                    }, {
                        "title": "Search",
                        "icon": "find"
                    }, {
                        "title": "Favorites",
                        "icon": "starred"
                    }, {
                        "title": "Downloads",
                        "icon": "save"
                    }, {
                        "title": "Profile",
                        "icon": "contact"
                    }]
                onItemClicked: feedbackLabel.text = "Navigation: " + item.title
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
