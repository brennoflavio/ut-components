# Toast

![](./images/Toast.jpg)

A brief notification popup that appears at the bottom of the screen to provide quick feedback to the user. The toast automatically fades in, displays for a specified duration, and then fades out.

## Properties

- `message` (string): The text message to display in the toast
- `duration` (int): Duration in milliseconds to display the toast, excluding fade animations. Default: 800
- `bottomMargin` (real): Distance from the bottom of the parent component. Default: units.gu(8)

## Functions

- `show(text)`: Shows the toast with the specified text message. If no text is provided, shows the current message property value.

## Example Usage

### Basic Toast
```qml
import "ut_components"

Page {
    Toast {
        id: toast
    }

    Button {
        text: "Show Toast"
        onClicked: toast.show("Action completed!")
    }
}
```

### Custom Duration
```qml
import "ut_components"

Page {
    Toast {
        id: longToast
        duration: 2000
    }

    Button {
        text: "Show Long Toast"
        onClicked: longToast.show("This message stays longer")
    }
}
```

### Custom Position
```qml
import "ut_components"

Page {
    Toast {
        id: highToast
        bottomMargin: units.gu(20)
    }

    Button {
        text: "Show Higher Toast"
        onClicked: highToast.show("I'm positioned higher!")
    }
}
```

### Setting Message Separately
```qml
import "ut_components"

Page {
    Toast {
        id: toast
        message: "File saved successfully"
    }

    Button {
        text: "Save"
        onClicked: toast.show()
    }
}
```
