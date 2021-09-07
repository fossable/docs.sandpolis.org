# Distagent
Distagent instances are responsible for installing and updating agent instances.

## Automatic Updates
If an agent is not updated by its package manager or no package manager exists,
the server can generate a distagent on-the-fly and have it executed by the agent.

## Configuration

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

## Result Callbacks
If configured, the distagent will establish a "callback" connection to a server.
