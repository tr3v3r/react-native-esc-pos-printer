## addText

Adds a character print command to the command buffer.

### Parameters

#### text

- `string`

Specifies the string to print.
Use the following escape sequences for a horizontal tab and line feed.

| **String** |  **Description** |
| --- | --- |
|`\t` | Horizontal tab (HT)|
| `\n` | Line feed (LF)
| `\\` | Backslash |

### Returns

`Promise<void>`

### Errors

| **Error status** | **Description** |
| --- | --- |
| ERR_PARAM | An invalid parameter was passed. |
| ERR_TIMEOUT | Failed to communicate with the devices within the specified time. |
| ERR_MEMORY | Necessary memory could not be allocated. |

### Supplementary explanation


- To print data other than text after printing text, feed a line or page.
A line which does not end with a line feed will be discarded as unfixed data by the next [sendData](./sendData.md).

