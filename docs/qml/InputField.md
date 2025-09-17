# InputField

A text input component with built-in validation and error handling for Ubuntu Touch applications. Provides a comprehensive text input solution with title label, placeholder text, real-time validation, required field support, and error message display.

## Properties

- `title` (string): The label text displayed above the input field
- `placeholder` (string): Placeholder text shown when the field is empty
- `text` (string): The current text value in the input field (read/write)
- `echoMode` (TextInput.EchoMode): The echo mode for the text field (default: TextInput.Normal)
- `validationRegex` (string): Regular expression pattern for input validation (default: "")
- `errorMessage` (string): Custom error message shown when validation fails (default: "Invalid input")
- `required` (bool): Whether this field is required - must not be empty (default: false)

## Signals

- `textChanged`: Emitted when the text in the field changes (inherited from TextField)

## Example Usage

### Basic Text Input
```qml
import "ut_components"

InputField {
    title: "Username"
    placeholder: "Enter your username"
    onTextChanged: console.log("Username:", text)
}
```

### Required Field
```qml
import "ut_components"

InputField {
    title: "Full Name"
    placeholder: "Enter your full name"
    required: true
    onTextChanged: settings.fullName = text
}
```

### Password Field
```qml
import "ut_components"

InputField {
    title: "Password"
    placeholder: "Enter secure password"
    echoMode: TextInput.Password
    required: true
    onTextChanged: validatePassword(text)
}
```

### Email with Validation
```qml
import "ut_components"

InputField {
    title: "Email Address"
    placeholder: "user@example.com"
    required: true
    validationRegex: "^[\\w\\.-]+@[\\w\\.-]+\\.\\w+$"
    errorMessage: "Please enter a valid email address"
    onTextChanged: userProfile.email = text
}
```

### Phone Number Validation
```qml
import "ut_components"

InputField {
    title: "Phone Number"
    placeholder: "+1-234-567-8900"
    validationRegex: "^[+]?[0-9\\s\\-()]+$"
    errorMessage: "Invalid phone number format"
    onTextChanged: contact.phone = text
}
```

### ZIP Code with Custom Error
```qml
import "ut_components"

InputField {
    title: "ZIP Code"
    placeholder: "12345"
    validationRegex: "^\\d{5}(-\\d{4})?$"
    errorMessage: "ZIP code must be 5 digits or 5+4 format"
    onTextChanged: address.zipCode = text
}
```

### Form with Multiple Fields
```qml
import "ut_components"

Column {
    width: parent.width
    spacing: units.gu(2)

    InputField {
        title: "Username"
        placeholder: "Choose a username"
        required: true
        validationRegex: "^[a-zA-Z0-9_]{3,20}$"
        errorMessage: "Username must be 3-20 characters (letters, numbers, underscore)"
    }

    InputField {
        title: "Email"
        placeholder: "your@email.com"
        required: true
        validationRegex: "^[\\w\\.-]+@[\\w\\.-]+\\.\\w+$"
        errorMessage: "Please enter a valid email"
    }

    InputField {
        title: "Password"
        placeholder: "Minimum 8 characters"
        echoMode: TextInput.Password
        required: true
        validationRegex: ".{8,}"
        errorMessage: "Password must be at least 8 characters"
    }
}
```
