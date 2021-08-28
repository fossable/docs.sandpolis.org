# Net Messages

| Message              | Sources           | Destinations      | Description                                       |
|----------------------|-------------------|-------------------|---------------------------------------------------|
| RQ_Session           | `client`, `agent` | `server`          |
| RS_Session           | `server`          | `client`,`agent`  |
| RQ_AddConnection     | `client`          | `server`          |
| RQ_CoordinateConnection | `server`       | `client`, `agent` |
| EV_NetworkChanged    | `server`          | `client`, `agent` | Indicates that some node in the network has changed in connection status |
| RQ_InstallPlugin     | `client`          | `server`          | Request that a new plugin be installed            |
| RQ_STStream          | `client`, `agent` | `server`          | Request a new state tree sync stream              |
| EV_STStreamData      | `server`          | 
| RQ_CloseStream       |                   |                   | Request that a stream be closed                   |

## Session
Clients and agents maintain an ephemeral session which consists of a session identifier
and authentication state.

### RQ_Session
Request that a new session be created. Any previous sessions associated with the
instance are invalidated.

| Field            | Type       | Requirements              | Description                                              |
|------------------|------------|---------------------------|----------------------------------------------------------|
| instance_uuid    | string     |                           |   |
| instance_type    | string     |                           |   |
| instance_flavor  | string     |                           |   |

### RS_Session
Respond to a session request with a successful result.

| Field            | Type       | Requirements              | Description                                              |
|------------------|------------|---------------------------|----------------------------------------------------------|
| instance_cvid    | int32      |                           |   |
| server_cvid      | int32      |                           |   |
| server_uuid      | int32      |                           |   |

### RQ_AddConnection

## Network

### RQ_CoordinateConnection
Request that the receiving instance establish a new connection to the given host.
The receiver should attempt the connection as soon as possible.

| Field            | Type       | Requirements              | Description                                              |
|------------------|------------|---------------------------|----------------------------------------------------------|
| host             | string     | An IP address             | The connection host  |
| port             | int32      | A valid port number       | The connection port  |
| protocol         | string     | `tcp` or `udp`            | The connection protocol  |
| encryption_key   | bytes      | 64 bytes                  | The initial encryption key for the new connection        |

### EV_NetworkChanged

| Field            | Type       | Requirements              | Description                                              |
|------------------|------------|---------------------------|----------------------------------------------------------|
| added_node       |            |                           |   |
| removed_node     |            |                           |   |
| added_connection |            |                           |   |
| removed_connection |          |                           |   |

## State Tree

### RQ_STStream

| Field            | Type       | Requirements              | Description                                              |
|------------------|------------|---------------------------|----------------------------------------------------------|
| stream_id        | int32      |
| oid              | string     |                           |
| whitelist        | repeated string |                      |
| direction        | string     | "upstream", "downstream", or "bidirectional" |

### EV_STStreamData

### RQ_CloseStream

| Field            | Type       | Requirements              | Description                                              |
|------------------|------------|---------------------------|----------------------------------------------------------|
| stream_id        | int32      |                           | The ID of the stream to close                            |
