## addTextSize

Adds character scaling factor setting to the command buffer.

### Parameters

#### params

- [AddTextSizeParams](../interfaces/addTextSizeParams.md)

### Returns

`Promise<void>`

### Errors

| **Error status** | **Description** |
| --- | --- |
| ERR_PARAM | An invalid parameter was passed. |
| ERR_TIMEOUT | Failed to communicate with the devices within the specified time. |
| ERR_MEMORY | Necessary memory could not be allocated. |

### Supplementary explanation

- If all the parameters are set to "PARAM_UNSPECIFIED," ERR_PARAM will be returned
- For slip, endorsement, or validation printing, an integer from 1 to 2 can be set for the width and height.
