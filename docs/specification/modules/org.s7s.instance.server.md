# Server Instance

Every Sandpolis network must include one server instance at minimum. Servers are
responsible for coordinating interactions among instances and persisting data.

## Server API

| URL                                                | Method | Description                             | Request Body | Response Body |
| -------------------------------------------------- | ------ | ----------------------------------------| ------------ | ------------- |
| `/v1/agent/{iid}/power`                            | POST   | Update power state on an agent          | | |
| `/v1/server/{iid}/banner`                          | GET    | Return the server's banner information  | | |
| `/v1/server/{iid}/instances/stream`                | POST   | Open a new unidirectional change stream | | |
| `/v1/server/{iid}/instances`                       | DELETE | Delete a document by OID                | | |
| `/v1/server/{iid}/instances`                       | GET    | Return a document by OID                | | |
| `/v1/server/{iid}/instances`                       | PUT    | Update a document by OID                | | |
| `/v1/server/{iid}/listeners/stream`                | POST   | Open a new listener change stream       | | |
| `/v1/server/{iid}/listeners/{listeners_id}/stream` | POST   | Open a new listener change stream       | | |
| `/v1/server/{iid}/listeners/{listeners_id}`        | DELETE | Remove an existing listener             | | |
| `/v1/server/{iid}/listeners/{listeners_id}`        | GET    | Return details on the listener          | | |
| `/v1/server/{iid}/listeners/{listeners_id}`        | PUT    | Update an existing listener             | | |
| `/v1/server/{iid}/listeners`                       | GET    | List existing listeners                 | | |
| `/v1/server/{iid}/listeners`                       | POST   | Create a new listener                   | | |
| `/v1/server/{iid}/network/stream`                  | POST   | Open a new network change stream        | | |
| `/v1/server/{iid}/network`                         | GET    | List the network table                  | | |
| `/v1/server/{iid}/session`                         | DELETE | Destroy an existing session             | | |
| `/v1/server/{iid}/session`                         | POST   | Establish a new session                 | | |
| `/v1/server/{iid}/tunnels/stream`                  | POST   | Open a new tunnel change stream         | | |
| `/v1/server/{iid}/tunnels/{tunnel_id}/stream`      | POST   | Open a new tunnel change stream         | | |
| `/v1/server/{iid}/tunnels/{tunnel_id}`             | DELETE | Destroy an existing tunnel              | | |
| `/v1/server/{iid}/tunnels/{tunnel_id}`             | GET    | Return details on an existing tunnel    | | |
| `/v1/server/{iid}/tunnels/{tunnel_id}`             | PUT    | Update an existing tunnel               | | |
| `/v1/server/{iid}/tunnels`                         | GET    | List tunnel information                 | | |
| `/v1/server/{iid}/users/stream`                    | POST   | Open a new user change stream           | | |
| `/v1/server/{iid}/users/{user_id}/stream`          | POST   | Open a new user change stream           | | |
| `/v1/server/{iid}/users/{user_id}`                 | DELETE | Remove an existing user account         | | |
| `/v1/server/{iid}/users/{user_id}`                 | GET    | Return details on the user account      | | |
| `/v1/server/{iid}/users/{user_id}`                 | PUT    | Update an existing user account         | | |
| `/v1/server/{iid}/users`                           | GET    | List existing user accounts             | | |
| `/v1/server/{iid}/users`                           | POST   | Create a new user account               | | |

## Instance Configuration

```py
# com.sandpolis.server
{
  "cluster": [
    String(format="ipv4"),
  ],
  "storage" : {
    "provider" : String(default="ephemeral"), # The database storage provider
    "mongodb" : {
      "host"     : String(), # The address of the mongodb host
      "username" : String(), # The mongodb user's username
      "password" : String(), # The mongodb user's password
    }
  },
  "geolocation" : {
    "service"    : String(values=["ip-api.com", "keycdn.com"], default="ip-api.com"), # The name of the geolocation service to use
    "key"        : String(), # The service API key
    "expiration" : Number(), # The cache timeout in hours
  }
}
```

## Server Strata

