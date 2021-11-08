# Server

## Installation Types

There are two ways to install the server with the recommended approach being
Docker.

### Package Manager Installation

#### Filesystem Layout

##### Pacman (Arch Linux)

| Path                                               | Description                |
| -------------------------------------------------- | -------------------------- |
| `/usr/lib/systemd/system/sandpolis-server.service` | Systemd service definition |
| `/usr/share/java/sandpolis-server/lib`             | `LIB` location             |
| `/usr/share/java/sandpolis-server/plugin`          | `PLUGIN` location          |
| `/var/lib/sandpolis-server/data`                   | `DATA` location            |

### Docker Installation
