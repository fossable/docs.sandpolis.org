
### RQ_Ping
Ping request.

| Field | Type | Description |
|-------|------|-------------|

### RS_Ping
Ping response.

| Field | Type | Description |
|-------|------|-------------|

### RQ_PluginOperation
Request: Attempt a plugin operation.

| Field | Type | Description |
|-------|------|-------------|
| operation | PluginOperation | null |
| plugin_config | core.instance.PluginConfig | null |

### RS_PluginSync
null

| Field | Type | Description |
|-------|------|-------------|
| plugin_config | core.instance.PluginConfig | null |

### RQ_ArtifactDownload
A request to download an artifact.

| Field | Type | Description |
|-------|------|-------------|
| coordinates | string | The coordinates of the artifact to download |
| location | bool | Whether it's acceptable to receive the external location of the artifact only |

### RS_ArtifactDownload
The download response bearing the artifact binary or the artifact's address.

| Field | Type | Description |
|-------|------|-------------|
| binary | bytes | The artifact binary |
| url | string | The artifact's HTTP location |
| coordinates | string | The artifact's maven central coordinates |

### RQ_PluginInstall
A request to install a server plugin.

| Field | Type | Description |
|-------|------|-------------|
| plugin_binary | bytes | The plugin binary |
| plugin_url | string | The plugin's HTTP location |
| plugin_coordinates | string | The plugin's maven central coordinates |

### RS_PluginInstall
null

| Field | Description |
|-------|-------------|
| PLUGIN_INSTALL_OK | 0 |
| PLUGIN_INSTALL_FAILED | 1 |
| PLUGIN_INSTALL_FAILED_DISABLED | 2 |
| PLUGIN_INSTALL_FAILED_CERTIFICATE | 3 |
| PLUGIN_INSTALL_INVALID | 4 |

### RQ_STStream
null

| Field | Type | Description |
|-------|------|-------------|
| stream_id | int32 | null |
| permanent | bool | null |
| oid | string | null |
| whitelist | string | null |
| direction | Direction | null |
| update_period | int32 | null |

### RS_STStream
null

| Field | Description |
|-------|-------------|
| ST_STREAM_OK | 0 |
| ST_STREAM_INVALID | 1 |
| ST_STREAM_FAILED | 2 |

### EV_STStreamData
null

| Field | Type | Description |
|-------|------|-------------|
| oid | string | The object's relative OID |
| removed | bool | Whether the object corresponding to the OID was removed |
| value_type | ValueType | The attribute value type |
| timestamp | int64 | The timestamp associated with the attribute value |
| bytes | bytes | null |
| bytes_array | bytes | null |
| string | string | null |
| string_array | string | null |
| integer | int32 | null |
| integer_array | int32 | null |
| long | int64 | null |
| long_array | int64 | null |
| boolean | bool | null |
| boolean_array | bool | null |
| double | double | null |
| double_array | double | null |
