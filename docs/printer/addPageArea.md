## addPageArea

Adds a page area setting command to the command buffer.
Sets the printable area coordinates and dimensions for page mode printing.

### Parameters

#### horizontal

- `number`

Specifies the horizontal (x-axis) coordinate of the printable area.

#### vertical

- `number`

Specifies the vertical (y-axis) coordinate of the printable area.

#### width

- `number`

Specifies the width of the printable area.

#### height

- `number`

Specifies the height of the printable area.

### Returns

`Promise<void>`

### Errors

| **Error status** | **Description** |
| --- | --- |
| ERR_PARAM | An invalid parameter was passed. |
| ERR_TIMEOUT | Failed to communicate with the devices within the specified time. |
| ERR_MEMORY | Necessary memory could not be allocated. |

### Supplementary explanation

- This API sets the printable area in page mode.
- The printable area is defined by the coordinates (horizontal, vertical) as the top-left corner and the width and height dimensions.
- All coordinates and dimensions are specified in dots.
- This command must be used before entering page mode with `addPageBegin()`.
- The printable area cannot exceed the physical paper dimensions.