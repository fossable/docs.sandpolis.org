# Agent Instance
At a general level, agents are responsible for carrying out tasks for remote
users. They can connect over the network to any other type of instance. At minimum,
agents must be associated with one server.

## Build Metadata

| Property   | Description |
|------------|-------------|
| `s7s.build.version` | The instance's version string |
| `s7s.build.platform` | The build platform's name |
| `s7s.build.timestamp` | UTC epoch timestamp |

## Agent Configuration
The agent's configuration is represented in standard Java properties format and
is named `agent.properties`. The configuration may be embedded in the agent's executable
or configured by the user at runtime.

| Property   | Description |
|------------|-------------|
| `s7s.agent.network.server_address` | A CSV of IP addresses or domain names including port information |
| `s7s.agent.network.timeout` | The server connection timeout in milliseconds |
| `s7s.agent.network.strict_certs` | The agent will refuse to connect to a server that presents an invalid certificate |
| `s7s.agent.network.polling_interval` | The connection poll interval in milliseconds |

## Connection Modes
There are two connection modes that have an impact on performance and latency.

### Continuous
In continuous mode, the agent maintains its primary connection at all times.
If the connection is lost, the agent will periodically attempt to reestablish the
connection using the same parameters it used to establish the initial connection.

The connection mode can be changed on-the-fly by a user or scheduled to change
automatically according to the time and day.

### Polling
In polling mode, the agent intentionally closes the primary connection unless there
exists an active stream. On a configurable schedule, the agent reconnects to a
server, flushes any cached data, and checks for any new work items. After executing
all available work items, the primary connection is closed again.

The agent may attempt a spontaneous connection outside of the regular schedule if
an internal agent process triggers it.

## Plugins
Agents can optionally support plugins to enhance functionality beyond the standard
feature set. Upon initial connection, the agent provides a list of plugin versions
that it has loaded. The server responds with a list of plugin archives that the
agent should install.

## Standard Feature Set
The standard feature set is the minimum amount of functionality an agent implementation
must provide.

### AgentMetadata

## Upgrades
There are two ways to upgrade the agent:
- automatically by sending the update command to the server,
- manually by generating a new installer and executing it on the agent  

### Manual Upgrade
A manual upgrade is triggered when an installer is executed on the agent and the
relevant base directory is already populated with an installation. If the agent
is not running, the installer will overwrite the base directory and install itself.
Any data that the agent has cached but not sent to the server will be lost!

Advantages
- This is the only way to upgrade if the agent can no longer connect to the server

Disadvantages
- Manual intervention required
- Cached data may be lost

### Automated Upgrade
If the agent is connected to a server, it can be upgraded remotely. This will cause
the server to fetch the agent configuration, generate a new installer, and transfer
it to the agent. The agent then executes the new installer and terminates.

### Container Resident

## Boot Agent
Boot agents are a special subset of agent instances that run in a custom UEFI boot
environment rather than on a host's OS.

### Configuration
The boot agent accepts the following specific configuration options.

| Property                           | Default      | Description                                    |
|------------------------------------|--------------|------------------------------------------------|
| `s7s.agent.boot.network.interface` |              | A specific network interface to use            |
| `s7s.agent.boot.network.dhcp`      | true         | Whether the boot agent will attempt to obtain a DHCP address  |
| `s7s.agent.boot.network.ip`        |              | A static IPv4 that will be used instead of DHCP |
| `s7s.agent.boot.network.netmask`   |              | The network mask for the static IPv4 address   |

### Boot Environment
The boot agent environment occupies an entire partition on the host and contains:

- A bootloader
- A Linux kernel
- `efibootmgr` executables
- Boot agent executables
- All library dependencies

### Startup
The boot environment does not provide a shell and merely executes the boot agent
on startup.

The boot agent immediately spawns an infinite connection loop for the configured
server.

### Installation
Agent instances are capable of installing a boot agent on their host machine if
installed with sufficient permissions.

downloads a boot agent image to the
partition and writes a new configuration according to parameters of the host OS
or overrides provided by a client.

Once the partition is written, the agent adds it to the end of the existing EFI
boot order.

#### Host Media
In order to install the boot agent to the existing disk, a new partition of at
least 250 MiB must first be created manually. The agent installs an additional
bootloader to the existing ESP.

#### Removable Media
The agent can erase an existing disk and create a new ESP and boot agent partition.

### Uninstallation
To uninstall, an agent must remove the boot agent's entry in the EFI boot order
and overwrite all data in the boot agent partition.

### Reboot into boot agent
Agents can launch the boot agent indirectly by setting the `BootNext` variable
to the index of the boot agent EFI entry and rebooting the machine.
