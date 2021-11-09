
### EV_FileListing
Updates to a directory listing.

| Field | Type | Description |
|-------|------|-------------|
| fmid | int32 | null |
| path | string | The directory's absolute path |
| listing | FileListlet | Listing updates |

### RQ_FileListing
Request a directory listing.

| Field | Type | Description |
|-------|------|-------------|
| path | string | null |
| options | FsHandleOptions | null |

### RS_FileListing
Response to a directory listing request.

| Field | Type | Description |
|-------|------|-------------|
| path | string | The directory's absolute path |
| listing | FileListlet | The directory listing |

### RQ_FileInfo
Request for detailed file information.

| Field | Type | Description |
|-------|------|-------------|
| file | string | An absolute path |

### RS_FileInfo
Response to a file info request.

| Field | Type | Description |
|-------|------|-------------|
| local_icon | bytes | The file's icon on the local platform |
| path | string | The file's location |
| name | string | The file's name |
| ctime | int64 | The file's creation time |
| mtime | int64 | The file's modification time |
| atime | int64 | The file's access time |
| size | int64 | The file's size in bytes or number of elements if directory |
| mime | string | The file's MIME type |

### RQ_FileDelete
Request for one or more files to be deleted.

| Field | Type | Description |
|-------|------|-------------|
| target | string | A list of absolute paths to delete |

### RQ_FsHandle
Request to open a new filesystem handle.

| Field | Type | Description |
|-------|------|-------------|
| options | FsHandleOptions | null |

### RS_FsHandle
Response to a handle request.

| Field | Type | Description |
|-------|------|-------------|
| fmid | int32 | The filesystem handle's ID |

### RQ_CloseFsHandle
Request to close the given handle.

| Field | Type | Description |
|-------|------|-------------|
| fmid | int32 | The filesystem handle to close |
