# Distagent

Distagent instances are responsible for installing and updating agent instances.

If an agent was originally installed by a package manager, it cannot be updated
by a distagent.

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
        gpr_module  : String.description("The GPR module"),
        gpr_package : String.description("The GPR package"),
        maven_group : String.description("The artifact's maven group identifier"),
        artifact    : String.description("The artifact's identifier"),
        filename    : String.description("The artifact's filename"),
        version     : String.description("The artifact's version string"),
        hash        : String.description("The artifact's SHA256 hash")
      }
    ]
  }
}
```

## Failure Callbacks

If configured, the distagent will establish an unencrypted "callback" connection
to a server and transfer a payload in the event that the installation fails. The
callback payload is obfuscated and contains details on the error.

### Callback Payload

```js
{
  timestamp : String.description("The installation timestamp"),
  error     : String.description("The error details")
}
```
