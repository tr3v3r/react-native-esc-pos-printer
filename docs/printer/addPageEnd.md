## addPageEnd

Adds a page mode end command to the command buffer.
Ends page mode and prints all the content that was positioned within the page area.

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

- This API ends page mode and executes the printing of all positioned content.
- Must be called after `addPageBegin()` to complete the page mode session.
- All text, graphics, and other content added between `addPageBegin()` and `addPageEnd()` will be printed.
- After this command, the printer returns to standard line mode.
- The page content is rendered and printed according to the positions and directions specified.
- This command triggers the actual physical printing of the page layout.