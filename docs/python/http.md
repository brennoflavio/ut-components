## HTTP Functions

### Response

HTTP Response wrapper for handling API responses in Ubuntu Touch applications.

```python
class Response:
    def __init__(self, url: str, success: bool, status_code: int, data: bytes)
    def json(self) -> Dict
    def raise_for_status(self)
```

#### Description
This class provides a convenient interface for working with HTTP responses, including automatic text decoding, JSON parsing, and status validation. It encapsulates the response data and provides utility methods for common operations like checking for errors or parsing JSON content.

#### Attributes
- **url** `(str)` - The URL that was requested
- **success** `(bool)` - Whether the request completed without network errors
- **status_code** `(int)` - HTTP status code (200, 404, etc.). 0 for network errors
- **data** `(bytes)` - Raw response body as bytes
- **text** `(str)` - Response body decoded as UTF-8 string

#### Methods

##### json()
Parse the response body as JSON.

**Returns:**
- `Dict` - Parsed JSON data as a Python dictionary or list

**Raises:**
- `json.JSONDecodeError` - If the response body is not valid JSON

##### raise_for_status()
Raise an exception if the request failed or returned an error status.

**Raises:**
- `ValueError` - If success is False (network error) or status_code >= 300

#### Usage Examples

**Basic Response Handling:**
```python
from src.ut_components.http import get

response = get("https://api.example.com/data")
if response.success:
    print(f"Status: {response.status_code}")
    print(f"Data: {response.text}")
else:
    print(f"Request failed: {response.text}")
```

**JSON Parsing:**
```python
response = get("https://api.example.com/user/123")
if response.success:
    user_data = response.json()
    print(f"User name: {user_data['name']}")
```

**Error Handling with raise_for_status():**
```python
response = post("https://api.example.com/data", json={"key": "value"})
try:
    response.raise_for_status()
    data = response.json()
except ValueError as e:
    print(f"Request failed: {e}")
```

---

### request()

Perform a generic HTTP request with automatic redirect handling.

```python
def request(
    url: str,
    method: str,
    data: Optional[bytes] = None,
    headers: Optional[Dict[str, str]] = None,
    follow_redirects: bool = True,
    max_redirects: int = 10,
) -> Response
```

#### Description
This is the core function that handles all HTTP methods. It provides full control over the request, including custom methods, headers, and redirect behavior. It automatically handles various redirect status codes and follows them according to HTTP specifications.

#### Parameters
- **url** `(str)` - *Required*
  The target URL for the request.

- **method** `(str)` - *Required*
  HTTP method (GET, POST, PUT, DELETE, PATCH, etc.).

- **data** `(Optional[bytes])` - *Optional, default: None*
  Request body as bytes.

- **headers** `(Optional[Dict[str, str]])` - *Optional, default: None*
  HTTP headers to include in the request.

- **follow_redirects** `(bool)` - *Optional, default: True*
  Whether to automatically follow HTTP redirects.

- **max_redirects** `(int)` - *Optional, default: 10*
  Maximum number of redirects to follow before failing.

#### Returns
- `Response` - A Response object containing the result of the HTTP request

#### Usage Examples

**Custom PATCH Request:**
```python
from src.ut_components.http import request

response = request(
    url="https://api.example.com/resource/123",
    method="PATCH",
    data=b'{"status": "updated"}',
    headers={"Content-Type": "application/json"}
)
```

**HEAD Request without Following Redirects:**
```python
response = request(
    url="https://example.com/page",
    method="HEAD",
    follow_redirects=False
)
```

#### Important Notes
- Supports any HTTP method
- Handles redirects automatically by default
- Returns Response object for all outcomes (success or failure)

---

### get()

Perform an HTTP GET request to retrieve data from a server.

```python
def get(
    url: str,
    headers: Optional[Dict[str, str]] = None,
    params: Optional[Dict[str, str]] = None,
) -> Response
```

#### Description
GET requests are used to retrieve data from a specified resource. This function simplifies making GET requests by handling query parameter encoding and providing a clean interface for adding custom headers. Query parameters are automatically URL-encoded and appended to the URL.

