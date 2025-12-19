import Lomiri.Components 1.3
import QtQuick 2.12
import "qml"

Page {
    id: configurationGroupPage

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

            ConfigurationGroup {
                title: "Appearance Settings"

                ToggleOption {
                    title: "Dark Mode"
                    subtitle: "Use dark theme throughout the app"
                    checked: false
                    onToggled: feedbackLabel.text = "Dark mode: " + (checked ? "enabled" : "disabled")
                }

                ToggleOption {
                    title: "High Contrast"
                    subtitle: "Improve visibility with higher contrast"
                    checked: false
                    enabled: true
                    onToggled: feedbackLabel.text = "High contrast: " + (checked ? "enabled" : "disabled")
                }

                ToggleOption {
                    title: "Animations"
                    subtitle: "Enable UI animations"
                    checked: true
                    onToggled: feedbackLabel.text = "Animations: " + (checked ? "enabled" : "disabled")
                }

            }

            ConfigurationGroup {
                title: "User Profile"

                InputField {
                    title: "Username"
                    placeholder: "Enter your username"
                    text: "john_doe"
                    onTextChanged: feedbackLabel.text = "Username changed: " + text
                }

                InputField {
                    title: "Email"
                    placeholder: "user@example.com"
                    required: true
                    validationRegex: "^[\\w\\.-]+@[\\w\\.-]+\\.\\w+$"
                    errorMessage: "Please enter a valid email address"
                    onTextChanged: feedbackLabel.text = "Email: " + (isValid ? text : "invalid")
                }

                InputField {
                    title: "Password"
                    placeholder: "Enter secure password"
                    echoMode: TextInput.Password
                    required: true
                    onTextChanged: feedbackLabel.text = "Password length: " + text.length
                }

            }

            ConfigurationGroup {
                title: "Display Settings"

                NumberOption {
                    title: "Font Size"
                    subtitle: "Default text size"
                    value: 14
                    minimumValue: 8
                    maximumValue: 32
                    suffix: "pt"
                    onValueUpdated: feedbackLabel.text = "Font size: " + newValue + "pt"
                }

                NumberOption {
                    title: "Screen Brightness"
                    subtitle: "Adjust display brightness"
                    value: 75
                    minimumValue: 0
                    maximumValue: 100
                    suffix: "%"
                    onValueUpdated: feedbackLabel.text = "Brightness: " + newValue + "%"
                }

                NumberOption {
                    title: "Screen Timeout"
                    subtitle: "Time before screen turns off"
                    value: 30
                    minimumValue: 10
                    maximumValue: 300
                    suffix: " sec"
                    onValueUpdated: feedbackLabel.text = "Timeout: " + newValue + " seconds"
                }

            }

            ConfigurationGroup {
                title: "Network Settings"

                ToggleOption {
                    title: "Wi-Fi"
                    subtitle: "Connect to wireless networks"
                    checked: true
                    onToggled: feedbackLabel.text = "Wi-Fi: " + (checked ? "enabled" : "disabled")
                }

                ToggleOption {
                    title: "Mobile Data"
                    subtitle: "Use cellular data connection"
                    checked: false
                    onToggled: feedbackLabel.text = "Mobile data: " + (checked ? "enabled" : "disabled")
                }

                InputField {
                    title: "Proxy Server"
                    placeholder: "proxy.example.com:8080"
                    validationRegex: "^([a-zA-Z0-9\\.-]+)(:[0-9]+)?$"
                    errorMessage: "Invalid proxy format"
                    onTextChanged: feedbackLabel.text = "Proxy: " + (text ? text : "not configured")
                }

                NumberOption {
                    title: "Connection Timeout"
                    subtitle: "Max wait time for connections"
                    value: 30
                    minimumValue: 5
                    maximumValue: 120
                    suffix: " sec"
                    onValueUpdated: feedbackLabel.text = "Timeout: " + newValue + " seconds"
                }

            }

            ConfigurationGroup {
                title: "Notifications"

                ToggleOption {
                    title: "Push Notifications"
                    checked: true
                    onToggled: feedbackLabel.text = "Push notifications: " + (checked ? "on" : "off")
                }

                ToggleOption {
                    title: "Sound Alerts"
                    subtitle: "Play sounds for notifications"
                    checked: true
                    onToggled: feedbackLabel.text = "Sound alerts: " + (checked ? "on" : "off")
                }

                ToggleOption {
                    title: "Vibration"
                    subtitle: "Vibrate on notifications"
                    checked: false
                    enabled: true
                    onToggled: feedbackLabel.text = "Vibration: " + (checked ? "on" : "off")
                }

            }

            ConfigurationGroup {
                title: "Advanced Settings"

                ToggleOption {
                    title: "Developer Mode"
                    subtitle: "Enable developer options"
                    checked: false
                    onToggled: feedbackLabel.text = "Developer mode: " + (checked ? "enabled" : "disabled")
                }

                NumberOption {
                    title: "Cache Size"
                    subtitle: "Maximum cache storage"
                    value: 100
                    minimumValue: 10
                    maximumValue: 500
                    suffix: " MB"
                    onValueUpdated: feedbackLabel.text = "Cache size: " + newValue + " MB"
                }

                InputField {
                    title: "Custom Server"
                    placeholder: "https://api.example.com"
                    validationRegex: "^https?://[a-zA-Z0-9\\.-]+(:[0-9]+)?(/.*)?$"
                    errorMessage: "Enter a valid URL"
                    onTextChanged: feedbackLabel.text = "Server: " + (isValid ? "valid URL" : "invalid URL")
                }

            }

            ConfigurationGroup {
                title: "Temperature Control"

                NumberOption {
                    title: "Indoor Temperature"
                    subtitle: "Target temperature"
                    value: 20
                    minimumValue: -10
                    maximumValue: 40
                    suffix: "°C"
                    onValueUpdated: feedbackLabel.text = "Temperature set to: " + newValue + "°C"
                }

                NumberOption {
                    title: "Temperature Offset"
                    subtitle: "Calibration adjustment"
                    value: 0
                    minimumValue: -5
                    maximumValue: 5
                    suffix: "°C"
                    onValueUpdated: feedbackLabel.text = "Offset: " + newValue + "°C"
                }

            }

            ConfigurationGroup {
                title: "Disabled Controls Demo"

                ToggleOption {
                    title: "Disabled Toggle"
                    subtitle: "This toggle is disabled"
                    checked: true
                    enabled: false
                }

                NumberOption {
                    title: "Read-only Value"
                    subtitle: "This field is not editable"
                    value: 42
                    enabled: false
                    suffix: " units"
                }

            }

            ConfigurationGroup {
                title: "Empty Group Example"
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

        pageTitle: "ConfigurationGroupPage"
        isRootPage: false
        appIconName: ""
        showSettingsButton: true
        onSettingsClicked: {
            feedbackLabel.text = "Header: Settings button clicked!";
        }
    }

}
