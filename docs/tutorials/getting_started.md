# Getting Started

If you just want to demo Sandpolis, try connecting to the official demo server
(`demo.sandpolis.com`) with the desktop client. You'll be able to look around at
simulated systems, but won't be able to add your own agents.

Otherwise, if you want to run your own Sandpolis network, the first thing you
need is a private server instance.

## Deploying the Server

There are several different ways to install the server. The universal installer
is a user-friendly method that will work on just about every system, but a
specialized distribution package or Docker container is the most convenient
option for keeping the server updated.

### With Docker

The server can be run as a Docker container with the following command:

```sh
docker run \
	--name sandpolis-server \
	--restart unless-stopped \
	-p 8678:8678 \
	sandpolis/server:latest
```

!!! note If your instance isn't starting on boot, ensure the Docker daemon is
configured to start automatically: `sh sudo systemctl enable docker`

The default admin password will be printed in the container's log which can be
viewed with the following command:

```sh
docker logs sandpolis-server
```

### With a distribution package

#### Pacman (Arch Linux)

Download either the stable or development package from the AUR:

```sh
# Stable
wget https://aur.archlinux.org/cgit/aur.git/snapshot/sandpolis.tar.gz

# Development
wget https://aur.archlinux.org/cgit/aur.git/snapshot/sandpolis-git.tar.gz
```

Install with `makepkg`:

```sh
tar xf sandpolis.tar.gz
cd sandpolis
makepkg -sif
```

Start and optionally enable the server's `systemd` service unit:

```sh
# Start the server process
sudo systemctl start sandpolisd.service

# Configure the server to start on boot
sudo systemctl enable sandpolisd.service
```

### With the universal installer GUI

- <a href="https://sandpolis.com/download" target="_blank">Download</a> the
  universal installer for your operating system.

!!! note Although the server runs on any platform, it's extremely convenient to
manage the server process with `systemctl` on Linux.

- Select **server** from the available components and choose "install".

## Installing a Client

There are several official client applications that can be used to connect to a
server. Not all of them have the same capabilities, so choose the variant that
meets your needs best.

### Sandpolis Desktop Client

### Sandpolis for iOS

The
[Sandpolis iOS application](https://apps.apple.com/us/app/sandpolis/id1478068506)
can be installed from the App Store and supports iPhone and iPad devices running
iOS 13.0 or greater.

## Installing the Agent

Once you're logged into a server, the last thing to do is install an agent. As
with clients, there are several choices that are suitable in different
environments.

### Standard Agent

The standard agent has the most features and highest performance impact. It runs
on the JVM and is multi-platform.

### Native Agent

The native agent has fewer features and a much smaller resource requirement.
It's platform-specific.

### Minimal Agent

The minimal agent has no external dependencies and is designed to run on highly
resource constrained platforms.

### Deployment Types

In addition to different agent types, there are a few different ways each can be
deployed.

#### Standard Deploy

The typical way to deploy an agent is by installing it with your platform's
package manager and configuring it on first run. When prompted, enter the
server's address, an optional password, and an optional time-based alphanumeric
token provided in the client's user interface.

!!! note This deployment method is not available for the minimal agent.

##### Container Resident

All agent types can also be deployed as Docker containers. For example:

```sh
docker run \
	--name sandpolis-agent \
	--restart unless-stopped \
	-v /:/host:ro \
	sandpolis/agent
```

This mounts the host's filesystem into the container with read-only permissions
which is the most common usage.

#### SSH Deploy

The SSH deploy is most convenient if your systems are already running SSH
servers. After entering an IP address, username, and password (or keyfile), an
agent will be generated and transferred via SSH.

!!! note This deployment method supports all agent types and compatible
platforms.

#### Manual Deploy

An installer executable can be generated and manually installed on systems. This
approach has the disadvantage that installers are not cryptographically signed
and it requires the most manual intervention.

!!! note This deployment method supports all agent types and compatible
platforms.
