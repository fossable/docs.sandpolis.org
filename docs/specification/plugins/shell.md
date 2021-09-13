# Shell Plugin

The shell plugin integrates with various kinds of system shells.

## Shell Capability

| Label                 | Shell Name |
| --------------------- | ---------- |
| bash (zsh, ash, dash) |
| fish                  |
| powershell            |
| cmd.exe               |
| ksh                   |
| csh (tcsh)            |

## Messages

| Message        | Sources  | Destinations | Description                                         |
| -------------- | -------- | ------------ | --------------------------------------------------- |
| RQ_ShellStream | `client` | `agent`      | Request to start a new shell session                |
| EV_ShellInput  | `client` | `agent`      | Event containing standard-input to a shell          |
| EV_ShellOutput | `agent`  | `client`     | Event containing standard-output and standard-error |
| RQ_FindShells  | `client` | `agent`      | Request to locate supported shells on the system    |
| RS_FindShells  | `agent`  | `client`     | Response containing supported shell information     |
| RQ_Execute     | `client` | `agent`      | Request to execute a command snippet in a shell     |
| RS_Execute     | `agent`  | `client`     | Response containing execution results               |

### RQ_FindShells

| Field | Type | Requirements | Description |
| ----- | ---- | ------------ | ----------- |


### RS_FindShells

| Field             | Type            | Requirements    | Description                          |
| ----------------- | --------------- | --------------- | ------------------------------------ |
| shell::path       | string          | Filesystem path | The location of the shell executable |
| shell::capability | repeated string |                 | A list of shell capabilities         |

### RQ_Execute

| Field         | Type            | Requirements | Description             |
| ------------- | --------------- | ------------ | ----------------------- |
| shell_type    |
| command       | repeated string |              | The commands to execute |
| timeout       | int32           |
| ignore_stdout | bool            |
| ignore_stderr | bool            |

### RS_Execute

| Field | Type | Requirements | Description |
| ----- | ---- | ------------ | ----------- |


### EV_ShellInput

| Field        | Type  | Requirements    | Description                |
| ------------ | ----- | --------------- | -------------------------- |
| stdin        | bytes | 0 - 65535 bytes | The process standard-input |
| rows_changed | int32 |
| cols_changed | int32 |

### EV_ShellOutput

| Field  | Type  | Requirements    | Description                 |
| ------ | ----- | --------------- | --------------------------- |
| stdout | bytes | 0 - 65535 bytes | The process standard-output |
| stderr | bytes | 0 - 65535 bytes | The process standard-error  |

### RQ_ShellStream

| Field       | Type   | Requirements | Description |
| ----------- | ------ | ------------ | ----------- |
| stream_id   | int32  |
| capability  | string |
| environment | map    |
| rows        | int32  |
| cols        | int32  |
