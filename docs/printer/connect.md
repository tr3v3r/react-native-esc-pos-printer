## connect

Starts communication with the printer.

### Parameters

#### timeout *(optional)*

- `number`

Specifies the maximum time (in milliseconds) to wait for communication with the printer to be established.

| **Value** |  **Description** | **Default** |
| --- | --- | --- |
| 1000 to 300000 | Maximum wait time before an error is returned (in milliseconds). | 15000 |

### Returns

`Promise<void>`

### Errors

| **Error status** | **Description** |
| --- | --- |
| ERR_PARAM | An invalid parameter was passed. |
| ERR_CONNECT | Failed to open the device. |
| ERR_TIMEOUT | Failed to communicate with the devices within the specified time. |
| ERR_ILLEGAL | Tried to start communication with a printer with which communication had been already established. Tried to start communication with a printer during reconnection process. |
| ERR_MEMORY | Necessary memory could not be allocated. |
| ERR_FAILURE | An unknown error occurred. |
| ERR_PROCESSING | Could not run the process. |
| ERR_NOT_FOUND | The printer could not be found. |
| ERR_IN_USE | The device was in use. |
| ERR_TYPE_INVALID | The device type is different. |
| ERR_RECOVERY_FAILURE | Failed to recover the printer. |

### Supplementary explanation

Android:

- When communication with the printer is no longer necessary, be sure to call disconnect to terminate it.
- If you are using DHCP to assign the IP address of the printer, specify the MAC address or host name of the
printer as the identifier.
-  When connecting through the USB, the identifiers that can be specified differ depending on the shape of
the USB connector.
When the identifier is omitted, Android OS connects with the USB device found first.
When the Android terminal is set to the developer mode, you may not be able to connect through USB-
A - Device Charging.
- Devices other than printers are exclusively locked.
- If error with status ERR_RECOVERY_FAILURE occurs, restart the printer.

iOS:

- When communication with the printer is no longer necessary, be sure to call disconnect to terminate it.
- For TM-DT series, MAC address cannot be specified.
- When connecting with the printer using Bluetooth, complete pairing before calling the connect command.
- Depending on the project settings, Bluetooth communication may be disconnected if the application runs in the background.
- If Bluetooth and USB are used simultaneously, priority is given to the USB.
- Devices other than printers are exclusively locked.
- If error with status ERR_RECOVERY_FAILURE occurs, restart the printer.
- Since it takes time to send and receive a large amount of data with BLE connection, the following APIs not recommended be used. (addImage)
