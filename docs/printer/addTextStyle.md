## addTextStyle

Adds character style setting to the command buffer.

### Parameters

#### params

- [AddTextStyleParams](../interfaces/addTextStyleParams.md)

### Returns

`Promise<void>`

### Errors

| **Error status** | **Description** |
| --- | --- |
| ERR_PARAM | An invalid parameter was passed. |
| ERR_TIMEOUT | Failed to communicate with the devices within the specified time. |
| ERR_MEMORY | Necessary memory could not be allocated. |

### Supplementary explanation

-  If all the parameters are set to "PARAM_UNSPECIFIED," EPOS2_ERR_PARAM will be returned.

