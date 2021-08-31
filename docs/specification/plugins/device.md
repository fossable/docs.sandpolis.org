# Device Plugin
The device plugin extends management functionality out to agent-less devices.

## Subagents
Subagents are devices that do not have Sandpolis agent software installed, but are
instead managed via a third-party protocol such as SSH, IPMI, or SNMP from an instance
called the _gateway_. The gateway instance for a subagent may be an independent
agent or a server.

### Communicators
A subagent communicates to its gateway instance over one of the following well-known
protocols. Since subagents must accept incoming connections, the gateway instance
usually must reside on the same network segment.

#### SSH
The SSH communicator establishes SSH sessions with remote devices.

| Property   | Description |
|------------|-------------|
| `ssh.username` | The SSH username |
| `ssh.password` | The SSH password |
| `ssh.private_key` | The SSH private key |

#### IPMI
The IPMI communicator runs IPMI commands on remote devices.

| Property   | Description |
|------------|-------------|
| `ipmi.username` | The IPMI username |
| `ipmi.password` | The IPMI password |

#### SNMP
The SNMP communicator reads and writes standard MIBs on remote devices.

| Property   | Description |
|------------|-------------|
| `snmp.version` | The SNMP version |
| `snmp.community` | The SNMP community string if version < 3 |
| `snmp.privacy.type` |
| `snmp.privacy.secret` |
| `snmp.authentication.type` |
| `snmp.authentication.secret` |

## Messages

| Message                                   | Sources           | Destinations      |
|-------------------------------------------|-------------------|-------------------|
| [RQ_FindSubagents](#rq_findsubagents)     | `client`, `server` | `agent`          |
| [RS_FindSubagents](#rs_findsubagents)     | `agent`           | `client`, `server` |
| RQ_RegisterSubagent                       | `client`          | `server`          |
| RQ_ConfigureSubagent                      | `server`          | `agent`           |
| RQ_IpmiCommand                            |
| RQ_SnmpWalk                               |
| RQ_SshCommand                             |

### RQ_RegisterSubagent

| Field            | Type       | Requirements              | Description                                              |
|------------------|------------|---------------------------|----------------------------------------------------------|
| gateway_uuid     | `string`   |                           | The UUID of the subagent's gateway instance              |
| ip_address       | `string`   |

### RQ_FindSubagents
Scan the local network (if it's smaller than a /16) for devices that may be candidate subagents.

- For the `ssh` communicator, a TCP connection is attempted on port 22
- For the `snmp` communicator, probes are sent via UDP port 161
- For the `ipmi` communicator, probes are sent via UDP port 623

| Field            | Type       | Requirements              | Description                                              |
|------------------|------------|---------------------------|----------------------------------------------------------|
| gateway_uuid     | `string`   |                           | The UUID of a gateway instance                           |
| communicators    | `repeated string` | `ssh`, `snmp`, `ipmi` | The communicator types to search                      |

### RS_FindSubagents

| Field                    | Type       | Requirements              | Description                                              |
|--------------------------|------------|---------------------------|----------------------------------------------------------|
| ssh_device::ip_address   | `string`   | IPv4 or IPv6 address      | Device IP address                                        |
| ssh_device::mac_address  | `string`   | MAC address               | Device MAC address                                       |
| ssh_device::fingerprint  | `string`   |                           | Device SSH fingerprint
| snmp_device::ip_address  | `string`   | IPv4 or IPv6 address      | Device IP address                                        |
| ipmi_device::ip_address  | `string`   | IPv4 or IPv6 address      | Device IP address                                        |

### RQ_SnmpWalk

| Field                    | Type       | Requirements              | Description                                              |
|--------------------------|------------|---------------------------|----------------------------------------------------------|
| oid                      | `string`   | An OID string             | Request an SNMP walk operation be executed               |

### RS_SnmpWalk

| Field                    | Type       | Requirements              | Description                                              |
|--------------------------|------------|---------------------------|----------------------------------------------------------|
| data::oid                | string     |
| data::type               | string     |
| data::value              | string     |
