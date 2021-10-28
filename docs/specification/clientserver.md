# Client/Server Messages

| Message         | Sources  | Destinations | Description                                          |
| --------------- | -------- | ------------ | ---------------------------------------------------- |
| RQ_ServerBanner | `client` | `server`     | Request the server's banner                          |
| RS_ServerBanner | `server` | `client`     | Response containing the server's banner              |
| RQ_Logout       | `client` | `server`     | Request that the current login session be terminated |
| RS_Logout       | `server` | `client`     |
| RQ_Login        | `client` | `server`     | Request a new login session                          |

## Message Formats

### RS_ServerBanner

| Field       | Type   | Requirements         | Description                                             |
| ----------- | ------ | -------------------- | ------------------------------------------------------- |
| maintenance | bool   |                      | Indicates that only superusers will be allowed to login |
| version     | string | 5 - 32 characters    | The server's version string                             |
| message     | string | 0 - 128 characters   | The banner text message                                 |
| image       | bytes  | 0 - 1 MiB PNG format | The banner image                                        |

### RS_Logout

| Field     | Description                                 |
| --------- | ------------------------------------------- |
| LOGOUT_OK | Indicates the logout attempt was successful |

### RQ_Login

| Field    | Type   | Requirements      | Description                             |
| -------- | ------ | ----------------- | --------------------------------------- |
| username | string | 5 - 32 characters | The username                            |
| password | string | 5 - 32 characters | An unsalted SHA512 hash of the password |
| token    | int32  |                   | A TOTP token                            |

### RS_Login

| Field                  | Description                           |
| ---------------------- | ------------------------------------- |
| LOGIN_OK               | Indicates the login attempt succeeded |
| LOGIN_INVALID_USERNAME | Indicates the supplied username       |

### RQ_CreateUser

| Field      | Type   | Requirements | Description |
| ---------- | ------ | ------------ | ----------- |
| username   | string |
| password   | string |
| email      | string |
| phone      | string |
| expiration | int64  |

### RS_CreateUser

| Field                        | Description |
| ---------------------------- | ----------- |
| CREATE_USER_OK               |
| CREATE_USER_ACCESS_DENIED    |
| CREATE_USER_INVALID_USERNAME |
| CREATE_USER_INVALID_PASSWORD |
| CREATE_USER_INVALID_EMAIL    |
| CREATE_USER_INVALID_PHONE    |

### RQ_DeleteUser

| Field    | Type   | Requirements | Description |
| -------- | ------ | ------------ | ----------- |
| username | string |

### RS_DeleteUser

| Field                     | Description |
| ------------------------- | ----------- |
| DELETE_USER_OK            |
| DELETE_USER_ACCESS_DENIED |

### RQ_DeleteGroup

| Field | Type   | Requirements | Description |
| ----- | ------ | ------------ | ----------- |
| name  | string |

### RS_DeleteGroup

| Field                      | Description |
| -------------------------- | ----------- |
| DELETE_GROUP_OK            |
| DELETE_GROUP_ACCESS_DENIED |

### RQ_DeleteListener

| Field | Type   | Requirements | Description |
| ----- | ------ | ------------ | ----------- |
| name  | string |

### RS_DeleteListener

| Field                         | Description |
| ----------------------------- | ----------- |
| DELETE_LISTENER_OK            |
| DELETE_LISTENER_ACCESS_DENIED |
