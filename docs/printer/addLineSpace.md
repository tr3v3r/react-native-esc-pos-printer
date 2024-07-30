## addLineSpace

Adds line spacing setting to the command buffer.

### Parameters

#### linespc

- `number`

Specifies the line spacing (in dots).

| **Value** |  **Description** |
| --- | --- |
| 0 to 255 | Line spacing (in dots) |

### Returns

`Promise<void>`

### Errors

| **Error status** | **Description** |
| --- | --- |
| ERR_PARAM | An invalid parameter was passed. |
| ERR_TIMEOUT | Failed to communicate with the devices within the specified time. |
| ERR_MEMORY | Necessary memory could not be allocated. |

### Supplementary explanation

- If the line spacing for a single line is set smaller than the print character size, paper may be fed for a larger quantity than the set amount to ensure proper printing.

