## addPulse

Adds a drawer kick command to the command buffer. Sets the drawer kick.

### Parameters

#### params

- [AddPulseParams](../interfaces/addPulseParams.md)

### Returns

`Promise<void>`

### Errors

| **Error status** | **Description** |
| --- | --- |
| ERR_PARAM | An invalid parameter was passed. |
| ERR_TIMEOUT | Failed to communicate with the devices within the specified time. |
| ERR_MEMORY | Necessary memory could not be allocated. |

### Supplementary explanation

- The drawer and optional external buzzer cannot be connected simultaneously.
- Do not open the drawer repeatedly for a short time. The drawer may be damaged due to too much load.
- For built-in buzzer equipped models of the following printers, sounding the buzzer is possible using the pulse output commands for drawer kick connectors.
For details on controlling the built-in buzzer, refer to the Technical Reference Guide of the printer. TM-T70 / TM-T70II / TM-T82II / TM-T82III / TM-T88IV / TM-T88V / TM-T88VI / TM-T88VII / TM-T82II-i / TM- T83II-i / TM-T88VI-iHUB / TM-L90 / TM-L100

