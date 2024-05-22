## getStatus

Acquires the current status information.


### Returns

Promise<[PrinterStatusResponse](../interfaces/printerStatus.md)>

### Errors

| **Error status** | **Description** |
| --- | --- |
| ERR_MEMORY | Necessary memory could not be allocated. |

### Supplementary explanation

- If this API is called while communication is not available, printer states other than "connection" will be
set to `PrinterConstants.UNKNOWN`
- The status object is set to the status at the timing of execution of this API and will not be updated.
- To get the "adapter" or "batteryLevel" status, you need to enable transmission of power on/off and bat- tery status using Epson TM Utility.
- To get the "paperTakenSensor" status, you need to enable the "Paper Taken Sensor Status" setting using Epson TM Utility.