There can be multiple servers in a Sandpolis network which improves both scalability
and failure tolerance. There are two roles in which a server can exist: a global level
and a local level.

### Global Stratum (GS)

By default, servers exist in the global stratum. Every network must have at least one
GS server and every GS server maintains a persistent connection to every other GS
server (fully-connected graph).

Every GS server maintains a database containing the entire contents of the network.

### Local Stratum (LS)

Local stratum servers are used to serve localized regions and can operate independently
if all GS servers becomes unreachable.

Every LS server maintains a database containing just the contents relevant to it which
is continuously replicated to a GS server's database.

## Persistent Storage

CouchDB is used for persistent storage on servers because of its document-based
"NoSQL" architecture and robust synchronization capabilities.

Servers start a local-only listener for every GS server which proxies requests from
the database to the appropriate server instance. This way, all database traffic
is routed over the primary connection instead of requiring a secondary connection to
be allowed.

### Default admin password

The admin password will be randomized and printed in the server log. All clients
are required to force users to change the admin password and setup multi-factor
authentication before proceeding after the first login.

## Connection Blocking

The server will refuse connections from IP addresses on a configurable block-list
or those that trigger the global rate-limiting policy.

IP addresses on a configurable allow-list are exempt from rate-limiting.

## Permissions

All user accounts are subject to a set of permissions controlling what server
operations are authorized. The inital admin user has complete and irrevocable
permissions. By default, additional user accounts are created without
permissions and consequently are allowed to do almost nothing.

### Permissions list

| Permission               | Description                                                |
| ------------------------ | ---------------------------------------------------------- |
| `server.generate`        | Rights to use the generator                                |
| `server.users.list`      | Right to view usernames and permissions of all other users |
| `server.users.create`    | Right to create new users (of lesser or equal permissions) |
| `server.net.view`        | Right to open the network control panel                    |
| `server.listener.create` | Right to create a new listener on the server               |
| `server.listener.list`   | Right to view all listeners on the server                  |
| `server.group.create`    | Right to create a new authentication group on the server   |
| `server.group.list`      | Right to view all authentication groups on the server      |
| `agent.system.power`     | Right to shutdown, reboot, etc the agent                   |

## Agent Groups

Agent groups are sets of agents that share one or more authentication schemes.
Every group has exactly one owner and zero or more (user) members.

### Password Authentication Scheme

The agent may provide a simple password embedded in the agent's configuration.
The server compares the password to each agent group until it finds a match. If
a match is found, the agent is becomes authenticated to the matching agent
group. Otherwise, the connection is closed if more than 5 attempts were made on
that connection.

Password authentication may be upgraded to the certificate authentication scheme
for all subsequent connections.

### Token Authentication Scheme

The agent may provide an 8 character alphanumeric time-based token periodically
generated by the server from an agent group's secret key. Since a user must type
the token in manually, the server will attempt to configure the certificate
authentication scheme for all subsequent connections.

### Certificate Authentication Scheme

The agent may provide an X509 "client" certificate signed by an agent group's
secret key during the initial connection attempt. If the agent certificate was
found to be valid, the connection is automatically authenticated without any
additional message exchanges.

#### Agent Certificate Expiration

The default lifetime for an agent certificate is six months. The following
section implies an agent must connect to a server at least once every 1.5 months
otherwise it loses its ability to authenticate.

#### Agent Certificate Renewal

Once 75% of the lifetime of an agent certificate elapses, the server attempts to
issue a new certificate and installs it on the agent.

## Agent Generators

A `Generator` is a routine which produces some installation artifact according
to the parameters set out in an authentication group. The installation artifact
can then be used to install an agent on a remote system.

### Deployers

On execution, deployers set up the agent base directory according to its
configuration and executes the agent. If the target directory already contains
an installation, the old installation is entirely overwritten.

### Packager

A packager is responsible for creating a deployer binary according to the
parameters set out in an authentication group.

### Distributor

A distributor is responsible for transferring and executing generated deployer
artifacts to remote systems.

#### SSH Distributor

The SSH deployer first determines the remote system type and invokes an
appropriate packager to generate an installer. The installer is then transferred
to the remote host and executed.
