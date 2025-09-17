### setup()

Initialize the UT Components library with application configuration.

```python
def setup(app_name: str, crash_report_url: Optional[str] = None)
```

#### Description
This function must be called on each Python file where you're importing library components. It configures the library with essential application information and sets up global variables that will be used by various components throughout the library for identifying the application and handling crash reports.

#### Parameters
- **app_name** `(str)` - *Required*
  The name of your Ubuntu Touch application. This is used for identifying the app in logs, crash reports, and other components.

- **crash_report_url** `(Optional[str])` - *Optional, default: None*
  URL endpoint for submitting crash reports. If provided, components can send crash data to this URL for debugging.

#### Usage Examples

**Basic Setup (without crash reporting):**
```python
from src.ut_components import setup

setup(app_name="MyUTApp")
```

**Setup with Crash Reporting:**
```python
from src.ut_components import setup

setup(
    app_name="MyUTApp",
    crash_report_url="https://api.myapp.com/crashes"
)
```

#### Important Notes
- Call this function once per Python file that imports UT Components
- Must be called before using any other components from the library
- The app_name should be consistent across your entire application
