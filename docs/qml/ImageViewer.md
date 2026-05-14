# ImageViewer

A reusable image viewer that standardizes image display across Ubuntu Touch applications. It combines pinch zoom, panning while zoomed, double tap zoom, app-driven adjacent navigation, and optional previous/next buttons in a single component.

This is the component intended for image detail experiences where the application owns gallery state and can later evolve to infinite or mixed-media navigation.

## Properties

- `currentItem` (var): Active image to render.
- `previousItem` (var): Previous adjacent image state.
- `nextItem` (var): Next adjacent image state.
- `maximumZoom` (real): Maximum zoom multiplier allowed by pinch and double tap (default: `10`).
- `navigationEnabled` (bool): Enables previous/next navigation logic (default: `true`).
- `swipeNavigationEnabled` (bool): Enables horizontal swipe navigation intent (default: `true`).
- `showNavigationButtons` (bool): Shows previous/next overlay buttons (default: `true`).
- `canGoPrevious` (bool, read-only): Whether the previous side is currently available.
- `canGoNext` (bool, read-only): Whether the next side is currently available.
- `zoomed` (bool, read-only): Whether the active image is currently zoomed.
- `zoomFactor` (real, read-only): Current zoom multiplier for the active image.

## Adjacent Item States

`previousItem` and `nextItem` use a shared three-state convention:

- `undefined`: availability is unknown or still loading
- `null`: availability is known and there is no item in that direction
- string/object: an adjacent item is available

This lets the app decide when and how to resolve neighboring media.

## Signals

- `clicked()`: Emitted on single tap/click.
- `requestPrevious(currentItem)`: Ask the app to resolve `previousItem` for the current image.
- `requestNext(currentItem)`: Ask the app to resolve `nextItem` for the current image.
- `previousTriggered(currentItem)`: Emitted when the user intends to navigate backward.
- `nextTriggered(currentItem)`: Emitted when the user intends to navigate forward.

## Methods

- `goPrevious()`: Emits backward navigation intent when available.
- `goNext()`: Emits forward navigation intent when available.
- `resetZoom()`: Resets the active image to its fitted zoom level.

## Image Input Format

ImageViewer accepts either plain strings or objects.

### String items
```qml
currentItem: "/home/phablet/Pictures/photo-1.jpg"
```

### Object items
```qml
currentItem: { filePath: "/home/phablet/Pictures/photo-1.jpg", id: "1", title: "Sunset" }
```

Supported object keys are `source`, `filePath`, `imagePath`, `url`, and `path`.
Absolute filesystem paths are automatically normalized to `file://`.

## App Integration Flow

1. The page/app sets `currentItem`.
2. ImageViewer emits `requestPrevious(currentItem)` and `requestNext(currentItem)`.
3. The page/app resolves adjacent media and updates `previousItem` / `nextItem`.
4. When the user taps an arrow or swipes while unzoomed, ImageViewer emits `previousTriggered(currentItem)` or `nextTriggered(currentItem)`.
5. The page/app updates `currentItem` to the newly selected media and repeats the cycle.

## Behavior

- Pinch to zoom in and out
- Drag/pan while zoomed
- Double tap to zoom in and double tap again to reset
- Swipe horizontally to request navigation when not zoomed
- Optional previous/next overlay buttons for explicit navigation intent
- Navigation availability comes from the app, not from an internal array

## Example Usage

### Single Image
```qml
ImageViewer {
    anchors.fill: parent
    currentItem: { filePath: "/home/phablet/Pictures/avatar.jpg" }
    previousItem: null
    nextItem: null
}
```

### Provider-Driven Gallery
```qml
Page {
    id: page

    property var photos: [
        { filePath: "/home/phablet/Pictures/photo-1.jpg", title: "One" },
        { filePath: "/home/phablet/Pictures/photo-2.jpg", title: "Two" },
        { filePath: "/home/phablet/Pictures/photo-3.jpg", title: "Three" }
    ]
    property int cursor: 0
    property var currentPhoto: photos[cursor]
    property var previousPhoto: undefined
    property var nextPhoto: undefined

    function resolveAdjacent() {
        previousPhoto = cursor > 0 ? photos[cursor - 1] : null
        nextPhoto = cursor < photos.length - 1 ? photos[cursor + 1] : null
    }

    ImageViewer {
        anchors.fill: parent
        currentItem: page.currentPhoto
        previousItem: page.previousPhoto
        nextItem: page.nextPhoto

        onRequestPrevious: page.resolveAdjacent()
        onRequestNext: page.resolveAdjacent()
        onPreviousTriggered: page.cursor = Math.max(0, page.cursor - 1)
        onNextTriggered: page.cursor = Math.min(page.photos.length - 1, page.cursor + 1)
    }
}
```

### Viewer With External Controls
```qml
Column {
    anchors.fill: parent

    ImageViewer {
        id: viewer
        width: parent.width
        height: parent.height - controls.height
        currentItem: page.currentPhoto
        previousItem: page.previousPhoto
        nextItem: page.nextPhoto
        showNavigationButtons: false
    }

    Row {
        id: controls
        spacing: units.gu(2)

        Button {
            text: i18n.tr("Previous")
            enabled: viewer.canGoPrevious
            onClicked: viewer.goPrevious()
        }

        Button {
            text: i18n.tr("Reset zoom")
            onClicked: viewer.resetZoom()
        }

        Button {
            text: i18n.tr("Next")
            enabled: viewer.canGoNext
            onClicked: viewer.goNext()
        }
    }
}
```
