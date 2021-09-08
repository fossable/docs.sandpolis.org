# Standard Agent
This JVM-based agent implementation has the most features and is consequently
the most resource intensive. It's suitable when running on modern hardware where
memory/storage is abundant.

## Installation Types
There are three ways to install the agent, each with advantages and disadvantages.

### Package Manager Installation
This option makes installation itself easy, but requires some effort to configure
the agent to connect to a server. This installation type also means that upgrades
must only occur through the package manager.

#### Filesystem Layout
##### Pacman (Arch Linux)
| Path                                              | Description                |
|---------------------------------------------------|----------------------------|
| `/usr/lib/systemd/system/sandpolis-agent.service` | Systemd service definition |
| `/usr/bin/sandpolis-agent-config`                 | Configuration executable   |
| `/usr/bin/sandpolis-agent`                        | Main executable            |
| `/usr/share/java/sandpolis-agent/lib`             | `LIB` location             |
| `/usr/share/java/sandpolis-agent/plugin`          | `PLUGIN` location          |
| `/var/lib/sandpolis-agent/data`                   | `DATA` location            |

##### Apk (Alpine)

### Distagent Installation
This option requires no explicit configuration, but the _distagent_ executable
must be transferred to the host and invoked explicitly.

#### Filesystem Layout
Distagents install everything under a single _base directory_ and create symbolic
links in certain locations outside of the base directory.

| Platform | Default base directory path |
|----------|-----------------------------|
| Linux    | `/opt/sandpolis-agent`      |
| Windows  |                             |
| macOS    |                             |

### Docker Installation
This option is easy to deploy and configure, but can limit the functionality of
the agent in some cases.

Certain elements of the host filesystem may be optionally mounted into the container.
