## Crash Reporting Functions

### set_crash_report()

Enable or disable automatic crash reporting for the application.

```python
def set_crash_report(enabled: bool)
```

#### Description
This function persists the crash reporting preference in the application's key-value store. When enabled, decorated functions will automatically send crash reports to the configured URL when exceptions occur. The preference is stored persistently and will be remembered across application restarts.

#### Parameters
- **enabled** `(bool)` - *Required*
  True to enable crash reporting, False to disable it. This preference is stored persistently and will be remembered across application restarts.

#### Usage Examples

**Enable Crash Reporting:**
```python
from src.ut_components import setup
from src.ut_components.crash import set_crash_report

# Initialize the library with crash URL
setup(app_name="MyApp", crash_report_url="https://api.myapp.com/crashes")

# Enable crash reporting
set_crash_report(True)

# Later, disable it if user opts out
set_crash_report(False)
```

#### Important Notes
- Requires setup() to be called with a valid crash_report_url
- User preference is stored persistently using KV storage
- Respects user privacy - only sends reports when explicitly enabled

---

### get_crash_report()

Check if crash reporting is currently enabled for the application.

```python
def get_crash_report() -> bool
```

#### Description
Retrieves the crash reporting preference from the persistent key-value store. This function is used internally by the crash_reporter decorator to determine whether to send crash reports when exceptions occur.

#### Returns
- `bool` - True if crash reporting is enabled, False otherwise. Returns False by default if no preference has been set.

#### Usage Examples

**Check Crash Reporting Status:**
```python
from src.ut_components.crash import get_crash_report, set_crash_report

# Check initial state (defaults to False)
is_enabled = get_crash_report()
print(f"Crash reporting: {is_enabled}")  # Output: Crash reporting: False

# Enable crash reporting
set_crash_report(True)
is_enabled = get_crash_report()
print(f"Crash reporting: {is_enabled}")  # Output: Crash reporting: True
```

#### Important Notes
- Returns False by default if never configured
- Used internally by crash_reporter decorator
- Reads from persistent KV storage

---

### crash_reporter()

Decorator that automatically reports unhandled exceptions to a crash reporting service.

```python
def crash_reporter(func: Callable) -> Callable
```

#### Description
This decorator wraps functions to catch any unhandled exceptions and automatically send crash reports to the configured URL endpoint if crash reporting is enabled. The original exception is always re-raised to maintain normal error flow, ensuring that the application's error handling logic is not disrupted. The decorator checks if crash reporting is enabled before sending any data, respecting user privacy preferences.

#### Parameters
- **func** `(Callable)` - *Required*
  The function to be decorated with crash reporting capability.

#### Returns
- `Callable` - The wrapped function that includes crash reporting functionality.

#### Raises
- `AssertionError` - If crash reporting is enabled but CRASH_REPORT_URL_ is not configured
- Any exception raised by the decorated function is re-raised after reporting

#### Usage Examples

**Decorate a Function:**
```python
from src.ut_components import setup
from src.ut_components.crash import crash_reporter, set_crash_report

# Initialize the library with crash reporting URL
setup(app_name="MyApp", crash_report_url="https://api.myapp.com/crashes")
set_crash_report(True)

# Decorate a function that might crash
@crash_reporter
def risky_operation(data):
    # This could raise an exception
    result = process_data(data)
    return result

# When the function raises an exception, it will be reported
try:
    risky_operation(invalid_data)
except Exception as e:
    # Exception is still raised after being reported
    print(f"Operation failed: {e}")
```

**Use with Class Methods:**
```python
class DataProcessor:
    @crash_reporter
    def process(self, data):
        return data.transform()
```

#### Important Notes
- Requires setup() to be called with a valid crash_report_url
- Only sends reports when crash reporting is enabled via set_crash_report()
- Original exception is always re-raised after reporting
- Sends full traceback to the configured URL endpoint
