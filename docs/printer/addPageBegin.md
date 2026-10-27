## addPageBegin

Adds a page mode begin command to the command buffer.
Starts page mode for advanced layout control and precise positioning.

### Parameters

None

### Returns

`Promise<void>`

### Errors

| **Error status** | **Description** |
| --- | --- |
| ERR_PARAM | An invalid parameter was passed. |
| ERR_TIMEOUT | Failed to communicate with the devices within the specified time. |
| ERR_MEMORY | Necessary memory could not be allocated. |

### Supplementary explanation

- This API starts page mode printing.
- Page mode allows for precise positioning of text and graphics on the page.
- Must be called after setting up the page area with `addPageArea()`.
- All content added after this command will be positioned within the defined page area.
- Page mode content is not printed immediately but is rendered when `addPageEnd()` is called.
- Multiple text blocks and graphics can be positioned anywhere within the page area.
- Standard line mode commands may not work as expected in page mode.