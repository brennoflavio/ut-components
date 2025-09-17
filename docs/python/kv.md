## Key-Value Storage

### KV

A persistent key-value storage system with TTL (time-to-live) support.

```python
class KV:
    def __init__(self) -> None
    def put(self, key: str, value: Any, ttl_seconds: Optional[int] = None) -> None
    def get(self, key: str, default: Optional[Any] = None, save_default_if_not_set: bool = False) -> Optional[Any]
    def get_partial(self, beginning: str) -> List[Tuple[str, Any]]
    def delete(self, key: str) -> None
    def delete_partial(self, beginning: str) -> None
    def close(self) -> None
    def put_cached(self, key: str, value: Any, ttl_seconds: Optional[int] = None) -> None
    def commit_cached(self) -> None
```

#### Description
The KV class provides a simple yet powerful interface for storing and retrieving data persistently using SQLite as the backend. It supports automatic expiration of entries through TTL, batch operations for performance, and prefix-based queries. All values are automatically serialized to JSON for storage, allowing you to store complex Python objects like dictionaries and lists.

#### Features
- Persistent storage using SQLite database
- TTL support for automatic expiration of entries
- Batch operations for improved performance
- Prefix-based queries and deletions
- Context manager support for automatic cleanup
- JSON serialization for complex data types

#### Usage Examples

**Basic Usage:**
```python
from src.ut_components import setup
from src.ut_components.kv import KV

# Initialize the library
setup(app_name="MyApp")

# Create KV instance
kv = KV()

# Store simple value
kv.put("username", "john_doe")

# Store complex object
kv.put("user:profile", {
    "name": "John Doe",
    "email": "john@example.com",
    "preferences": ["dark_mode", "notifications"]
})

# Retrieve value
user = kv.get("user:profile")
print(user)  # {"name": "John Doe", "email": "john@example.com", ...}

kv.close()
```

**Using Context Manager:**
```python
from src.ut_components.kv import KV

with KV() as kv:
    kv.put("config:theme", "dark", ttl_seconds=3600)
    theme = kv.get("config:theme", default="light")
    print(theme)  # "dark"
# Automatically closed after with block
```

**Batch Operations for Performance:**
```python
with KV() as kv:
    # Add many items to cache
    for i in range(1000):
        kv.put_cached(f"item:{i}", {"value": i})

    # Commit all at once (single transaction)
    kv.commit_cached()
```

#### Important Notes
- Requires setup() to be called first
- Database file is stored in the config directory at {config_path}/kv.db
- All values are JSON-serialized automatically
- Context manager support ensures proper cleanup
- Expired entries remain in database until queried

---

### put()

Store a key-value pair in the database with optional TTL.

```python
def put(self, key: str, value: Any, ttl_seconds: Optional[int] = None) -> None
```

#### Description
Inserts or updates a key-value pair in the storage. The value is automatically serialized to JSON before storage, allowing you to store complex Python objects. If the key already exists, its value will be replaced with the new value.

#### Parameters
- **key** `(str)` - *Required*
  The unique identifier for the value. If the key already exists, its value will be replaced.

- **value** `(Any)` - *Required*
  The value to store. Can be any JSON-serializable Python object (str, int, float, bool, dict, list, None).

- **ttl_seconds** `(Optional[int])` - *Optional, default: None*
  Time-to-live in seconds. If provided, the entry will automatically expire after this duration. Defaults to None (no expiration).

#### Usage Examples

**Store Simple Values:**
```python
kv = KV()
kv.put("username", "john_doe")
kv.put("user_id", 12345)
kv.put("is_premium", True)
```

**Store Complex Objects:**
```python
kv.put("user:profile", {
    "name": "John Doe",
    "email": "john@example.com",
    "preferences": {
        "theme": "dark",
        "notifications": True
    }
})
```

**Store with Expiration:**
```python
# Session token expires in 1 hour
kv.put("session:token", "abc123xyz", ttl_seconds=3600)

# Cache data for 5 minutes
kv.put("cache:api_response", response_data, ttl_seconds=300)
```

---

### get()

Retrieve a value from the database by its key.

```python
def get(
    self,
    key: str,
    default: Optional[Any] = None,
    save_default_if_not_set: bool = False
) -> Optional[Any]
```

