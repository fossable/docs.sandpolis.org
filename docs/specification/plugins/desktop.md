# Desktop Plugin
The desktop plugin provides remote desktop and clipboard integration.

## Messages

| Message              | Sources           | Destinations      | Description                                       |
|----------------------|-------------------|-------------------|---------------------------------------------------|
| RQ_DesktopList       | `client`          | `agent`           |
| RS_DesktopList       | `agent`           | `client`          |
| RQ_DesktopStream     |
| EV_DesktopInput      |
| EV_DesktopOutput     |

### RQ_DesktopList

| Field            | Type       | Requirements              | Description                                              |
|------------------|------------|---------------------------|----------------------------------------------------------|

### RS_DesktopList

| Field            | Type       | Requirements              | Description                                              |
|------------------|------------|---------------------------|----------------------------------------------------------|
| desktop::uuid    | string     |
