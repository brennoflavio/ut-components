## Memoization Functions

### memoize()

Decorator factory for caching function results with time-to-live (TTL).

```python
def memoize(ttl_seconds: int)
```

#### Description
This decorator implements memoization, which caches the results of expensive function calls and returns the cached result when the same inputs occur again. The cache automatically expires after the specified TTL period, ensuring data freshness. This is particularly useful for functions that perform expensive computations, database queries, or API calls. The decorator uses a key-value store to persist cache across application restarts and creates unique cache keys based on the function name and arguments.

#### Parameters
- **ttl_seconds** `(int)` - *Required*
  Time-to-live for cached results in seconds. After this period, the cache expires and the function will be executed again.

#### Returns
- `Callable` - A decorator function that can be applied to any function.

#### Usage Examples

**Basic Memoization:**
```python
from src.ut_components import setup
from src.ut_components.memoize import memoize
import time

# Initialize the library
setup(app_name="MyApp")

@memoize(ttl_seconds=3600)  # Cache for 1 hour
def expensive_api_call(user_id: str, endpoint: str):
    # Simulating an expensive operation
    time.sleep(2)
    return f"Data for user {user_id} from {endpoint}"

# First call takes 2 seconds
result1 = expensive_api_call("user123", "/profile")

# Second call with same arguments returns instantly from cache
result2 = expensive_api_call("user123", "/profile")

# Different arguments create a new cache entry
result3 = expensive_api_call("user456", "/profile")
```

**Cache Database Queries:**
```python
@memoize(ttl_seconds=300)  # Cache for 5 minutes
def get_user_stats(user_id: int):
    # Expensive database aggregation
    return db.query(f"""
        SELECT COUNT(*) as posts,
               AVG(likes) as avg_likes
        FROM posts
        WHERE user_id = {user_id}
    """)

# First call hits database
stats = get_user_stats(42)

# Subsequent calls within 5 minutes use cache
quick_stats = get_user_stats(42)
```

**Cache Complex Computations:**
```python
@memoize(ttl_seconds=86400)  # Cache for 24 hours
def calculate_recommendations(user_preferences: dict, catalog: list):
    # Complex ML algorithm
    scores = []
    for item in catalog:
        score = complex_scoring_algorithm(user_preferences, item)
        scores.append((item, score))
    return sorted(scores, key=lambda x: x[1], reverse=True)[:10]

# Results cached for a full day
recommendations = calculate_recommendations(
    {"likes": ["action", "sci-fi"]},
    movie_catalog
)
```

#### Important Notes
- Function arguments must be JSON-serializable for caching to work
- Cached results are stored in a persistent KV store
- Each unique combination of arguments creates a separate cache entry
- Non-serializable objects like custom classes, datetime objects, or sets will cause the decorator to fail
- Cache persists across application restarts

---

### delete_memoized()

Clear all cached entries for a specific memoized function.

```python
def delete_memoized(function: Callable)
```

#### Description
This function removes all cached results for the specified function, regardless of what arguments were used when calling it. This is useful when you need to invalidate the cache for a function, such as after updating underlying data or when testing. The function uses partial key deletion to remove all cache entries that match the function's hashed name pattern.

#### Parameters
- **function** `(Callable)` - *Required*
  The memoized function whose cache should be cleared. Must be the actual function object that was decorated with @memoize.

#### Usage Examples

**Clear Cache After Data Update:**
```python
from src.ut_components import setup
from src.ut_components.memoize import memoize, delete_memoized

setup(app_name="MyApp")

@memoize(ttl_seconds=3600)
def get_user_data(user_id: str):
    # Expensive database query
    return fetch_from_database(user_id)

# Use the function normally
data1 = get_user_data("user123")  # Fetches from database
data2 = get_user_data("user123")  # Returns from cache

# User updates their profile
update_user_profile("user123", new_data)

# Clear all cached results for this function
delete_memoized(get_user_data)

# Next call will fetch fresh data from database
data3 = get_user_data("user123")  # Fetches from database
```

**Clear Cache in Tests:**
```python
@memoize(ttl_seconds=3600)
def external_api_call(endpoint: str):
    return requests.get(f"https://api.example.com{endpoint}").json()

def test_api_integration():
    # Clear any existing cache
    delete_memoized(external_api_call)

    # Test with fresh API calls
    result = external_api_call("/users")
    assert "users" in result

    # Clear cache after test
    delete_memoized(external_api_call)
```

**Refresh Cache on Demand:**
```python
@memoize(ttl_seconds=1800)  # 30 minutes
def get_trending_topics():
    return analyze_social_media_feeds()

# Admin endpoint to force cache refresh
def refresh_trending():
    delete_memoized(get_trending_topics)
    # Pre-warm the cache with fresh data
    return get_trending_topics()
```

#### Important Notes
- Removes ALL cached entries for the function, regardless of arguments
- Must pass the actual decorated function object
- Does not affect other memoized functions
- Safe to call even if no cache entries exist

---

### hash_function_name()

Generate a unique hash identifier for a function based on its name and module.

```python
def hash_function_name(func: Callable) -> str
```

#### Description
This helper function creates a SHA1 hash of the function's fully qualified name (module + function name) to uniquely identify functions in the cache system. It ensures that functions with the same name in different modules get different cache keys.

#### Parameters
- **func** `(Callable)` - *Required*
  The function object to generate a hash for.

#### Returns
- `str` - A hexadecimal SHA1 hash string representing the function's unique identifier.

#### Usage Examples

**Generate Function Identifier:**
```python
from src.ut_components.memoize import hash_function_name

def my_function():
    pass

hash_id = hash_function_name(my_function)
print(hash_id)  # e.g., "a3c65c2974270fd093ee8..."
```

#### Important Notes
- Used internally by the memoize decorator
- Ensures unique identification across modules
- Returns consistent hash for the same function

---

### hash_function_args()

Generate a unique hash identifier for function arguments.

```python
def hash_function_args(args, kwargs) -> str
```

#### Description
This helper function creates a SHA1 hash of the function's arguments (both positional and keyword arguments) by JSON-serializing them. This allows the cache system to differentiate between different function calls with different arguments.

#### Parameters
- **args** - *Required*
  Positional arguments passed to the function.

- **kwargs** - *Required*
  Keyword arguments passed to the function.

#### Returns
- `str` - A hexadecimal SHA1 hash string representing the arguments' unique identifier.

#### Usage Examples

**Generate Arguments Hash:**
```python
from src.ut_components.memoize import hash_function_args

hash_id = hash_function_args(("hello", 42), {"key": "value"})
print(hash_id)  # e.g., "b7c4d8f2a91e3..."
```

#### Important Notes
- Arguments must be JSON-serializable
- Non-serializable objects like custom classes, datetime objects, or sets will cause this function to fail
- Used internally by the memoize decorator
- Order of arguments matters for the hash
