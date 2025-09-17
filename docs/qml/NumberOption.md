# NumberOption

A numeric input field component with labels for Ubuntu Touch applications. Displays a title and optional subtitle on the left with an editable numeric field on the right. Includes min/max validation, optional suffix display, and support for negative numbers.

## Properties

- `title` (string): The main label displayed on the left side
- `subtitle` (string): Optional secondary text displayed below the title (default: "")
- `value` (int): The current numeric value (default: 0)
- `minimumValue` (int): The minimum allowed value, supports negative numbers (default: 0)
- `maximumValue` (int): The maximum allowed value (default: 999999)
- `suffix` (string): Optional suffix text displayed after the value, e.g., "km", "%", "°C" (default: "")
- `enabled` (bool): Whether the input field is editable (default: true)

## Signals

- `valueUpdated(newValue)`: Emitted when the value changes and passes validation

## Example Usage

### Basic Number Input
```qml
import "ut_components"

NumberOption {
    title: "Age"
    subtitle: "Enter your age"
    value: 25
    minimumValue: 0
    maximumValue: 120
    onValueUpdated: console.log("Age changed to", newValue)
}
```

### With Unit Suffix
```qml
import "ut_components"

NumberOption {
    title: "Distance"
    subtitle: "Maximum search radius"
    value: 50
    minimumValue: 1
    maximumValue: 500
    suffix: "km"
    onValueUpdated: updateSearchRadius(newValue)
}
```

### Negative Values and Temperature
```qml
import "ut_components"

NumberOption {
    title: "Temperature"
    subtitle: "Target temperature"
    value: 20
    minimumValue: -50
    maximumValue: 60
    suffix: "°C"
    onValueUpdated: thermostat.setTarget(newValue)
}
```

### Read-Only Display
```qml
import "ut_components"

NumberOption {
    title: "Progress"
    subtitle: "Current completion"
    value: 75
    minimumValue: 0
    maximumValue: 100
    suffix: "%"
    enabled: false
}
```

### Large Values with Currency
```qml
import "ut_components"

NumberOption {
    title: "Budget"
    subtitle: "Annual allocation"
    value: 50000
    minimumValue: 1000
    maximumValue: 999999
    suffix: "$"
    onValueUpdated: {
        budget.amount = newValue
        recalculateAllocations()
    }
}
```
