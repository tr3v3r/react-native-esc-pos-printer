## addPagePosition

Adds a page position setting command to the command buffer.
Sets the current print position within the page area in page mode.

### Parameters

#### horizontal

- `number`

Specifies the horizontal (x-axis) position within the printable area.

#### vertical

- `number`

Specifies the vertical (y-axis) position within the printable area.

### Returns

`Promise<void>`

### Errors

| **Error status** | **Description** |
| --- | --- |
| ERR_PARAM | An invalid parameter was passed. |
| ERR_TIMEOUT | Failed to communicate with the devices within the specified time. |
| ERR_MEMORY | Necessary memory could not be allocated. |

### Supplementary explanation

- This API sets the print position cursor in page mode.
- Coordinates are relative to the printable area defined by `addPageArea()`.
- All coordinates are specified in dots.
- The position affects where subsequent text and graphics will be placed.
- Position coordinates must be within the bounds of the defined page area.
- This command can be used multiple times to position content at different locations on the same page.