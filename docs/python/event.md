## Event Dispatcher

### Event

Abstract base class for defining events that can be scheduled and executed.

```python
class Event(ABC):
    def __init__(self, id: str, execution_interval: timedelta) -> None
    def trigger(self, metadata: Optional[Dict]) -> object | Dict | None
```

#### Description
Events are the fundamental units of work in the EventDispatcher system. Subclass this to create custom events with specific behavior. Each event has a unique identifier and can optionally be configured to run at regular intervals.

When an event is triggered, its result (if any) is automatically sent to the QML layer via pyotherside using the event's ID as the signal name.

#### Attributes
- **id** `(str)` - Unique identifier for the event. Used to register, schedule, and identify the event in QML signal handlers.
- **execution_interval** `(Optional[timedelta])` - If set, the event will be automatically re-scheduled at this interval by the dispatcher.
- **next_execution_date** `(Optional[datetime])` - Internal tracking for when the event should next be automatically enqueued.

#### Usage Examples

**Create a Recurring Event:**
```python
from datetime import timedelta
from src.python.event import Event

class RefreshDataEvent(Event):
    def __init__(self):
        super().__init__(
            id="refresh_data",
            execution_interval=timedelta(minutes=5)
        )

    def trigger(self, metadata):
        data = fetch_latest_data()
        return {"items": data, "count": len(data)}
```

**Create a Manual-Only Event:**
```python
class SendNotificationEvent(Event):
    def __init__(self):
        super().__init__(
            id="send_notification",
            execution_interval=None  # Only triggered manually
        )

    def trigger(self, metadata):
        title = metadata.get("title", "Notification")
        body = metadata.get("body", "")
        send_system_notification(title, body)
        return {"success": True}
```

**Return a Dataclass Result:**
```python
from dataclasses import dataclass
from enum import Enum

class Status(Enum):
    OK = "ok"
    ERROR = "error"

@dataclass
class SyncResult:
    status: Status
    items_synced: int

class SyncEvent(Event):
    def __init__(self):
        super().__init__("sync", timedelta(minutes=10))

    def trigger(self, metadata):
        count = perform_sync()
        # Dataclass is automatically converted to dict
        # Enum values are converted to strings
        return SyncResult(status=Status.OK, items_synced=count)
```

#### Important Notes
- Must subclass and implement the `trigger()` method
- The `id` must be unique within a dispatcher
- Set `execution_interval` to `None` for events that should only be triggered manually
- Results are sent to QML via `pyotherside.send(event_id, result)`

---

### trigger()

Execute the event's action and optionally return a result.

```python
@abstractmethod
def trigger(self, metadata: Optional[Dict]) -> object | Dict | None
```

#### Description
This method is called by the EventDispatcher when the event is due for execution. Implement this method in your subclass to define the event's behavior. The result is automatically sent to the QML layer.

#### Parameters
- **metadata** `(Optional[Dict])` - *Required*
  Arbitrary data passed when the event was scheduled. Can be used to customize event behavior on a per-invocation basis. Will be None if no metadata was provided during scheduling.

#### Returns
- `object | Dict | None` - The result of the event execution:
  - If a dataclass is returned, it will be converted to a dict and enum values will be converted to strings
  - If a dict is returned, it will be sent as-is
  - If None is returned, no signal will be sent to QML

#### Usage Examples

**Handle Metadata:**
```python
class FetchUserEvent(Event):
    def __init__(self):
        super().__init__("fetch_user", None)

    def trigger(self, metadata):
        if not metadata or "user_id" not in metadata:
            return {"error": "user_id required"}

        user_id = metadata["user_id"]
        user = database.get_user(user_id)

        if not user:
            return {"error": "User not found"}

        return {"user": user.to_dict()}
```

**QML Handler:**
```qml
Python {
    Component.onCompleted: {
        setHandler("fetch_user", function(result) {
            if (result.error) {
                showError(result.error)
            } else {
                userModel.update(result.user)
            }
        })
    }
}
```

---

### QueuedEvent

Internal dataclass representing an event waiting in the execution queue.

```python
@dataclass
class QueuedEvent:
    event: Event
    metadata: Optional[Dict]
```

#### Description
This is used internally by EventDispatcher to track scheduled events along with their associated metadata. You typically don't need to interact with this class directly.

#### Attributes
- **event** `(Event)` - The Event instance to be executed.
- **metadata** `(Optional[Dict])` - Data to pass to the event's trigger method.

---

### EventDispatcher

A priority queue-based event scheduler and executor for Python/QML applications.

```python
class EventDispatcher:
    def __init__(self) -> None
    def register_event(self, event: Event) -> str
    def unregister_event(self, event_id: str) -> None
    def schedule(self, event_id: str, metadata: Optional[Dict] = None, execution_interval: Optional[timedelta] = None) -> None
    def start(self, interval_seconds: float = 0.5) -> None
    def stop(self) -> None
```

#### Description
The EventDispatcher manages the lifecycle of events: registration, scheduling, and execution. It uses a min-heap priority queue to efficiently process events in chronological order, supporting both one-time and recurring events.

