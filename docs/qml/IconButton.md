# IconButton

![](./images/IconButton.jpg)

A circular button component that displays an icon with an optional text label below. Features smooth press animation and adapts its size based on content.

## Properties

- `iconName` (string): Theme icon name used when `iconSource` is empty (default: "settings")
- `iconSource` (url): Optional custom icon file URL. When set, it takes precedence over `iconName`.
- `text` (string): Optional text label to display below the icon (default: "")

## Signals

- `clicked`: Emitted when the button is pressed

## Example Usage

### Icon Only
```qml
import "ut_components"

IconButton {
    iconName: "add"
    onClicked: console.log("Add button clicked")
}
```

### Custom SVG Source
```qml
import "ut_components"

IconButton {
    iconName: "edit"
    iconSource: Qt.resolvedUrl("../assets/logo.svg")
    text: "Brand"
    onClicked: pageStack.push(brandPage)
}
```

`iconSource` is optional, but when both properties are provided it overrides `iconName`.

### Icon with Text Label
```qml
import "ut_components"

IconButton {
    iconName: "edit"
    text: "Edit"
    onClicked: pageStack.push(editPage)
}
```
