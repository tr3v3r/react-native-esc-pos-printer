## static Printer.addViewShot

Prints image captured from React Native View

### Parameters

#### printerInstance

- `Printer`

Printer instance defined by calling `new Printer(...)`.

#### params

- [AddViewShotParams](../interfaces/addViewShotParams.md)

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

- Uses [react-native-view-shot](https://github.com/gre/react-native-view-shot)
- Internaly uses [addImage](./addText.md) and [getPrinterSetting](./getPrinterSetting.md) commands.

