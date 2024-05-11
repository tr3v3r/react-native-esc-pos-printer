## addFeedLine

Adds a paper-feed-by-line command to the command buffer.

### Parameters

#### line *(optional)*

- `number`

Specifies the paper feed amount (in lines).

| **Value** |  **Description** | **Default** |
| --- | --- | --- |
| 0 to 255 | Paper feed amount (in lines) | 1 |

### Returns

`Promise<void>`

### Errors

| **Error status** | **Description** |
| --- | --- |
| ERR_PARAM | An invalid parameter was passed. |
| ERR_TIMEOUT | Failed to communicate with the devices within the specified time. |
| ERR_MEMORY | Necessary memory could not be allocated. |

### Supplementary explanation


- Calling this API causes the printer positioned at "the beginning of the line."

