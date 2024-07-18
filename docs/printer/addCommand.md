## addCommand

Adds a command to the command buffer. Sends the ESC/POS command.

### Parameters

#### data

- `Uint8Array`

Specifies the ESC/POS command. Specifies the binary data.

### Returns

`Promise<void>`

### Errors

| **Error status** | **Description** |
| --- | --- |
| ERR_PARAM | An invalid parameter was passed. |
| ERR_TIMEOUT | Failed to communicate with the devices within the specified time. |
| ERR_MEMORY | Necessary memory could not be allocated. |

### Supplementary explanation


- Refer to the following URL for details of the ESC/POS command. https://www.epson-biz.com/pos/reference/
- Epson ePOS SDK does not check the commands sent using this API.
If the commands interfere with Epson ePOS SDK operations, other APIs may work wrongly or status val- ues may become invalid.
This API should be used with a full understanding of ESC/POS commands and the receipt printer specifi- cations.