#### Parameters
- **url** `(str)` - *Required*
  The target URL for the GET request.

- **headers** `(Optional[Dict[str, str]])` - *Optional, default: None*
  HTTP headers to include in the request. Common headers include Authorization, User-Agent, etc.

- **params** `(Optional[Dict[str, str]])` - *Optional, default: None*
  Query parameters to append to the URL. These will be URL-encoded automatically.

#### Returns
- `Response` - A Response object containing the server's response

#### Usage Examples

**Simple GET Request:**
```python
from src.ut_components.http import get

response = get("https://api.example.com/users")
if response.success:
    users = response.json()
```

**GET with Query Parameters:**
```python
response = get(
    url="https://api.example.com/search",
    params={"q": "ubuntu touch", "limit": "10"}
)
```

**GET with Authentication Header:**
```python
response = get(
    url="https://api.example.com/profile",
    headers={"Authorization": "Bearer token123"}
)
```

#### Important Notes
- Query parameters are automatically URL-encoded
- Headers can include authentication tokens
- Returns Response object for processing

---

### post()

Perform an HTTP POST request to send data to a server.

```python
def post(
    url: str,
    json: Optional[Dict] = None,
    headers: Optional[Dict[str, str]] = None
) -> Response
```

#### Description
POST requests are used to submit data to be processed to a specified resource. This function automatically handles JSON serialization and sets the appropriate Content-Type header when JSON data is provided. It's commonly used for creating new resources or submitting form data to APIs.

#### Parameters
- **url** `(str)` - *Required*
  The target URL for the POST request.

- **json** `(Optional[Dict])` - *Optional, default: None*
  Python dictionary to be sent as JSON in the request body. Will be automatically serialized and Content-Type will be set to application/json.

- **headers** `(Optional[Dict[str, str]])` - *Optional, default: None*
  Additional HTTP headers to include. The Content-Type header is automatically set when json is provided.

#### Returns
- `Response` - A Response object containing the server's response

#### Usage Examples

**Create a New User:**
```python
from src.ut_components.http import post

response = post(
    url="https://api.example.com/users",
    json={
        "name": "John Doe",
        "email": "john@example.com"
    }
)
if response.success:
    created_user = response.json()
    print(f"User created with ID: {created_user['id']}")
```

**POST with Custom Headers:**
```python
response = post(
    url="https://api.example.com/messages",
    json={"text": "Hello Ubuntu Touch!"},
    headers={"Authorization": "Bearer token123"}
)
```

#### Important Notes
- Automatically serializes JSON data
- Sets Content-Type header when JSON is provided
- Commonly used for creating resources

---

### put()

Perform an HTTP PUT request to update existing resources on a server.

```python
def put(
    url: str,
    json: Optional[Dict] = None,
    headers: Optional[Dict[str, str]] = None
) -> Response
```

#### Description
PUT requests are used to update or replace an existing resource at a specified URL. This function automatically handles JSON serialization and sets the appropriate Content-Type header when JSON data is provided. It's commonly used for updating entire resources in RESTful APIs.

#### Parameters
- **url** `(str)` - *Required*
  The target URL for the PUT request, typically including the resource identifier.

- **json** `(Optional[Dict])` - *Optional, default: None*
  Python dictionary to be sent as JSON in the request body. Will be automatically serialized and Content-Type will be set to application/json.

- **headers** `(Optional[Dict[str, str]])` - *Optional, default: None*
  Additional HTTP headers to include. The Content-Type header is automatically set when json is provided.

#### Returns
- `Response` - A Response object containing the server's response

#### Usage Examples

**Update an Existing User:**
```python
from src.ut_components.http import put

response = put(
    url="https://api.example.com/users/123",
    json={
        "name": "Jane Doe",
        "email": "jane.doe@example.com",
        "status": "active"
    }
)
if response.success:
    updated_user = response.json()
    print(f"User updated: {updated_user['name']}")
```

**PUT with Authorization:**
```python
response = put(
    url="https://api.example.com/settings/theme",
    json={"theme": "dark", "font_size": "large"},
    headers={"Authorization": "Bearer token123"}
)
```

