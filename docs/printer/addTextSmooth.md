## addTextSmooth

Adds smoothing setting to the command buffer.

### Parameters

#### smooth

- `number`

Enables or disables smoothing.

| **Value** |  **Description** |
| --- | --- |
| `PrinterConstants.TRUE` |Enables smoothing. |
| `PrinterConstants.FALSE` (default) | Disables smoothing. |
| `PrinterConstants.PARAM_DEFAULT` | Specifies the default value (smoothing disabled). |

### Returns

`Promise<void>`

### Errors

| **Error status** | **Description** |
| --- | --- |
| ERR_PARAM | An invalid parameter was passed. |
| ERR_TIMEOUT | Failed to communicate with the devices within the specified time. |
| ERR_MEMORY | Necessary memory could not be allocated. |
