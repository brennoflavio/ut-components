# Ubuntu Touch Components

Welcome to my personal library of components for Ubuntu Touch. The idea behind this project is to create
a reusable system for backend and frontent that will allow rapid creation of Ubuntu Touch Apps.

# Demo and Apps

This set of components powers the following applications in OpenStore:
- [Picpocket](https://open-store.io/app/picpocket.brennoflavio): An Immich Client
- [ContactBridge](https://open-store.io/app/contactbridge.brennoflavio): Sync your Nextcloud (or any CardDAV server) Address Books

# Installation

Simply copy the `src/qml` and `src/pyhton` folders to your project. For convenience, a install script is supplied that you can run in your git
repository

```
curl -s https://raw.githubusercontent.com/brennoflavio/ut-components/refs/heads/master/scripts/install.sh | bash
```

# QML Components

- [ActionableList](docs/qml/ActionableList.md): A list of items (smaller itens with title, subtitle, icon and actions) with search.
- [ActionButton](docs/qml/ActionButton.md): A prominent button component for primary actions, customizable.
- [AppHeader](docs/qml/AppHeader.md): A simplified page header component that provides back navigation and button to settings page.
- [BottomBar](docs/qml/BottomBar.md): A bottom navigation bar component that provides three distinct sections (left, rigth, middle buttons) for organizing actions.
- [CardList](docs/qml/CardList.md): A list of Cards (larger components with title, subtitle, icon/thumbnail) with search.
- [ConfigurationGroup](docs/qml/ConfigurationGroup.md): A titled container component for grouping related configuration controls.
- [Form](docs/qml/Form.md): A form container that vertically stacks input fields and exposes a single submit button.
- [IconButton](docs/qml/IconButton.md): A small circular button component that displays an icon with an optional text label below.
- [InputField](docs/qml/InputField.md): A text input component with built-in validation and error handling for forms and settings.
- [KeyboardSpacer](docs/qml/KeyboardSpacer.md): An automatic spacer component that adjusts its height to match the virtual keyboard.
- [LoadToast](docs/qml/LoadToast.md): A full-screen loading overlay component to block the screen in long running functions.
- [NumberOption](docs/qml/NumberOption.md): A numeric input field component with labels and validation for settings and forms.
- [ToggleOption](docs/qml/ToggleOption.md): A toggle switch for boolean settings with title and optional subtitle.

# Python Components

To use this library, you need to setup on each python file before any imports.

```python
from src.lib import setup

setup(app_name="yourapp.name", crash_report_url=None)

from src.lib.kv import KV

...
```
- [setup](docs/python/setup.md): Configure global variables for this package
- [config](docs/python/config.md): Provide starndard paths (cache, data, config) for your application.
- [crash](docs/python/crash.md): Implement backend for crash reports, and a decorator to send crashes to a server.
- [http](docs/python/http.md): Pure python HTTP client with a requests-like structure, on top of urllib.
- [kv](docs/python/kv.md): Key-Value storage on top of sqlite3 with ttl and batching support.
- [memoize](docs/python/memoize.md): Memoization support for python function on top of KV.
- mimetypes: Standard mimetype package fixed for Ubuntu Touch.
- [notification](docs/python/notification.md): Utilities to recieve and send notifications.
- [utils](docs/python/utils.md): Utility functions. Short random string, dataclass and enum convertion to qml friendly types.

## License

Copyright (C) 2025  Brenno Flávio de Almeida

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License version 3, as published by the
Free Software Foundation.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranties of MERCHANTABILITY, SATISFACTORY
QUALITY, or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
for more details.

You should have received a copy of the GNU General Public License along with
this program. If not, see <http://www.gnu.org/licenses/>.
