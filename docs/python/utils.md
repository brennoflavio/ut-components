## Utility Functions

### short_string()

Generate a cryptographically secure random string identifier.

```python
def short_string() -> str
```

#### Description
This function creates a short, random string that can be used for various purposes such as temporary identifiers, session tokens, or unique keys in Ubuntu Touch applications. Uses the secrets module to ensure the generated string is suitable for security-sensitive contexts.

#### Returns
- `str` - An 8-character string composed of random ASCII letters (a-z, A-Z).

#### Usage Examples

**Generate Random Identifier:**
```python
from src.ut_components.utils import short_string

# Generate a random identifier
random_id = short_string()
print(random_id)  # Output: "KjHgFdSa"

# Use for creating unique temporary keys
temp_key = f"temp_{short_string()}"
print(temp_key)  # Output: "temp_XyZaBcDe"
```

**Create Session Tokens:**
```python
# Generate unique session ID
session_id = f"session_{short_string()}"
kv.put(session_id, user_data, ttl_seconds=3600)

# Create temporary file names
temp_file = f"/tmp/upload_{short_string()}.tmp"
```

#### Important Notes
- Uses cryptographically secure random generation
- Always returns exactly 8 characters
- Contains only ASCII letters (no numbers or special characters)
- Suitable for security-sensitive applications

---

### enum_to_str()

Convert Enum values to their string representations recursively.

```python
def enum_to_str(obj: Any) -> Any
```

#### Description
This utility function traverses through data structures (dicts, lists) and converts any Enum instances to their string values. This is particularly useful when preparing data for JSON serialization or QML consumption in Ubuntu Touch applications, as Enums are not directly serializable.

#### Parameters
- **obj** `(Any)` - *Required*
  The object to process. Can be an Enum, dict, list, or any other type. Nested structures are handled recursively.

#### Returns
- `Any` - The same structure with all Enum values replaced by their string representations. Non-Enum values are returned unchanged.

#### Usage Examples

**Convert Single Enum:**
```python
from enum import Enum
from src.ut_components.utils import enum_to_str

class Status(Enum):
    ACTIVE = "active"
    INACTIVE = "inactive"
    PENDING = "pending"

# Convert single Enum
result = enum_to_str(Status.ACTIVE)
print(result)  # Output: "active"
```

**Convert Nested Structure:**
```python
# Complex data with Enums
data = {
    "status": Status.PENDING,
    "items": [Status.ACTIVE, Status.INACTIVE],
    "config": {"default": Status.ACTIVE}
}

# Convert all Enums to strings
result = enum_to_str(data)
print(result)
# Output: {
#     "status": "pending",
#     "items": ["active", "inactive"],
#     "config": {"default": "active"}
# }
```

**Prepare Data for QML:**
```python
class Priority(Enum):
    LOW = 1
    MEDIUM = 2
    HIGH = 3

task_data = {
    "id": 123,
    "title": "Fix bug",
    "priority": Priority.HIGH,
    "tags": ["urgent", "backend"]
}

# Convert for QML consumption
qml_ready = enum_to_str(task_data)
# Now safe to pass to QML
```

#### Important Notes
- Handles nested structures recursively
- Preserves non-Enum values unchanged
- Essential for JSON serialization
- Works with any Enum value type (string, int, etc.)

---

### dataclass_to_dict()

Decorator to automatically convert dataclass return values to dictionaries.

```python
def dataclass_to_dict(func: Callable) -> Callable
```

#### Description
This decorator simplifies the process of exposing dataclass-based APIs to QML or JSON consumers in Ubuntu Touch applications. It automatically converts dataclass instances to dictionaries and handles any Enum values within them, making the data readily consumable by QML components without manual conversion. The decorator checks if the function's return value is a dataclass instance. If it is, it converts it to a dictionary and processes any Enum values to their string representations. Non-dataclass return values pass through unchanged.

#### Parameters
- **func** `(Callable)` - *Required*
  The function to be decorated. Should return either a dataclass instance or any other value.

#### Returns
- `Callable` - A wrapped function that automatically converts dataclass return values to dictionaries with Enum values as strings.

#### Usage Examples

**Basic Dataclass Conversion:**
```python
from dataclasses import dataclass
from enum import Enum
from src.ut_components.utils import dataclass_to_dict

class Priority(Enum):
    LOW = "low"
    MEDIUM = "medium"
    HIGH = "high"

@dataclass
class Task:
    id: int
    title: str
    priority: Priority
    completed: bool

@dataclass_to_dict
def get_task(task_id: int) -> Task:
    return Task(
        id=task_id,
        title="Implement feature",
        priority=Priority.HIGH,
        completed=False
    )

# The decorator automatically converts the dataclass
result = get_task(1)
print(result)
# Output: {
#     "id": 1,
#     "title": "Implement feature",
#     "priority": "high",
#     "completed": False
# }
```

**PyOtherSide Integration:**
```python
@dataclass
class UserData:
    username: str
    email: str
    status: Status
    preferences: dict

@dataclass_to_dict
def get_user_data(user_id: str) -> UserData:
    # Fetch from database
    return UserData(
        username="john_doe",
        email="john@example.com",
        status=Status.ACTIVE,
        preferences={"theme": "dark"}
    )

# Ready for QML without manual conversion
# pyotherside.send("user_data", get_user_data("123"))
```

**API Response Handler:**
```python
@dataclass
class APIResponse:
    success: bool
    data: dict
    status_code: int
    message: str

@dataclass_to_dict
def process_api_response(raw_response) -> APIResponse:
    return APIResponse(
        success=raw_response.status_code == 200,
        data=raw_response.json(),
        status_code=raw_response.status_code,
        message="Request processed"
    )

# Automatically returns dict for JSON serialization
response = process_api_response(api_result)
```

#### Important Notes
- Only converts the return value if it's a dataclass
- Non-dataclass return values pass through unchanged
- Automatically handles Enum conversion within dataclasses
- Perfect for PyOtherSide integration with QML
- Reduces boilerplate code for API responses
