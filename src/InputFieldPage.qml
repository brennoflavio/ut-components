import QtQuick 2.12
import Lomiri.Components 1.3
import "ut_components"

Page {
    id: inputFieldPage
    visible: false
    anchors.fill: parent

    header: AppHeader {
        id: pageHeader
        pageTitle: "InputFieldPage"
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

            InputField {
                id: basicInput
                title: "Basic Text Input"
                placeholder: "Type something here..."
                width: parent.width
                onTextChanged: feedbackLabel.text = "Basic input: " + text
            }

            InputField {
                id: requiredInput
                title: "Required Field"
                placeholder: "This field is mandatory"
                required: true
                width: parent.width
                onTextChanged: {
                    if (isValid) {
                        feedbackLabel.text = "Required field valid: " + text;
                    } else {
                        feedbackLabel.text = "Required field is empty";
                    }
                }
            }

            InputField {
                id: emailInput
                title: "Email Address"
                placeholder: "user@example.com"
                required: true
                validationRegex: "^[\\w\\.-]+@[\\w\\.-]+\\.\\w+$"
                errorMessage: "Please enter a valid email address"
                width: parent.width
                onTextChanged: {
                    if (isValid) {
                        feedbackLabel.text = "Valid email: " + text;
                    } else if (text.length > 0) {
                        feedbackLabel.text = "Invalid email format";
                    }
                }
            }

            InputField {
                id: phoneInput
                title: "Phone Number"
                placeholder: "+1 234 567 8900"
                validationRegex: "^[+]?[0-9\\s\\-()]+$"
                errorMessage: "Please enter a valid phone number"
                width: parent.width
                onTextChanged: {
                    if (isValid && text.length > 0) {
                        feedbackLabel.text = "Valid phone: " + text;
                    }
                }
            }

            InputField {
                id: passwordInput
                title: "Password"
                placeholder: "Enter secure password"
                echoMode: TextInput.Password
                required: true
                width: parent.width
                onTextChanged: {
                    if (text.length > 0) {
                        feedbackLabel.text = "Password length: " + text.length + " characters";
                    }
                }
            }

            InputField {
                id: passwordEditInput
                title: "Password (Echo on Edit)"
                placeholder: "Shows text while typing"
                echoMode: TextInput.PasswordEchoOnEdit
                width: parent.width
                onTextChanged: {
                    if (text.length > 0) {
                        feedbackLabel.text = "Password echo on edit: " + text.length + " chars";
                    }
                }
            }

            InputField {
                id: zipCodeInput
                title: "ZIP Code (US Format)"
                placeholder: "12345 or 12345-6789"
                validationRegex: "^\\d{5}(-\\d{4})?$"
                errorMessage: "Enter a valid ZIP code"
                width: parent.width
                onTextChanged: {
                    if (isValid && text.length > 0) {
                        feedbackLabel.text = "Valid ZIP: " + text;
                    }
                }
            }

            InputField {
                id: urlInput
                title: "Website URL"
                placeholder: "https://example.com"
                validationRegex: "^https?://[\\w\\.-]+(\\.[\\w\\.-]+)+.*$"
                errorMessage: "Please enter a valid URL"
                width: parent.width
                onTextChanged: {
                    if (isValid && text.length > 0) {
                        feedbackLabel.text = "Valid URL: " + text;
                    }
                }
            }

            InputField {
                id: alphanumericInput
                title: "Username (Alphanumeric)"
                placeholder: "user_name123"
                validationRegex: "^[a-zA-Z0-9_]+$"
                errorMessage: "Only letters, numbers and underscores"
                width: parent.width
                onTextChanged: {
                    if (isValid && text.length > 0) {
                        feedbackLabel.text = "Valid username: " + text;
                    }
                }
            }

            InputField {
                id: numberInput
                title: "Number Only"
                placeholder: "Enter a number"
                validationRegex: "^-?\\d+(\\.\\d+)?$"
                errorMessage: "Please enter a valid number"
                width: parent.width
                onTextChanged: {
                    if (isValid && text.length > 0) {
                        feedbackLabel.text = "Valid number: " + text;
                    }
                }
            }

            Label {
                text: "Form Validation Example"
                font.bold: true
                width: parent.width
            }

            InputField {
                id: formNameInput
                title: "Full Name"
                placeholder: "John Doe"
                required: true
                width: parent.width
            }

            InputField {
                id: formEmailInput
                title: "Email"
                placeholder: "john@example.com"
                required: true
                validationRegex: "^[\\w\\.-]+@[\\w\\.-]+\\.\\w+$"
                errorMessage: "Invalid email format"
                width: parent.width
            }

            Button {
                text: "Submit Form"
                color: theme.palette.normal.positive
                width: parent.width
                enabled: formNameInput.isValid && formEmailInput.isValid
                onClicked: {
                    feedbackLabel.text = "Form submitted! Name: " + formNameInput.text + ", Email: " + formEmailInput.text;
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
