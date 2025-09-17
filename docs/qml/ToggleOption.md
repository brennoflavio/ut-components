# ToggleOption

A list item component with a toggle switch for boolean settings in Ubuntu Touch applications. Displays a title and optional subtitle on the left side, with a Switch control on the right. Includes a bottom separator line for seamless list layouts.

## Properties

- `title` (string): The main text label displayed for this toggle option
- `subtitle` (string): Optional secondary text displayed below the title (default: "")
- `checked` (bool): The current state of the toggle switch (default: false)
- `enabled` (bool): Whether the toggle switch is interactive (default: true)

## Signals

- `toggled(checked)`: Emitted when the toggle switch state changes, passes the new checked state

## Example Usage

### Simple Toggle
```qml
import "ut_components"

ToggleOption {
    title: "Enable Notifications"
    checked: true
    onToggled: settings.notifications = checked
}
```

### Toggle with Subtitle
```qml
import "ut_components"

ToggleOption {
    title: "Dark Mode"
    subtitle: "Use dark theme throughout the application"
    checked: false
    onToggled: {
        settings.darkMode = checked
        theme.applyDarkMode(checked)
    }
}
```

### Settings List
```qml
import "ut_components"

Column {
    width: parent.width

    ToggleOption {
        title: "Auto-sync"
        subtitle: "Sync data automatically every hour"
        checked: settings.autoSync
        onToggled: settings.autoSync = checked
    }

    ToggleOption {
        title: "Location Services"
        subtitle: "Allow apps to access your location"
        checked: settings.locationEnabled
        enabled: hasLocationPermission
        onToggled: settings.locationEnabled = checked
    }

    ToggleOption {
        title: "Developer Mode"
        subtitle: "Show advanced developer options"
        checked: settings.developerMode
        onToggled: settings.developerMode = checked
    }
}
```

### Disabled State
```qml
import "ut_components"

ToggleOption {
    title: "Premium Features"
    subtitle: "Upgrade to premium to enable"
    checked: false
    enabled: isPremiumUser
    onToggled: activatePremiumFeatures()
}
```
