# Server/Agent Messages

| Message                    | Sources            | Destinations       | Description                                                                                 |
| -------------------------- | ------------------ | ------------------ | ------------------------------------------------------------------------------------------- |
| RQ_AuthSession             | `agent`            | `server`           | Request to authenticate an agent session                                                    |
| RQ_RefreshAuthCertificate  | `server`           | `agent`            | Request to refresh an agent's authentication certificate                                    |
| RQ_AgentMetadata           | `server`           | `agent`            | Request agent metadata                                                                      |
| RS_AgentMetadata           | `agent`            | `server`           | Response containing agent metadata                                                          |
| RQ_FindBootAgents          | `client`, `server` | `agent`            | Request to locate all installed boot agents                                                 |
| RS_FindBootAgents          | `agent`            | `client`, `server` | Response listing boot agent installations                                                   |
| RQ_FindBootAgentCandidates | `client`, `server` | `agent`            | Request candidate partitions and devices that may be suitable for a boot agent installation |
| RS_FindBootAgentCandidates | `agent`            | `client`, `server` | Response listing boot agent installation candidates                                         |
| RQ_InstallBootAgent        | `client`, `server` | `agent`            | Request a boot agent be installed on the system                                             |
| RQ_UninstallBootAgent      | `client`, `server` | `agent`            | Request a boot agent be uninstalled from the system                                         |
| RQ_LaunchBootAgent         | `client`, `server` | `agent`            | Request that the boot agent be started                                                      |
| RQ_ChangePowerState        | `client`, `server` | `agent`            | Request that the agent alter its power state                                                |

## Agent Authentication Messages

### RQ_AuthSession

| Field    | Type   | Requirements      | Description              |
| -------- | ------ | ----------------- | ------------------------ |
| password | string | 8 - 64 characters | The password text        |
| token    | string | 8 characters      | The authentication token |

### RQ_RefreshAuthCertificate

| Field | Type | Requirements | Description |
| ----- | ---- | ------------ | ----------- |

## General Messages

### RQ_AgentMetadata

### RS_AgentMetadata

| Field               | Type   | Requirements      | Description                                     |
| ------------------- | ------ | ----------------- | ----------------------------------------------- |
| hostname            | string | 0 - 64 characters | The agent's network hostname                    |
| os                  | OsType |                   | The agent's OS family                           |
| arch                | string |                   | The agent's CPU architecture                    |
| boot_agent_detected | bool   |                   | Whether a boot agent was detected on the system |

## Boot Agent Messages

### RQ_FindBootAgents

| Field | Type | Requirements | Description |
| ----- | ---- | ------------ | ----------- |

### RS_FindBootAgents

| Field | Type | Requirements | Description |
| ----- | ---- | ------------ | ----------- |

### RQ_InstallBootAgent

| Field          | Type   | Requirements | Description                                                     |
| -------------- | ------ | ------------ | --------------------------------------------------------------- |
| partition_uuid | string |              | The UUID of the target partition                                |
| device_uuid    | string |              | The UUID of the target device                                   |
| interface_mac  | string |              | The MAC address of the network interface to use for connections |
| use_dhcp       | bool   |              | Whether DHCP will be used                                       |
| static_ip      | string |              | A static IP address as an alternative to DHCP                   |
| netmask        | string |              | The netmask corresponding to the static IP                      |
| gateway_ip     | string |              | The gateway IP                                                  |

### RS_InstallBootAgent

| Field                            | Description |
| -------------------------------- | ----------- |
| INSTALL_BOOT_AGENT_OK            |
| INSTALL_BOOT_AGENT_ACCESS_DENIED |

### RQ_UninstallBootAgent

| Field       | Type   | Requirements | Description                                         |
| ----------- | ------ | ------------ | --------------------------------------------------- |
| target_uuid | string |              | The UUID of the partition containing the boot agent |

### RS_UninstallBootAgent

| Field                              | Description |
| ---------------------------------- | ----------- |
| UNINSTALL_BOOT_AGENT_OK            |
| UNINSTALL_BOOT_AGENT_ACCESS_DENIED |

### RQ_LaunchBootAgent

| Field       | Type   | Requirements | Description                                         |
| ----------- | ------ | ------------ | --------------------------------------------------- |
| target_uuid | string |              | The UUID of the partition containing the boot agent |

### RS_LaunchBootAgent

| Field                           | Description |
| ------------------------------- | ----------- |
| LAUNCH_BOOT_AGENT_OK            |
| LAUNCH_BOOT_AGENT_ACCESS_DENIED |
| LAUNCH_BOOT_AGENT_FAILED        |

### RQ_ChangePowerState

| Field     | Type   | Requirements | Description             |
| --------- | ------ | ------------ | ----------------------- |
| new_state | string |              | The desired power state |