Events can be triggered in two ways:
1. **Automatically**: Events with an `execution_interval` are re-scheduled automatically after each execution
2. **Manually**: Any registered event can be scheduled on-demand with optional metadata and delay

Results from event execution are sent to the QML layer via pyotherside, allowing seamless Python-to-QML communication.

#### Features
- Priority queue for efficient chronological event processing
- Support for recurring events with configurable intervals
- Manual event scheduling with optional delays
- Metadata support for passing data to event handlers
- Automatic dataclass-to-dict conversion for QML compatibility
- Exception handling to prevent individual event failures from crashing the dispatcher
- Background thread execution with `start()` and `stop()` methods

> **Note:** Do not instantiate `EventDispatcher` directly. Use the `get_event_dispatcher()` function to obtain the global singleton instance. This ensures all parts of your application share the same dispatcher and event registry.

#### Usage Examples

**Complete Application Example:**

Python module (`event_page.py`):
```python
from python import setup
setup("example")
from python.event import Event, get_event_dispatcher
from datetime import datetime, timedelta
from dataclasses import dataclass

@dataclass
class FetchTimeResponse:
    time: str

class FetchTime(Event):
    def trigger(self, metadata=None):
        return FetchTimeResponse(time=datetime.now().isoformat())

get_event_dispatcher().register_event(
    FetchTime(id="fetch-time", execution_interval=timedelta(seconds=5))
)

def start_loop():
    get_event_dispatcher().start()

def stop_loop():
    get_event_dispatcher().stop()
```

QML file (`EventPage.qml`):
```qml
import QtQuick 2.12
import Lomiri.Components 1.3
import io.thp.pyotherside 1.4

Page {
    id: eventPage

    Label {
        id: timeLabel
        text: "Waiting for time..."
    }

    Python {
        id: python

        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('.'));
            importModule('event_page', function() {
                setHandler('fetch-time', function(result) {
                    timeLabel.text = "Current time is: " + result.time
                })
                call('event_page.start_loop', [], function() {});
            });
        }

        Component.onDestruction: {
            call('event_page.stop_loop', [], function() {});
        }

        onError: {
            console.log('python error: ' + traceback);
        }
    }
}
```

**Schedule Manual Events:**
```python
# Trigger immediately
get_event_dispatcher().schedule("alert", metadata={"message": "Hello!"})

# Trigger after delay
get_event_dispatcher().schedule(
    "alert",
    metadata={"message": "Delayed alert"},
    execution_interval=timedelta(seconds=10)
)
```

