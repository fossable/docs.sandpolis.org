
### RQ_Session
Request that a new session be created. Any previous sessions associated with the
instance are invalidated.

| Field | Type | Description |
|-------|------|-------------|
| instance_uuid | string | The UUID of the requesting instance |
| instance_type | core.instance.InstanceType | The instance type of the requesting instance |
| instance_flavor | core.instance.InstanceFlavor | The instance flavor of the requesting instance |

### RS_Session
Respond to a session request with a successful result.

| Field | Type | Description |
|-------|------|-------------|
| instance_sid | int32 | A SID for the requesting instance |
| server_sid | int32 | The SID of the server |
| server_uuid | string | The UUID of the server |

### RQ_DirectConnection
Request the server for a new direct connection.

| Field | Type | Description |
|-------|------|-------------|
| cvid | int32 | The requested node |
| type | LinkType | The type of connection |
| port | int32 | An optional listener port. If specified, the requested node will attempt
a connection on this port. Otherwise, the server will coordinate the connection. |

### RS_DirectConnection
Server response to a connection request.

| Field | Type | Description |
|-------|------|-------------|
| request | RQ_Connection | The connection request |

### RQ_Connection
Request the instance to establish a new connection.

| Field | Type | Description |
|-------|------|-------------|
| host | string | The host |
| port | int32 | The port |
| type | LinkType | The link type |

### EV_EndpointClosed
Indicates that a connection has been lost.

| Field | Type | Description |
|-------|------|-------------|
| cvid | int32 | The node that has lost connection |

### EV_NetworkDelta
Indicates that the network has been updated.

| Field | Type | Description |
|-------|------|-------------|
| node_added | NodeAdded | null |
| node_removed | NodeRemoved | null |
| link_added | LinkAdded | null |
| link_removed | LinkRemoved | null |

### RQ_StopStream
null

| Field | Type | Description |
|-------|------|-------------|
| id | int32 | The stream ID of the stream to stop |

### RS_StopStream
null

| Field | Description |
|-------|-------------|
| STOP_STREAM_OK | 0 |
| STOP_STREAM_INVALID | 1 |
