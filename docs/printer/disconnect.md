## disconnect

Ends communication with the printer.

### Returns

`Promise<void>`

### Errors

| **Error status** | **Description** |
| --- | --- |
| ERR_MEMORY | Necessary memory could not be allocated. |
| ERR_FAILURE | An unknown error occurred. |
| ERR_PROCESSING | Could not run the process. |
| ERR_DISCONNECT | Failed to disconnect the device. Tried to terminate communication with a printer during reconnection process. |

