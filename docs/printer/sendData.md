## sendData

Sends the print command.

### Parameters

#### timeout *(optional)*

- `number`

Specifies the maximum time (in milliseconds) to wait for communication with the printer to be established.

| **Value** |  **Description** | **Default** |
| --- | --- | --- |
| 5000 to 600000* | Timeout period (in milliseconds) | 10000 |

### Returns

Promise<[PrinterStatusResponse](../interfaces/printerStatus.md)>

### Errors

| **Error status** | **Description** |
| --- | --- |
| ERR_PARAM | An invalid parameter was passed. |
| ERR_MEMORY | Necessary memory could not be allocated. |
| ERR_FAILURE | An unknown error occurred. |
| ERR_PROCESSING | Could not run the process. |
| ERR_ILLEGAL | The control commands have not been buffered. This API was called while no communication had been started. |
| CODE_ERR_AUTORECOVER | Automatic recovery error occurred. |
| CODE_ERR_COVER_OPEN | Cover open error occurred. |
| CODE_ERR_CUTTER | Auto cutter error occurred. |
| CODE_ERR_MECHANICAL | Mechanical error occurred. |
| CODE_ERR_EMPTY | No paper is left in the roll paper end detector. |
| CODE_ERR_UNRECOVERABLE | Unrecoverable error occurred. |
| CODE_ERR_FAILURE | Error exists in the requested document syntax. |
| CODE_ERR_NOT_FOUND | Printer specified by the device ID does not exist. |
| CODE_ERR_SYSTEM | Error occurred with the printing system. |
| CODE_ERR_PORT | Error was detected with the communication port. |
| CODE_ERR_TIMEOUT | Print timeout occurred. |
| CODE_ERR_JOB_NOT_FOUND | Specified print job ID does not exist. |
| CODE_ERR_SPOOLER | Print queue is full. |
| CODE_ERR_BATTERY_LOW | Battery has run out. |
| CODE_ERR_TOO_MANY_REQUESTS | The number of print jobs sent to the printer has exceeded the allowable limit. |
| CODE_ERR_REQUEST_ENTITY_TOO_LARGE | The size of the print job data exceeds the capacity of the printer. |
| CODE_ERR_WAIT_REMOVAL | Print command sent while waiting for paper removal. |


### Supplementary explanation

- For Bluetooth connection, the offline status may not be detected and a timeout error may occur.
- To get the "adapter" or "batteryLevel" status, you need to enable transmission of power on/off and bat- tery status using Epson TM Utility.
- To get the "paperTakenSensor" status, you need to enable the "Paper Taken Sensor Status" setting using Epson TM Utility.
