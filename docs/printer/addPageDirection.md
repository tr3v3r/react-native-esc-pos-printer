## addPageDirection

Adds a page direction setting command to the command buffer.
Sets the direction for text and graphics in page mode.

### Parameters

#### direction

- `PageDirectionType`

Specifies the direction for printing in page mode.

| **Value** | **Description** |
| --- | --- |
| `PrinterConstants.DIRECTION_LEFT_TO_RIGHT` | Left to right direction (default horizontal text). |
| `PrinterConstants.DIRECTION_BOTTOM_TO_TOP` | Bottom to top direction (90° counter-clockwise rotation). |
| `PrinterConstants.DIRECTION_RIGHT_TO_LEFT` | Right to left direction (180° rotation). |
| `PrinterConstants.DIRECTION_TOP_TO_BOTTOM` | Top to bottom direction (90° clockwise rotation). |

### Returns

`Promise<void>`

### Errors

| **Error status** | **Description** |
| --- | --- |
| ERR_PARAM | An invalid parameter was passed. |
| ERR_TIMEOUT | Failed to communicate with the devices within the specified time. |
| ERR_MEMORY | Necessary memory could not be allocated. |

### Supplementary explanation

- This API sets the print direction in page mode.
- The direction affects how text and graphics are rendered within the page area.
- Direction changes apply to all subsequent content added to the page.
- This command must be used before adding content in page mode.
- Different directions allow for creating rotated text and layouts.