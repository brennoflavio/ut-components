
## Configuration Functions

### get_config_path()

Get the XDG-compliant configuration directory path for the application.

```python
def get_config_path() -> str
```

#### Description
Returns the standard configuration directory where the application should store its configuration files. It follows the XDG Base Directory specification, ensuring your app's configs are stored in the appropriate system location. The function respects the XDG_CONFIG_HOME environment variable if set, otherwise defaults to ~/.config.

#### Returns
- `str` - The absolute path to the application's configuration directory (typically ~/.config/{app_name})

#### Raises
- `AssertionError` - If setup() has not been called to initialize APP_NAME_

#### Usage Examples

**Basic Usage:**
```python
from src.ut_components import setup
from src.ut_components.config import get_config_path

# Initialize the library with your app name
setup(app_name="myapp.example")

# Get the config directory path
config_dir = get_config_path()
print(config_dir)  # /home/user/.config/myapp.example

# Use it to store configuration files
config_file = os.path.join(config_dir, "settings.json")
```

#### Important Notes
- Requires setup() to be called first
- Follows XDG Base Directory specification
- Creates an app-specific subdirectory under the config path

---

### get_cache_path()

Get the XDG-compliant cache directory path for the application.

```python
def get_cache_path() -> str
```

#### Description
Returns the standard cache directory where the application should store temporary cache files. It follows the XDG Base Directory specification, ensuring your app's cache is stored in the appropriate system location for temporary/regenerable data. The function respects the XDG_CACHE_HOME environment variable if set, otherwise defaults to ~/.cache.

#### Returns
- `str` - The absolute path to the application's cache directory (typically ~/.cache/{app_name})

#### Raises
- `AssertionError` - If setup() has not been called to initialize APP_NAME_

#### Usage Examples

**Basic Usage:**
```python
from src.ut_components import setup
from src.ut_components.config import get_cache_path

# Initialize the library with your app name
setup(app_name="myapp.example")

# Get the cache directory path
cache_dir = get_cache_path()
print(cache_dir)  # /home/user/.cache/myapp.example

# Use it to store temporary/cache files
thumbnail_cache = os.path.join(cache_dir, "thumbnails")
downloaded_file = os.path.join(cache_dir, "temp_download.dat")
```

#### Important Notes
- Requires setup() to be called first
- Follows XDG Base Directory specification
- Use for temporary or regenerable data only
- Files in cache may be deleted by system cleanup tools

---

### get_app_data_path()

Get the application's installation directory path.

```python
def get_app_data_path() -> str
```

#### Description
Returns the path to the directory where the application is installed on Ubuntu Touch. This is typically used to access read-only application resources like QML files, icons, assets, and other bundled data that ships with the application package. The function reads the APP_DIR environment variable, which is automatically set by the Ubuntu Touch application confinement system when the app is launched.

#### Returns
- `str` - The absolute path to the application's installation directory

#### Raises
- `Exception` - If the APP_DIR environment variable is not set (app not running in proper Ubuntu Touch environment)

#### Usage Examples

**Basic Usage:**
```python
from src.ut_components.config import get_app_data_path

# Get the app installation directory
app_dir = get_app_data_path()
print(app_dir)

# Access bundled resources
qml_dir = os.path.join(app_dir, "qml")
icon_path = os.path.join(app_dir, "assets", "icon.svg")
main_qml = os.path.join(app_dir, "qml", "Main.qml")
```

#### Important Notes
- Does not require setup() to be called
- Read-only directory containing app installation files
- Only available in Ubuntu Touch confined environment
- APP_DIR environment variable must be set by the system
