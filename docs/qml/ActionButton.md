# ActionButton

A prominent button component for primary actions in Ubuntu Touch applications. Features a rounded design with icon and text label, customizable colors, and visual feedback on interaction.

## Properties

- `text` (string): The button label text to display
- `iconName` (string): Name of the icon to display (default: "add")
- `backgroundColor` (color): Background color of the button (default: theme.palette.normal.positive)
- `textColor` (color): Color of the text label (default: white)
- `iconColor` (color): Color of the icon (default: white)
- `enabled` (bool): Whether the button is enabled for interaction (default: true)

## Signals

- `clicked`: Emitted when the button is pressed

## Example Usage

### Default Action
```qml
import "ut_components"

ActionButton {
    text: "Add New Item"
    iconName: "add"
    onClicked: createNewItem()
}
```

### Destructive Action
```qml
import "ut_components"

ActionButton {
    text: "Delete"
    iconName: "delete"
    backgroundColor: theme.palette.normal.negative
    onClicked: confirmDelete()
}
```

### Custom Styling with Disabled State
```qml
import "ut_components"

ActionButton {
    text: "Save Changes"
    iconName: "save"
    backgroundColor: "#4CAF50"
    textColor: "#FFFFFF"
    iconColor: "#FFFFFF"
    enabled: hasUnsavedChanges
    onClicked: saveData()
}
```
