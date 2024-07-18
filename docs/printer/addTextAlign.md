## addTextAlign

Adds a text alignment command to the command buffer.

### Parameters

#### align

- `number`

Specifies alignment.

| **Value** |  **Description** |
| --- | --- |
| `PrinterConstants.ALIGN_LEFT` (default) | Left alignment |
| `PrinterConstants.ALIGN_CENTER` | Center alignment |
| `PrinterConstants.ALIGN_RIGHT` | Right alignment |
| `PrinterConstants.PARAM_DEFAULT` | Specifies the default value (left alignment). |

### Returns

`Promise<void>`

### Errors

| **Error status** | **Description** |
| --- | --- |
| ERR_PARAM | An invalid parameter was passed. |
| ERR_TIMEOUT | Failed to communicate with the devices within the specified time. |
| ERR_MEMORY | Necessary memory could not be allocated. |

### Supplementary explanation

- Setting of this API is also applied to the barcode/2D symbol/raster image/NV logo.

