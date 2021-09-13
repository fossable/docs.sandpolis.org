# Client/Server Messages

| Message         | Sources  | Destinations | Description                                          |
| --------------- | -------- | ------------ | ---------------------------------------------------- |
| RQ_ServerBanner | `client` | `server`     | Request the server's banner                          |
| RS_ServerBanner | `server` | `client`     | Response containing the server's banner              |
| RQ_Logout       | `client` | `server`     | Request that the current login session be terminated |
| RQ_Login        | `client` | `server`     | Request a new login session                          |

## Message Formats

### RQ_ServerBanner

| Field | Type | Requirements | Description |
| ----- | ---- | ------------ | ----------- |


### RS_ServerBanner

| Field       | Type   | Requirements         | Description                                             |
| ----------- | ------ | -------------------- | ------------------------------------------------------- |
| maintenance | bool   |                      | Indicates that only superusers will be allowed to login |
| version     | string | 5 - 32 characters    | The server's version string                             |
| message     | string | 0 - 128 characters   | The banner text message                                 |
| image       | bytes  | 0 - 1 MiB PNG format | The banner image                                        |

### RQ_Logout

| Field | Type | Requirements | Description |
| ----- | ---- | ------------ | ----------- |


### RQ_Login

| Field    | Type   | Requirements      | Description                             |
| -------- | ------ | ----------------- | --------------------------------------- |
| username | string | 5 - 32 characters | The username                            |
| password | string | 5 - 32 characters | An unsalted SHA512 hash of the password |
| token    | int32  |                   | A TOTP token                            |
