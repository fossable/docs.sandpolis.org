# Net Messages

## Session
Clients and agents maintain an ephemeral session which consists of a session identifier
and authentication state.

### RQ_Session
Request that a new session be created. Any previous sessions associated with the
instance are invalidated.

#### Message Format
| Field            | Type       | Requirements              | Description                                              |
|------------------|------------|---------------------------|----------------------------------------------------------|
| instance_uuid    | string     |                           |   |
| instance_type    | string     |                           |   |
| instance_flavor  | string     |                           |   |

### RS_Session
Respond to a session request with a successful result.

#### Message Format
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

#### Message Format
| Field            | Type       | Requirements              | Description                                              |
|------------------|------------|---------------------------|----------------------------------------------------------|
| host             | string     | An IP address             | The connection host  |
| port             | int32      | A valid port number       | The connection port  |
| protocol         | string     | `tcp` or `udp`            | The connection protocol  |
| encryption_key   | bytes      | 64 bytes                  | The initial encryption key for the new connection        |

### EV_NetworkChanged
Indicates that some node in the network has changed in connection status.

#### Message Format
| Field            | Type       | Requirements              | Description                                              |
|------------------|------------|---------------------------|----------------------------------------------------------|
| added_node       |            |                           |   |
| removed_node     |            |                           |   |
| added_connection |            |                           |   |
| removed_connection |          |                           |   |
