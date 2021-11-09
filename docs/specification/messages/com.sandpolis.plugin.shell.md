
### RQ_Execute
null

| Field | Type | Description |
|-------|------|-------------|
| type | Shell | null |
| command | string | null |

### RS_Execute
null

| Field | Type | Description |
|-------|------|-------------|
| exitCode | int32 | null |
| result | string | null |

### RQ_ListShells
null

| Field | Type | Description |
|-------|------|-------------|

### RS_ListShells
null

| Field | Type | Description |
|-------|------|-------------|
| listing | ShellListing | null |

### RQ_ShellStream
null

| Field | Type | Description |
|-------|------|-------------|
| id | int32 | The desired stream ID |
| type | Shell | The stream type |
| environment | string | null |
| rows | int32 | The number of rows to request |
| cols | int32 | The number of columns to request |

### EV_ShellStream
null

| Field | Type | Description |
|-------|------|-------------|
| data | bytes | The I/O data |
| rows | int32 | Update the number of rows |
| cols | int32 | Update the number of columns |
