# Ubuntu Touch Components

Welcome to my personal library of components for Ubuntu Touch. The idea behind this project is to create
a reusable system for backend and frontent that will allow rapid creation of Ubuntu Touch Apps.

# Demo and Apps

This set of components powers the following applications in OpenStore:
- [Picpocket](https://open-store.io/app/picpocket.brennoflavio): An Immich Client
- [ContactBridge](https://open-store.io/app/contactbridge.brennoflavio): Sync your Nextcloud (or any CardDAV server) Address Books

# Installation

# QML Components

- [ActionableList](qml/ActionableList.md): A list of items (smaller itens with title, subtitle, icon and actions) with search.
- [ActionButton](qml/ActionButton.md): A prominent button component for primary actions, customizable.
- [AppHeader](qml/AppHeader.md): A simplified page header component that provides back navigation and button to settings page.
- [BottomBar](qml/BottomBar.md): A bottom navigation bar component that provides three distinct sections (left, rigth, middle buttons) for organizing actions.
- [CardList](qml/CardList.md): A list of Cards (larger components with title, subtitle, icon/thumbnail) with search.
- [ConfigurationGroup](qml/ConfigurationGroup.md): A titled container component for grouping related configuration controls.
- [Form](qml/Form.md): A form container that vertically stacks input fields and exposes a single submit button.
- [IconButton](qml/IconButton.md): A small circular button component that displays an icon with an optional text label below.
- [InputField](qml/InputField.md): A text input component with built-in validation and error handling for forms and settings.
- [KeyboardSpacer](qml/KeyboardSpacer.md): An automatic spacer component that adjusts its height to match the virtual keyboard.
- [LoadToast](qml/LoadToast.md): A full-screen loading overlay component to block the screen in long running functions.
- [NumberOption](qml/NumberOption.md): A numeric input field component with labels and validation for settings and forms.
- [ToggleOption](qml/ToggleOption.md): A toggle switch for boolean settings with title and optional subtitle.

# Python Components

To use this library, you need to setup on each python file before any imports.

```python
from src.lib import setup

setup(app_name="yourapp.name", crash_report_url=None)

from src.lib.kv import KV

...
```
- [setup](python/setup.md): Configure global variables for this package
- [config](python/config.md): Provide starndard paths (cache, data, config) for your application.
- [crash](python/crash.md): Implement backend for crash reports, and a decorator to send crashes to a server.
- [http](python/http.md): Pure python HTTP client with a requests-like structure, on top of urllib.
- [kv](python/kv.md): Key-Value storage on top of sqlite3 with ttl and batching support.
- [memoize](python/memoize.md): Memoization support for python function on top of KV.
- mimetypes: Standard mimetype package fixed for Ubuntu Touch.
- [notification](python/notification.md): Utilities to recieve and send notifications.
- [utils](python/utils.md): Utility functions. Short random string, dataclass and enum convertion to qml friendly types.