#### Description
Fetches the value associated with the given key. If the key doesn't exist or has expired (TTL exceeded), returns the default value. The value is automatically deserialized from JSON. Optionally saves the default value if the key is not found.

#### Parameters
- **key** `(str)` - *Required*
  The key to look up in the storage.

- **default** `(Optional[Any])` - *Optional, default: None*
  The value to return if the key is not found or has expired.

- **save_default_if_not_set** `(bool)` - *Optional, default: False*
  If True and the key is not found, saves the default value under this key. Useful for initializing settings with defaults.

#### Returns
- `Optional[Any]` - The stored value if found and not expired, otherwise the default value. The value is automatically deserialized from JSON.

#### Usage Examples

**Basic Retrieval:**
```python
kv = KV()
kv.put("greeting", "Hello, World!")
msg = kv.get("greeting")
print(msg)  # "Hello, World!"
```

**With Default Value:**
```python
# Returns default if not found
theme = kv.get("theme", default="light")
print(theme)  # "light" (if not set)

# Save default if not found
language = kv.get("language", default="en", save_default_if_not_set=True)
# Now "language" is saved with value "en"
```

**Handle Expired Values:**
```python
kv.put("temp", "data", ttl_seconds=1)
import time
time.sleep(2)
val = kv.get("temp", default="expired")
print(val)  # "expired"
```

---

### get_partial()

Retrieve all key-value pairs where keys start with a given prefix.

```python
def get_partial(self, beginning: str) -> List[Tuple[str, Any]]
```

#### Description
Performs a prefix search on keys and returns all matching entries that haven't expired. Results are sorted by value (in JSON string form). This is useful for implementing features like autocomplete, finding all items in a category, or retrieving related configuration options.

#### Parameters
- **beginning** `(str)` - *Required*
  The prefix to search for. All keys starting with this string will be returned.

#### Returns
- `List[Tuple[str, Any]]` - A list of tuples where each tuple contains (key, value). Values are automatically deserialized from JSON. Returns empty list if no matches found.

#### Usage Examples

**Get Related Data:**
```python
kv = KV()

# Store related data with common prefix
kv.put("user:123:name", "Alice")
kv.put("user:123:email", "alice@example.com")
kv.put("user:123:age", 30)
kv.put("user:456:name", "Bob")

# Get all data for user 123
user_data = kv.get_partial("user:123:")
for key, value in user_data:
    print(f"{key} = {value}")
# Output:
# user:123:age = 30
# user:123:email = alice@example.com
# user:123:name = Alice
```

**Implement Categories:**
```python
# Store items by category
kv.put("product:electronics:tv1", {"name": "Smart TV", "price": 599})
kv.put("product:electronics:phone1", {"name": "Smartphone", "price": 299})
kv.put("product:clothing:shirt1", {"name": "T-Shirt", "price": 19})

# Get all electronics
electronics = kv.get_partial("product:electronics:")
print(f"Found {len(electronics)} electronic products")
```

---

### delete()

Delete a specific key-value pair from the database.

```python
def delete(self, key: str) -> None
```

#### Description
Removes the entry associated with the given key from storage. If the key doesn't exist, the operation completes without error. This is a safe operation that won't raise exceptions for non-existent keys.

#### Parameters
- **key** `(str)` - *Required*
  The key of the entry to delete.

#### Usage Examples

**Basic Deletion:**
```python
kv = KV()

# Store and delete a value
kv.put("temp_data", "temporary")
print(kv.get("temp_data"))  # "temporary"
kv.delete("temp_data")
print(kv.get("temp_data"))  # None
```

**Delete Non-Existent Key:**
```python
# Safe to delete non-existent keys
kv.delete("non_existent_key")  # No error
```

**Clean Up Session:**
```python
# User logout - remove session
kv.delete("session:current_user")
kv.delete("session:token")
```

---

### delete_partial()

Delete all key-value pairs where keys start with a given prefix.

```python
def delete_partial(self, beginning: str) -> None
```

#### Description
Performs a bulk deletion of all entries whose keys match the specified prefix. This is useful for cleaning up related data, removing all items in a category, or clearing cache entries with a common prefix. The operation is atomic - all matching entries are deleted in a single transaction.

