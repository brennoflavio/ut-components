
## Notification Functions

### Notification

A dataclass representing a push notification for Ubuntu Touch applications.

```python
@dataclass
class Notification:
    icon: str
    summary: str
    body: str
    popup: bool
    persist: bool
    vibrate: bool
    sound: bool

    def dict(self) -> Dict
    def dump(self) -> str
```

#### Description
This dataclass encapsulates all properties needed to create and send push notifications through the Ubuntu Push Notification Service. It provides methods for serialization to the required format, making it easy to work with Ubuntu Touch push notifications in your applications.

#### Attributes
- **icon** `(str)` - *Required*
  The icon name or path to display with the notification. Should be a valid icon from the system theme or app resources.

- **summary** `(str)` - *Required*
  The title or summary text shown in the notification header.

- **body** `(str)` - *Required*
  The main content/message of the notification.

- **popup** `(bool)` - *Required*
  Whether to display the notification as a popup overlay.

- **persist** `(bool)` - *Required*
  Whether the notification should persist in the notification drawer until explicitly dismissed by the user.

- **vibrate** `(bool)` - *Required*
  Whether to trigger device vibration when the notification is received (subject to user settings).

- **sound** `(bool)` - *Required*
  Whether to play a notification sound when received (subject to user settings).

#### Methods

##### dict()
Convert the notification to Ubuntu Push format dictionary.

**Returns:**
- `Dict` - Notification data structured for Ubuntu Push API

##### dump()
Serialize the notification to a JSON string.

**Returns:**
- `str` - JSON string representation of the notification

#### Usage Examples

**Create a Simple Notification:**
```python
from src.ut_components.notification import Notification

# Create a notification
notification = Notification(
    icon="dialog-information",
    summary="New Message",
    body="You have received a new message from John",
    popup=True,
    persist=True,
    vibrate=True,
    sound=True
)

# Convert to Ubuntu Push format
push_data = notification.dict()

# Get JSON string
json_str = notification.dump()
```

**Create a Reminder Notification:**
```python
reminder = Notification(
    icon="alarm-clock",
    summary="Meeting Reminder",
    body="Your team meeting starts in 5 minutes",
    popup=True,
    persist=False,
    vibrate=True,
    sound=True
)
```

#### Important Notes
- All attributes are required when creating a Notification instance
- Icons should use system theme names or valid app resource paths
- Vibrate and sound behavior depends on user device settings

---

### parse_notification()

Parse a JSON string into a Notification object.

```python
def parse_notification(raw_notification: str) -> Notification
```

#### Description
Deserializes a JSON-formatted push notification string (typically received from the Ubuntu Push Notification Service) into a Notification dataclass instance. This function provides sensible defaults for any missing fields, making it robust when handling incomplete notification data.

#### Parameters
- **raw_notification** `(str)` - *Required*
  A JSON string containing the notification data in Ubuntu Push format. Should have a structure with "notification" containing "card" and vibrate/sound settings.

#### Returns
- `Notification` - A Notification object populated with the parsed data. Missing fields will use defaults: icon="notification", empty strings for text fields, and False for boolean flags.

#### Usage Examples

**Parse a Complete Notification:**
```python
from src.ut_components.notification import parse_notification
import json

# Parse a notification from JSON
json_data = '''
{
    "notification": {
        "card": {
            "icon": "message-new",
            "summary": "Alert",
            "body": "Important update available",
            "popup": true,
            "persist": false
        },
        "vibrate": true,
        "sound": false
    }
}
'''

notification = parse_notification(json_data)
print(notification.summary)  # Output: "Alert"
print(notification.vibrate)  # Output: True
```

**Parse with Missing Fields:**
```python
# Minimal JSON with missing fields
minimal_json = '''
{
    "notification": {
        "card": {
            "summary": "Quick Note"
        }
    }
}
'''

notification = parse_notification(minimal_json)
print(notification.icon)     # Output: "notification" (default)
print(notification.body)      # Output: "" (default)
print(notification.popup)     # Output: False (default)
```

#### Important Notes
- Provides safe defaults for missing fields
- icon defaults to "notification"
- Text fields default to empty strings
- Boolean fields default to False
- Handles nested JSON structure gracefully

---

### send_notification()

Send a push notification through the Ubuntu Push Notification Service.

```python
def send_notification(notification: Notification, token: str, appid: str)
```

#### Description
Transmits a notification to a specific device using the Ubuntu Push infrastructure. The notification will be delivered to the device identified by the provided token, for the specified application. The notification expires after 10 minutes if not delivered, ensuring that outdated notifications are not sent to users.

#### Parameters
- **notification** `(Notification)` - *Required*
  The notification object containing all the message details, formatting, and behavior settings.

- **token** `(str)` - *Required*
  The unique push token identifying the target device. This token is obtained during the app's push registration process.

- **appid** `(str)` - *Required*
  The application identifier in the format "appname_version" or as registered with the Ubuntu Push service.

#### Raises
- `requests.exceptions.HTTPError` - If the push service returns an error status code (4xx or 5xx)
- `requests.exceptions.RequestException` - For network-related errors during the API call

#### Usage Examples

**Send a Basic Notification:**
```python
from src.ut_components.notification import Notification, send_notification

# Create a notification
notification = Notification(
    icon="dialog-information",
    summary="Update Available",
    body="A new version of the app is ready to install",
    popup=True,
    persist=True,
    vibrate=True,
    sound=True
)

# Send to a specific device
send_notification(
    notification=notification,
    token="abc123def456",  # Device push token
    appid="myapp.developer_1.0"
)
```

**Send a Reminder Notification:**
```python
# Create and send a reminder
reminder = Notification(
    icon="alarm-clock",
    summary="Reminder",
    body="Your meeting starts in 5 minutes",
    popup=True,
    persist=False,
    vibrate=True,
    sound=True
)

try:
    send_notification(
        notification=reminder,
        token=user_device_token,
        appid="calendar.app_2.1"
    )
    print("Reminder sent successfully")
except Exception as e:
    print(f"Failed to send reminder: {e}")
```

#### Important Notes
- Requires valid Ubuntu Push Service endpoint (push.ubports.com)
- Notifications expire after 10 minutes if not delivered
- Token must be obtained through app's push registration
- AppID format should match your app's registration
- Network errors should be handled appropriately
