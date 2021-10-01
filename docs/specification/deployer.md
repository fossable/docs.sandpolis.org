# Deployer

Deployer instances are responsible for installing, updating, or removing agent
and probe instances.

If an existing agent or probe was originally installed by a package manager, it
cannot be updated or removed by a deployer.

## Instance Configuration

```js
{
  agent_type   : String.description("The type of agent to install"),
  callback     : {
    address    : String.description("The callback address"),
    identifier : String.description("The callback identifier")
  },
  install_dir  : String.description("The installation's base directory"),
  autorecover  : String.description("Whether the agent can disregard elements of the config in case of failure"),
  autostart    : Boolean.description("Whether the agent should be started on boot"),
  kilo         : {
    modules : [
      {
        group       : String.description("The artifact's maven group identifier"),
        artifact    : String.description("The artifact's identifier"),
        filename    : String.description("The artifact's filename"),
        version     : String.description("The artifact's version string"),
        hash        : String.description("The artifact's SHA256 hash")
      }
    ]
  }
}
```

## Callbacks Connections

If the install/update operation fails, and callbacks are configured, the
deployer will establish an encrypted "callback" connection with a server and
transfer details on the error.
