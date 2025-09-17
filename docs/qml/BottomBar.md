# BottomBar

A bottom navigation bar component that provides three distinct sections for organizing actions in Ubuntu Touch applications. Features optional left/right buttons and a center area for multiple actions.

## Properties

- `leftButton` (Item): Optional button component to display on the left side
- `rightButton` (Item): Optional button component to display on the right side
- `middleButtons` (default property): Child items placed in the center row - buttons can be added as direct children

## Example Usage

### Full Navigation Bar
```qml
import "ut_components"

Page {
    footer: BottomBar {
        leftButton: IconButton {
            iconName: "back"
            text: "Back"
            onClicked: pageStack.pop()
        }
        rightButton: IconButton {
            iconName: "forward"
            text: "Forward"
            onClicked: navigateForward()
        }

        // Middle buttons as children
        IconButton {
            iconName: "home"
            onClicked: goHome()
        }
        IconButton {
            iconName: "search"
            onClicked: openSearch()
        }
    }
}
```

### Center Actions Only
```qml
import "ut_components"

Page {
    footer: BottomBar {
        IconButton {
            iconName: "action"
            text: "Action 1"
        }
        IconButton {
            iconName: "action"
            text: "Action 2"
        }
        IconButton {
            iconName: "action"
            text: "Action 3"
        }
    }
}
```