#### Important Notes
- Used for updating entire resources
- Automatically handles JSON serialization
- Typically requires resource ID in URL

---

### delete()

Perform an HTTP DELETE request to remove a resource from a server.

```python
def delete(
    url: str,
    json: Optional[Dict] = None,
    headers: Optional[Dict[str, str]] = None
) -> Response
```

#### Description
DELETE requests are used to delete a specified resource. While DELETE requests typically don't have a body, this function supports sending JSON data for APIs that require additional information for deletion (like reasons or options). This is commonly used for removing resources in RESTful APIs.

#### Parameters
- **url** `(str)` - *Required*
  The target URL for the DELETE request, typically including the resource identifier.

- **json** `(Optional[Dict])` - *Optional, default: None*
  Optional JSON data to send in the request body. Some APIs require deletion reasons or options. Will be automatically serialized.

- **headers** `(Optional[Dict[str, str]])` - *Optional, default: None*
  Additional HTTP headers to include. The Content-Type header is automatically set when json is provided.

#### Returns
- `Response` - A Response object containing the server's response

#### Usage Examples

**Delete a User:**
```python
from src.ut_components.http import delete

response = delete("https://api.example.com/users/123")
if response.success:
    print("User deleted successfully")
```

**Delete with Reason/Options:**
```python
response = delete(
    url="https://api.example.com/posts/456",
    json={"reason": "Spam content", "notify_author": True}
)
```

**Delete with Authorization:**
```python
response = delete(
    url="https://api.example.com/sessions/current",
    headers={"Authorization": "Bearer token123"}
)
```

#### Important Notes
- Typically doesn't require body data
- Some APIs accept deletion reasons in body
- Returns Response even for successful deletions

---

### post_file()

Upload a file to a server using multipart/form-data encoding.

```python
def post_file(
    url: str,
    file_data: bytes,
    file_name: str,
    file_field: str,
    form_fields: Optional[Dict[str, str]] = None,
    headers: Optional[Dict[str, str]] = None,
) -> Response
```

#### Description
This function handles file uploads by creating a proper multipart/form-data request. It automatically detects the file's MIME type based on the filename and can include additional form fields alongside the file. This is commonly used for uploading images, documents, or other files to web services.

#### Parameters
- **url** `(str)` - *Required*
  The target URL for the file upload.

- **file_data** `(bytes)` - *Required*
  The file content as bytes. You need to read the file into memory before passing it to this function.

- **file_name** `(str)` - *Required*
  The name of the file being uploaded. Used for MIME type detection and sent to the server as the filename.

- **file_field** `(str)` - *Required*
  The form field name for the file. This is the parameter name the server expects for the file upload.

- **form_fields** `(Optional[Dict[str, str]])` - *Optional, default: None*
  Additional form fields to include with the file upload. These are sent as regular form data.

- **headers** `(Optional[Dict[str, str]])` - *Optional, default: None*
  Additional HTTP headers to include. The Content-Type header is automatically set with the boundary.

#### Returns
- `Response` - A Response object containing the server's response

#### Usage Examples

**Upload a Profile Picture:**
```python
from src.ut_components.http import post_file

# Read file content
with open("avatar.png", "rb") as f:
    file_content = f.read()

response = post_file(
    url="https://api.example.com/upload",
    file_data=file_content,
    file_name="avatar.png",
    file_field="profile_pic"
)
if response.success:
    result = response.json()
    print(f"File uploaded: {result['url']}")
```

**Upload with Additional Form Fields:**
```python
response = post_file(
    url="https://api.example.com/documents",
    file_data=document_bytes,
    file_name="report.pdf",
    file_field="document",
    form_fields={
        "title": "Q4 Report",
        "category": "financial",
        "public": "false"
    },
    headers={"Authorization": "Bearer token123"}
)
```

#### Important Notes
- Automatically detects MIME type from filename
- Creates proper multipart/form-data request
- Can include additional form fields with file
- File must be read into memory before uploading
