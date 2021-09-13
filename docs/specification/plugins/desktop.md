# Desktop Plugin

The desktop plugin provides remote desktop and clipboard integration.

## Messages

| Message          | Sources  | Destinations |
| ---------------- | -------- | ------------ |
| RQ_DesktopList   | `client` | `agent`      |
| RS_DesktopList   | `agent`  | `client`     |
| RQ_DesktopStream | `client` | `agent`      |
| EV_DesktopInput  | `client` | `agent`      |
| EV_DesktopOutput | `agent`  | `client`     |
| RQ_Screenshot    |
| RS_Screenshot    |

### RQ_DesktopList

Request for a listing of available desktops.

| Field | Type | Requirements | Description |
| ----- | ---- | ------------ | ----------- |


### RS_DesktopList

Response containing all available desktops.

| Field           | Type   | Requirements | Description                  |
| --------------- | ------ | ------------ | ---------------------------- |
| desktop::name   | string |              | The desktop name             |
| desktop::width  | int32  |              | The desktop width in pixels  |
| desktop::height | int32  |              | The desktop height in pixels |

### RQ_DesktopStream

Request a new desktop stream be established.

| Field            | Type   | Requirements                    | Description |
| ---------------- | ------ | ------------------------------- | ----------- |
| stream_id        | int32  |
| desktop_uuid     | string |
| capture_mode     | string | `poll` or `hook`                |
| color_mode       | string | `rgb888`, `rgb565`, or `rgb332` |
| compression_mode | string | `zlib`                          |
| scale_factor     | double |

### EV_DesktopInput

`EV_DesktopInput` contains key, mouse, and clipboard data.

| Field            | Type   | Requirements | Description |
| ---------------- | ------ | ------------ | ----------- |
| key_pressed      | string |
| key_released     | string |
| key_typed        | string |
| pointer_pressed  | int32  |
| pointer_released | int32  |
| pointer_x        | int32  |
| pointer_y        | int32  |
| scale_factor     | double |
| clipboard        | string |

### EV_DesktopOutput

`EV_DesktopOutput` contains pixel data and clipboard data.

| Field      | Type   | Requirements | Description                                                  |
| ---------- | ------ | ------------ | ------------------------------------------------------------ |
| width      | int32  |              | The width of the destination block in pixels                 |
| height     | int32  |              | The height of the destination block in pixels                |
| dest_x     | int32  |              | The X coordinate of the destination block's top left corner  |
| dest_y     | int32  |              | The Y coordinate of the destination block's top left corner  |
| source_x   | int32  |              | The X coordinate of the source block's top left corner       |
| source_y   | int32  |              | The Y coordinate of the source block's top left corner       |
| pixel_data | bytes  |              | The pixel data encoded according to the session's parameters |
| clipboard  | string |              | Clipboard data                                               |