#### Important Notes
- Use `start()` to run the event loop in a background thread
- Use `stop()` to gracefully stop the event loop (call this in QML's `Component.onDestruction`)
- Use `get_event_dispatcher()` to get the global singleton dispatcher instance
- Register events at module level during import
- Events with `execution_interval` are automatically re-scheduled
- Exceptions in event handlers are caught and logged, not propagated

---

### register_event()

Register an event with the dispatcher.

```python
def register_event(self, event: Event) -> str
```

#### Description
Adds the event to the dispatcher's registry, making it available for scheduling. If the event has an `execution_interval`, it will be automatically scheduled when `run()` is called.

#### Parameters
- **event** `(Event)` - *Required*
  The Event instance to register. The event's id must be unique within this dispatcher.

#### Returns
- `str` - The event's ID, useful for chaining or reference.

#### Usage Examples

**Register Events:**
```python
dispatcher = EventDispatcher()

# Register and capture ID
sync_id = dispatcher.register_event(SyncEvent())
alert_id = dispatcher.register_event(AlertEvent())

# Use returned ID
dispatcher.schedule(sync_id)
```

**Register Multiple Events:**
```python
events = [
    HeartbeatEvent(),
    DataRefreshEvent(),
    NotificationEvent(),
]

for event in events:
    dispatcher.register_event(event)
```

---

### unregister_event()

Remove an event from the dispatcher's registry.

```python
def unregister_event(self, event_id: str) -> None
```

#### Description
Unregisters the event, preventing it from being scheduled in the future. Note that events already in the queue will still execute; this only prevents new scheduling.

#### Parameters
- **event_id** `(str)` - *Required*
  The ID of the event to unregister.

#### Warnings
- Issues a `UserWarning` if the event_id is not found in the registry.

#### Usage Examples

**Unregister Event:**
```python
dispatcher = EventDispatcher()
dispatcher.register_event(TemporaryEvent())

# Later, remove the event
dispatcher.unregister_event("temporary_event")
```

**Conditional Unregistration:**
```python
# Disable polling when app goes to background
def on_app_background():
    dispatcher.unregister_event("data_refresh")

def on_app_foreground():
    dispatcher.register_event(DataRefreshEvent())
```

---

### schedule()

Schedule a registered event for execution.

```python
def schedule(
    self,
    event_id: str,
    metadata: Optional[Dict] = None,
    execution_interval: Optional[timedelta] = None
) -> None
```

#### Description
Adds the event to the execution queue. The event will be executed when its scheduled time arrives during the `run()` loop.

#### Parameters
- **event_id** `(str)` - *Required*
  The ID of a previously registered event.

- **metadata** `(Optional[Dict])` - *Optional, default: None*
  Arbitrary data to pass to the event's `trigger()` method. Use this to customize event behavior on a per-invocation basis.

- **execution_interval** `(Optional[timedelta])` - *Optional, default: None*
  Delay before the event should execute. If None, the event executes immediately on the next `run()` iteration.

#### Warnings
- Issues a `UserWarning` if the event_id is not found in the registry.

#### Usage Examples

**Immediate Execution:**
```python
dispatcher.schedule("notification")
```

**With Metadata:**
```python
dispatcher.schedule("notification", metadata={
    "title": "Reminder",
    "body": "Meeting starts in 5 minutes",
    "priority": "high"
})
```

**Delayed Execution:**
```python
# Send reminder in 30 seconds
dispatcher.schedule(
    "notification",
    metadata={"title": "Delayed Reminder"},
    execution_interval=timedelta(seconds=30)
)

# Schedule for 1 hour later
dispatcher.schedule(
    "data_sync",
    execution_interval=timedelta(hours=1)
)
```

**Multiple Schedules:**
```python
# Same event can be scheduled multiple times with different metadata
for user_id in [1, 2, 3]:
    dispatcher.schedule(
        "send_email",
        metadata={"user_id": user_id, "template": "welcome"}
    )
```

---

### start()

Start the event dispatcher in a background thread.

```python
def start(self, interval_seconds: float = 0.5) -> None
```

#### Description
Starts the event loop in a daemon background thread, allowing the main thread to continue execution. This is a non-blocking method. The loop:
1. Enqueues any recurring events that are due
2. Processes all events whose execution time has arrived
3. Sleeps for the specified interval
4. Repeats

Exceptions during event execution are caught and printed to stderr, allowing the dispatcher to continue processing other events.

#### Parameters
- **interval_seconds** `(float)` - *Optional, default: 0.5*
  Time in seconds to sleep between processing iterations. Lower values provide more responsive event execution but consume more CPU.

#### Usage Examples

**Basic Usage:**
```python
from python.event import get_event_dispatcher

def start_loop():
    get_event_dispatcher().start()

def stop_loop():
    get_event_dispatcher().stop()
```

In QML:
```qml
Python {
    Component.onCompleted: {
        addImportPath(Qt.resolvedUrl('.'));
        importModule('event_page', function() {
            setHandler('fetch-time', function(result) {
                timeLabel.text = "Current time is: " + result.time
            })
            call('event_page.start_loop', [], function() {});
        });
    }

    Component.onDestruction: {
        call('event_page.stop_loop', [], function() {});
    }
}
```

**Custom Interval:**
```python
def start_loop():
    # More responsive (100ms interval)
    get_event_dispatcher().start(interval_seconds=0.1)

def start_loop_low_cpu():
    # Less CPU usage (1 second interval)
    get_event_dispatcher().start(interval_seconds=1.0)
```

#### Important Notes
- The event loop runs in a daemon thread (automatically stops when the main thread exits)
- Use `stop()` to gracefully stop the event loop
- Lower `interval_seconds` = more responsive but higher CPU usage

---

### stop()

Stop the event dispatcher loop.

```python
def stop(self) -> None
```

#### Description
Signals the event loop to exit gracefully. If running in a background thread via `start()`, waits for the thread to terminate (with a 2-second timeout).

#### Usage Examples

**Basic Usage:**
```python
from python.event import get_event_dispatcher

def stop_loop():
    get_event_dispatcher().stop()
```

**In QML (cleanup on page destruction):**
```qml
Python {
    Component.onDestruction: {
        call('event_page.stop_loop', [], function() {});
    }
}
```

#### Important Notes
- Always call `stop()` when the page/component is destroyed to ensure clean shutdown
- The method waits up to 2 seconds for the background thread to terminate

---

### get_event_dispatcher()

Get the global singleton EventDispatcher instance.

```python
def get_event_dispatcher() -> EventDispatcher
```

#### Description
This is the recommended way to access the EventDispatcher. Do not instantiate `EventDispatcher` directly; always use this function to ensure a single shared instance across your application.

#### Returns
- `EventDispatcher` - The global singleton dispatcher instance.

#### Usage Examples

**Basic Usage:**
```python
from python.event import Event, get_event_dispatcher
from datetime import timedelta

class MyEvent(Event):
    def trigger(self, metadata=None):
        return {"status": "ok"}

get_event_dispatcher().register_event(
    MyEvent(id="my-event", execution_interval=timedelta(seconds=10))
)

def start_loop():
    get_event_dispatcher().start()

def stop_loop():
    get_event_dispatcher().stop()
```

#### Important Notes
- Always use `get_event_dispatcher()` instead of instantiating `EventDispatcher` directly
- The singleton pattern ensures all parts of your application share the same dispatcher and event registry
- Register events at module level during import, then call `start()` from QML
