## addFeedLine

Adds a sheet cut command to the command buffer.
Sets how to cut paper.

### Parameters

#### type *(optional)*

- `AddCutTypeParam`

Specifies how to cut paper.

| **Value** | **Description** |
| --- | --- |
| `PrinterConstants.CUT_FEED` | Feed cut (cut the sheet after feeding paper). |
| `PrinterConstants.CUT_NO_FEED` | Cut without feed (cut the sheet without feeding paper). |
| `PrinterConstants.CUT_RESERVE` | Cut reservation (print the following texts and cut the sheet at the cutting position). |
| `PrinterConstants.FULL_CUT_FEED` | Feed full cut (cut the sheet after feeding paper) |
| `PrinterConstants.FULL_CUT_NO_FEED` | Full cut without feed (cut the sheet without feeding paper) |
| `PrinterConstants.FULL_CUT_RESERVE` | Full cut reservation (print the following texts and full cut the sheet at the cutting position) |
| `PrinterConstants.PARAM_DEFAULT` | Specifies the default (feed cut (cut the sheet after feeding paper)).


### Returns

`Promise<void>`

### Errors

| **Error status** | **Description** |
| --- | --- |
| ERR_PARAM | An invalid parameter was passed. |
| ERR_TIMEOUT | Failed to communicate with the devices within the specified time. |
| ERR_MEMORY | Necessary memory could not be allocated. |

### Supplementary explanation

- Use this API at the "beginning of a line." If this API is used elsewhere, it will be ignored.
- If print data is not specified after the cut reservation (`PrinterConstants.CUT_RESERVE`), the printer will execute the
cut after feeding paper up to the position of the reserved cut.
- Depending on the printer, it may wait approximately 2 seconds for the print data after the cut reservation (`PrinterConstants.CUT_RESERVE`) before starting the paper feed operation.
- When using the cut reservation (`PrinterConstants.CUT_RESERVE`), set the length of one receipt to at least 20 mm.