#### Parameters
- **beginning** `(str)` - *Required*
  The prefix to match. All keys starting with this string will be deleted.

#### Usage Examples

**Clear User Data:**
```python
kv = KV()

# Store user-related data
kv.put("user:123:profile", {"name": "Alice"})
kv.put("user:123:settings", {"theme": "dark"})
kv.put("user:123:cache:friends", [1, 2, 3])

# Delete all data for user 123
kv.delete_partial("user:123:")
```

**Clear Cache:**
```python
# Store various cache entries
kv.put("cache:api:users", user_list)
kv.put("cache:api:products", product_list)
kv.put("cache:images:thumb1", thumbnail_data)

# Clear all API cache
kv.delete_partial("cache:api:")

# Clear all cache
kv.delete_partial("cache:")
```

---

### close()

Close the database connection and commit any pending changes.

```python
def close(self) -> None
```

#### Description
Ensures all pending transactions are committed and properly closes the SQLite database connection. This should be called when you're done using the KV instance to free up resources. If using the KV class as a context manager (with statement), this method is called automatically.

#### Usage Examples

**Manual Close:**
```python
kv = KV()
kv.put("data", "value")
kv.close()  # Ensures data is saved and connection is closed
```

**Automatic with Context Manager:**
```python
with KV() as kv:
    kv.put("data", "value")
# close() is called automatically here
```

---

### put_cached()

Add a key-value pair to the cache for batch insertion.

```python
def put_cached(self, key: str, value: Any, ttl_seconds: Optional[int] = None) -> None
```

#### Description
Instead of immediately writing to the database, this method stores the key-value pair in memory. Multiple cached entries can then be committed together in a single transaction using commit_cached(), significantly improving performance for bulk insertions. This is ideal when you need to insert many items at once.

#### Parameters
- **key** `(str)` - *Required*
  The unique identifier for the value.

- **value** `(Any)` - *Required*
  The value to store. Can be any JSON-serializable Python object.

- **ttl_seconds** `(Optional[int])` - *Optional, default: None*
  Time-to-live in seconds. If provided, the entry will automatically expire after this duration.

#### Usage Examples

**Bulk Insert:**
```python
kv = KV()

# Fast bulk insert with caching
for i in range(10000):
    kv.put_cached(f"item:{i}", {"value": i, "squared": i**2})
kv.commit_cached()  # Single transaction for all 10000 items

# Compare with regular put (slower)
for i in range(10000, 20000):
    kv.put(f"item:{i}", {"value": i})  # 10000 separate transactions
```

**Cache with TTL:**
```python
# Add temporary cache entries
for i in range(100):
    kv.put_cached(f"temp:{i}", i, ttl_seconds=300)  # 5 minutes TTL
kv.commit_cached()
```

#### Important Notes
- Cached entries are not accessible until commit_cached() is called
- Memory usage increases with cached entries
- Call commit_cached() to write to database

---

### commit_cached()

Commit all cached key-value pairs to the database in a single transaction.

```python
def commit_cached(self) -> None
```

#### Description
Writes all entries added via put_cached() to the database in one efficient bulk operation. After committing, the cache is cleared. If no cached entries exist, this method does nothing. This method is essential for achieving high performance when inserting many entries.

#### Usage Examples

**Basic Batch Commit:**
```python
kv = KV()

# Add multiple entries to cache
kv.put_cached("user:1", {"name": "Alice", "score": 100})
kv.put_cached("user:2", {"name": "Bob", "score": 85})
kv.put_cached("user:3", {"name": "Charlie", "score": 92})

# Nothing written to database yet
print(kv.get("user:1"))  # None

# Commit all at once
kv.commit_cached()

# Now data is available
print(kv.get("user:1"))  # {"name": "Alice", "score": 100}

# Cache is now empty, safe to call again
kv.commit_cached()  # Does nothing
```

**Import Large Dataset:**
```python
import csv

with KV() as kv:
    with open("data.csv") as f:
        reader = csv.DictReader(f)
        for row in reader:
            kv.put_cached(f"record:{row['id']}", row)

        # Commit all records in single transaction
        kv.commit_cached()
```

#### Important Notes
- Significantly faster than individual put() calls for bulk operations
- All cached entries are committed atomically
- Cache is cleared after successful commit
- Safe to call when cache is empty
