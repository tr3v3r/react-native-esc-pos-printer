## static Printer.addTextLine

Prints text line with left and right parts

### Parameters

#### printerInstance

- `Printer`

Printer instance defined by calling `new Printer(...)`.

#### params

- [AddTextLineParams](../interfaces/addTextLineParams.md)

### Returns

`Promise<void>`

### Errors

| **Error status** | **Description** |
| --- | --- |
| ERR_PARAM | An invalid parameter was passed. |
| ERR_TIMEOUT | Failed to communicate with the devices within the specified time. |
| ERR_MEMORY | Necessary memory could not be allocated. |
| CODE_ERR_AUTORECOVER | Automatic recovery error occurred. |
| CODE_ERR_COVER_OPEN | Cover open error occurred. |
| CODE_ERR_CUTTER | Auto cutter error occurred. |
| CODE_ERR_MECHANICAL | Mechanical error occurred. |
| CODE_ERR_EMPTY | No paper is left in the roll paper end detector. |
| CODE_ERR_PARAM | An invalid parameter was passed. |
| CODE_ERR_MEMORY | Memory necessary for processing could not be allocated. |
| CODE_ERR_TIMEOUT | Print timeout occurred. |
| CODE_ERR_PROCESSING | Could not run the process. |
| CODE_ERR_ILLEGAL | This API was called while no communication had been started. |
| CODE_ERR_FAILURE | Error exists in the requested document syntax. |

### Supplementary explanation

- Based on paper width and characters per line (defined in printer specification), prints full width text line with left and right parts.
- Characters per line for each printer collected manually by maintainers of this library [here](../../src/printer/utils/layout/getFontACharsPerLine.ts). If you printer not listed there, or value is not correct please create an issue or PR.
- Internaly uses [addText](./addText.md) and [getPrinterSetting](./getPrinterSetting.md) commands.

