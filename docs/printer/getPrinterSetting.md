## getPrinterSetting

Acquires the set value of the printer setting.
The value acquired by this API is notified to the listener method specified in the listener parameter.

### Parameters

#### type

- `PrinterGetSettingsType`

Specifies the printer setting item to be acquired.

| **Value** |  **Description** |
| --- | --- |
| `PrinterConstants.PRINTER_SETTING_PAPERWIDTH` | Paper width |
| `PrinterConstants.PRINTER_SETTING_PRINTDENSITY` | Print density |
| `PrinterConstants.PRINTER_SETTING_PRINTSPEED` | Print speed |

#### timeout *(optional)*

- `number`

Specifies the timeout period before completion of printing in milliseconds.

| **Value** |  **Description** | **Default** |
| --- | --- | --- |
| 5000 to 600000 | Timeout period (in milliseconds) | 10000 |

### Returns

Promise<[PrinterSettingsResponse](../interfaces/printerSettings.md)>

### Errors

| **Error status** | **Description** |
| --- | --- |
| ERR_PARAM | An invalid parameter was passed. |
| ERR_FAILURE | An unknown error occurred. |
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

- Do not turn off the power supply to the printer while executing this API.
- This API cannot be used with SSL/TLS communication.
