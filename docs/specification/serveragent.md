# Server/Agent Messages

| Message               | Sources            | Destinations       | Description                                       |
|-----------------------|--------------------|--------------------|---------------------------------------------------|
| RQ_NoAuth             | `agent`            | `server`           | Request to authenticate the agent session without providing anything |
| RQ_PasswordAuth       | `agent`            | `server`           | Request to authenticate the agent session using a simple password |
| RQ_TokenAuth          | `agent`            | `server`           | Request to authenticate the agent session using a one-time token |
| RQ_AgentMetadata      | `server`           | `agent`            | Request agent metadata                            |
| RS_AgentMetadata      | `agent`            | `server`           | Response containing agent metadata                |
| RQ_FindBootAgent      | `client`, `server` | `agent`            | Request to locate installed boot agents           |
| RS_FindBootAgent      | `agent`            | `client`, `server` | Response listing boot agent installations         |
| RQ_InstallBootAgent   | `client`, `server` | `agent`            | Request a boot agent be installed on the host     |
| RQ_UninstallBootAgent | `client`, `server` | `agent`            | Request a boot agent be uninstalled from the host |
| RQ_LaunchBootAgent    | `client`, `server` | `agent`            | Request that the boot agent be started            |

## Agent Authentication Messages
### RQ_NoAuth

### RQ_PasswordAuth

| Field            | Type       | Requirements              | Description                                              |
|------------------|------------|---------------------------|----------------------------------------------------------|
| password         | string     | 8 - 64 characters         | The password text                                        |

### RQ_TokenAuth

| Field            | Type       | Requirements              | Description                                              |
|------------------|------------|---------------------------|----------------------------------------------------------|
| token            | string     | 8 characters              | The authentication token                                 |

## General Messages
### RQ_AgentMetadata

### RS_AgentMetadata

| Field            | Type       | Requirements              | Description                                              |
|------------------|------------|---------------------------|----------------------------------------------------------|
| hostname         | string     | 0 - 64 characters         | The agent's network hostname                             |
| os               | OsType     |                           | The agent's OS family                                    |
| arch             | string     |                           | The agent's CPU architecture                             |

## Boot Agent Messages
### RQ_FindBootAgent
### RS_FindBootAgent

| Field            | Type       | Requirements              | Description                                              |
|------------------|------------|---------------------------|----------------------------------------------------------|

### RQ_InstallBootAgent
### RQ_UninstallBootAgent

| Field            | Type       | Requirements              | Description                                              |
|------------------|------------|---------------------------|----------------------------------------------------------|
| target_uuid      | string     |                           | The UUID of the partition containing the boot agent      |

### RQ_LaunchBootAgent

| Field            | Type       | Requirements              | Description                                              |
|------------------|------------|---------------------------|----------------------------------------------------------|
| target_uuid      | string     |                           | The UUID of the partition containing the boot agent      |
