import Lomiri.Components 1.3
import QtQuick 2.12
import io.thp.pyotherside 1.4
import "qml"

Page {
    id: eventPage

    visible: false
    anchors.fill: parent

    Label {
        id: feedbackLabel

        text: "Event functionality showcase"
        font.bold: true
        visible: true
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WordWrap

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
                id: timeTitle

                text: "Fetch Time Event: Auto scheduled every 5 seconds"
                font.bold: true
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
            }

            Label {
                id: timeLabel

                text: "Waiting for time..."
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
            }

            Label {
                id: randomTitle

                text: "Random Number Event: Schedules itself every 3 seconds"
                font.bold: true
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
            }

            Label {
                id: randomNumberLabel

                text: "Waiting for random number..."
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
            }

            Label {
                id: previousNumberLabel

                text: ""
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
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

    }

    Python {
        id: eventLoop

        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('.'));
            importModule('event_page', function() {
                setHandler('fetch-time', function(result) {
                    timeLabel.text = "Current time: " + result.time;
                });
                setHandler('random-number', function(result) {
                    randomNumberLabel.text = "Random number: " + result.number;
                    previousNumberLabel.text = "Previous: " + result.previous;
                });
                call('event_page.start_loop', [], function() {
                });
            });
        }
        Component.onDestruction: {
            call('event_page.stop_loop', [], function() {
            });
        }
        onError: {
            console.log('python error: ' + traceback);
        }
    }

    header: AppHeader {
        id: pageHeader

        pageTitle: "EventPage"
        isRootPage: false
        appIconName: ""
        showSettingsButton: false
    }

}
