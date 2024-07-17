## addSumbol

Adds a 2D symbol print command to the command buffer.

### Parameters

#### params

- [AddSymbolParams](../interfaces/addSymbolParams.md)

### Returns

`Promise<void>`

### Errors

| **Error status** | **Description** |
| --- | --- |
| ERR_PARAM | An invalid parameter was passed. |
| ERR_TIMEOUT | Failed to communicate with the devices within the specified time. |
| ERR_MEMORY | Necessary memory could not be allocated. |

### Supplementary explanation

- When the 2D symbol data specified in data does not conform to the 2D symbol type specified in type, an
error will not be returned in the return value and the 2D symbol will not be printed.
- During ESC/POS control, specifying values outside the valid ranges for the width and height parameters results in default value printing.
