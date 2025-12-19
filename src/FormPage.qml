import Lomiri.Components 1.3
import QtQuick 2.12
import "qml"

Page {
    id: formPage

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
                text: "Login Form - Basic Example"
                fontSize: "large"
                font.bold: true
                color: theme.palette.normal.foregroundText
            }

            Form {
                id: loginForm

                buttonText: i18n.tr("Sign In")
                buttonIconName: "go-next"
                onSubmitted: {
                    feedbackLabel.text = "Login Form submitted successfully!";
                }

                InputField {
                    title: "Username"
                    placeholder: "Enter your username"
                    required: true
                    validationRegex: "^.{3,}$"
                    errorMessage: "Username must be at least 3 characters"
                }

                InputField {
                    title: "Password"
                    placeholder: "Enter your password"
                    echoMode: TextInput.Password
                    required: true
                    validationRegex: "^.{8,}$"
                    errorMessage: "Password must be at least 8 characters"
                }

                ToggleOption {
                    title: "Remember me"
                    subtitle: "Save credentials for next time"
                    checked: false
                    onToggled: feedbackLabel.text = "Remember me: " + (checked ? "enabled" : "disabled")
                }

            }

            Rectangle {
                width: parent.width
                height: units.dp(1)
                color: theme.palette.normal.base
            }

            Label {
                text: "Registration Form - Advanced Example"
                fontSize: "large"
                font.bold: true
                color: theme.palette.normal.foregroundText
            }

            Form {
                id: registrationForm

                buttonText: i18n.tr("Create Account")
                buttonIconName: "contact-new"
                onSubmitted: {
                    feedbackLabel.text = "Registration Form submitted - Account created!";
                }

                InputField {
                    title: "Full Name"
                    placeholder: "John Doe"
                    required: true
                    validationRegex: "^\\w+\\s+\\w.*$"
                    errorMessage: "Please enter your full name"
                }

                InputField {
                    title: "Email"
                    placeholder: "john.doe@example.com"
                    required: true
                    validationRegex: "^[\\w\\.-]+@[\\w\\.-]+\\.\\w+$"
                    errorMessage: "Please enter a valid email address"
                }

                InputField {
                    title: "Phone Number"
                    placeholder: "+1 234 567 8900"
                    validationRegex: "^[+]?[0-9\\s\\-()]+$"
                    errorMessage: "Invalid phone number format"
                }

                NumberOption {
                    title: "Age"
                    subtitle: "Must be 18 or older"
                    value: 18
                    minimumValue: 18
                    maximumValue: 120
                    suffix: "years"
                    onValueUpdated: feedbackLabel.text = "Age set to: " + newValue + " years"
                }

                InputField {
                    id: passwordField

                    title: "Password"
                    placeholder: "Create a strong password"
                    echoMode: TextInput.Password
                    required: true
                    validationRegex: "^(?=.*[A-Z])(?=.*[0-9]).{8,}$"
                    errorMessage: "Password must be 8+ chars with uppercase and number"
                }

                InputField {
                    property bool isValid: text === passwordField.text && text.length > 0

                    title: "Confirm Password"
                    placeholder: "Re-enter your password"
                    echoMode: TextInput.Password
                    required: true
                    validationRegex: "^.+$"
                    errorMessage: "Passwords do not match"
                }

                ToggleOption {
                    property bool isValid: checked

                    title: "Accept Terms & Conditions"
                    subtitle: "I agree to the terms of service"
                    checked: false
                    onToggled: feedbackLabel.text = "Terms: " + (checked ? "accepted" : "not accepted")
                }

                ToggleOption {
                    title: "Newsletter"
                    subtitle: "Receive updates and promotions"
                    checked: true
                    onToggled: feedbackLabel.text = "Newsletter: " + (checked ? "subscribed" : "unsubscribed")
                }

            }

            Rectangle {
                width: parent.width
                height: units.dp(1)
                color: theme.palette.normal.base
            }

            Label {
                text: "Settings Form - Mixed Controls"
                fontSize: "large"
                font.bold: true
                color: theme.palette.normal.foregroundText
            }

            Form {
                id: settingsForm

                buttonText: i18n.tr("Save Settings")
                buttonIconName: "save"
                onSubmitted: {
                    feedbackLabel.text = "Settings saved successfully!";
                }

                InputField {
                    title: "Display Name"
                    placeholder: "Your display name"
                    text: "John Doe"
                    required: true
                }

                NumberOption {
                    title: "Font Size"
                    subtitle: "Adjust text size"
                    value: 14
                    minimumValue: 10
                    maximumValue: 24
                    suffix: "pt"
                    onValueUpdated: feedbackLabel.text = "Font size changed to: " + newValue + "pt"
                }

                NumberOption {
                    title: "Auto-save Interval"
                    subtitle: "Minutes between saves"
                    value: 5
                    minimumValue: 1
                    maximumValue: 60
                    suffix: "min"
                    onValueUpdated: feedbackLabel.text = "Auto-save every: " + newValue + " minutes"
                }

                ToggleOption {
                    title: "Dark Mode"
                    subtitle: "Use dark theme"
                    checked: true
                    onToggled: feedbackLabel.text = "Dark mode: " + (checked ? "enabled" : "disabled")
                }

                ToggleOption {
                    title: "Notifications"
                    subtitle: "Show system notifications"
                    checked: true
                    onToggled: feedbackLabel.text = "Notifications: " + (checked ? "enabled" : "disabled")
                }

                ToggleOption {
                    title: "Analytics"
                    subtitle: "Help improve the app"
                    checked: false
                    onToggled: feedbackLabel.text = "Analytics: " + (checked ? "enabled" : "disabled")
                }

            }

            Rectangle {
                width: parent.width
                height: units.dp(1)
                color: theme.palette.normal.base
            }

            Label {
                text: "Contact Form - Validation Example"
                fontSize: "large"
                font.bold: true
                color: theme.palette.normal.foregroundText
            }

            Form {
                id: contactForm

                buttonText: i18n.tr("Send Message")
                buttonIconName: "message-new"
                onSubmitted: {
                    feedbackLabel.text = "Contact message sent successfully!";
                }

                InputField {
                    title: "Your Name"
                    placeholder: "Enter your name"
                    required: true
                    validationRegex: "^.{2,}$"
                    errorMessage: "Name is too short"
                }

                InputField {
                    title: "Email Address"
                    placeholder: "your@email.com"
                    required: true
                    validationRegex: "^[\\w\\.-]+@[\\w\\.-]+\\.\\w+$"
                    errorMessage: "Invalid email format"
                }

                InputField {
                    title: "Subject"
                    placeholder: "What is this about?"
                    required: true
                    validationRegex: "^.{5,}$"
                    errorMessage: "Subject must be at least 5 characters"
                }

                NumberOption {
                    title: "Priority"
                    subtitle: "1 = Low, 5 = High"
                    value: 3
                    minimumValue: 1
                    maximumValue: 5
                    onValueUpdated: feedbackLabel.text = "Priority set to: " + newValue
                }

            }

            Rectangle {
                width: parent.width
                height: units.dp(1)
                color: theme.palette.normal.base
            }

            Label {
                text: "Minimal Form - Simple Example"
                fontSize: "large"
                font.bold: true
                color: theme.palette.normal.foregroundText
            }

            Form {
                id: minimalForm

                buttonText: i18n.tr("Submit")
                onSubmitted: {
                    feedbackLabel.text = "Search submitted for: " + fields[0].text;
                }

                InputField {
                    title: "Search Query"
                    placeholder: "Enter search terms..."
                    required: true
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

        pageTitle: "FormPage"
        isRootPage: false
        appIconName: ""
        showSettingsButton: true
        onSettingsClicked: {
            feedbackLabel.text = "Header: Settings button clicked!";
        }
    }

}
