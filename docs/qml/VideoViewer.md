# VideoViewer

A reusable video viewer that standardizes video playback across Ubuntu Touch applications. It combines play/pause controls, a seekable progress bar, current time and duration display, app-driven adjacent navigation, and optional previous/next buttons in a single component.

The API is intentionally aligned with `ImageViewer` so both components can later be composed by a mixed image/video gallery while the application keeps ownership of navigation state.

## Properties

- `currentItem` (var): Active video to render.
- `previousItem` (var): Previous adjacent video state.
- `nextItem` (var): Next adjacent video state.
- `navigationEnabled` (bool): Enables previous/next navigation logic (default: `true`).
- `swipeNavigationEnabled` (bool): Enables horizontal swipe navigation intent (default: `true`).
- `showNavigationButtons` (bool): Shows previous/next overlay buttons (default: `true`).
- `autoHideControls` (bool): Hides playback controls automatically while the active video is playing (default: `true`).
- `canGoPrevious` (bool, read-only): Whether the previous side is currently available.
- `canGoNext` (bool, read-only): Whether the next side is currently available.
- `playing` (bool, read-only): Whether the active video is currently playing.
- `controlsVisible` (bool, read-only): Whether the active video controls are visible.
- `position` (int, read-only): Current playback position in milliseconds.
- `duration` (int, read-only): Current video duration in milliseconds.

## Adjacent Item States

`previousItem` and `nextItem` use the same three-state convention as `ImageViewer`:

- `undefined`: availability is unknown or still loading
- `null`: availability is known and there is no item in that direction
- string/object: an adjacent item is available

## Signals

- `clicked()`: Emitted on single tap/click on the video area.
- `requestPrevious(currentItem)`: Ask the app to resolve `previousItem` for the current video.
- `requestNext(currentItem)`: Ask the app to resolve `nextItem` for the current video.
- `previousTriggered(currentItem)`: Emitted when the user intends to navigate backward.
- `nextTriggered(currentItem)`: Emitted when the user intends to navigate forward.
- `playbackChanged(playing)`: Emitted when the active video toggles between playing and paused.

## Methods

- `goPrevious()`: Emits backward navigation intent when available.
- `goNext()`: Emits forward navigation intent when available.
- `play()`: Starts playback of the active video.
- `pause()`: Pauses playback of the active video.
- `togglePlayback()`: Toggles play/pause for the active video.
- `seek(position)`: Seeks the active video to a position in milliseconds.
- `resetPlayback()`: Pauses playback and returns the active video to the beginning.

## Video Input Format

VideoViewer accepts either plain strings or objects.

### String items
```qml
currentItem: "/home/phablet/Videos/clip-1.mp4"
```

### Object items
```qml
currentItem: { filePath: "/home/phablet/Videos/clip-1.mp4", id: "1", title: "Trip" }
```

Supported object keys are `source`, `filePath`, `videoPath`, `url`, and `path`.
Absolute filesystem paths are automatically normalized to `file://`.

## App Integration Flow

1. The page/app sets `currentItem`.
2. VideoViewer emits `requestPrevious(currentItem)` and `requestNext(currentItem)`.
3. The page/app resolves adjacent media and updates `previousItem` / `nextItem`.
4. When the user taps an arrow or swipes while not scrubbing, VideoViewer emits `previousTriggered(currentItem)` or `nextTriggered(currentItem)`.
5. The page/app updates `currentItem`, and VideoViewer resets playback for the new media.

## Behavior

- Tap the video area to show or hide controls
- Use play/pause for playback control
- Drag or tap the timeline to seek
- Swipe horizontally to request navigation when not scrubbing the timeline
- Use optional previous/next overlay buttons for explicit navigation intent
- Controls remain visible while paused and can auto-hide during playback
- Navigation availability comes from the app, not from an internal array

## Example Usage

### Single Video
```qml
VideoViewer {
    anchors.fill: parent
    currentItem: { filePath: "/home/phablet/Videos/demo.mp4" }
    previousItem: null
    nextItem: null
}
```

### Provider-Driven Gallery
```qml
Page {
    id: page

    property var videos: [
        { filePath: "/home/phablet/Videos/clip-1.mp4", title: "One" },
        { filePath: "/home/phablet/Videos/clip-2.mp4", title: "Two" },
        { filePath: "/home/phablet/Videos/clip-3.mp4", title: "Three" }
    ]
    property int cursor: 0
    property var currentVideo: videos[cursor]
    property var previousVideo: undefined
    property var nextVideo: undefined

    function resolveAdjacent() {
        previousVideo = cursor > 0 ? videos[cursor - 1] : null
        nextVideo = cursor < videos.length - 1 ? videos[cursor + 1] : null
    }

    VideoViewer {
        anchors.fill: parent
        currentItem: page.currentVideo
        previousItem: page.previousVideo
        nextItem: page.nextVideo

        onRequestPrevious: page.resolveAdjacent()
        onRequestNext: page.resolveAdjacent()
        onPreviousTriggered: page.cursor = Math.max(0, page.cursor - 1)
        onNextTriggered: page.cursor = Math.min(page.videos.length - 1, page.cursor + 1)
    }
}
```

### Viewer With External Controls
```qml
Column {
    anchors.fill: parent

    VideoViewer {
        id: viewer
        width: parent.width
        height: parent.height - controls.height
        currentItem: page.currentVideo
        previousItem: page.previousVideo
        nextItem: page.nextVideo
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
            text: viewer.playing ? i18n.tr("Pause") : i18n.tr("Play")
            onClicked: viewer.togglePlayback()
        }

        Button {
            text: i18n.tr("Next")
            enabled: viewer.canGoNext
            onClicked: viewer.goNext()
        }
    }
}
```
