## addBarcode

Adds a barcode print command to the command buffer.

### Parameters

#### params

- [AddBarcodeParams](../interfaces/addBarcodeParams.md)

### Returns

`Promise<void>`

### Errors

| **Error status** | **Description** |
| --- | --- |
| ERR_PARAM | An invalid parameter was passed. |
| ERR_TIMEOUT | Failed to communicate with the devices within the specified time. |
| ERR_MEMORY | Necessary memory could not be allocated. |

### Supplementary explanation

- Use this API at the "beginning of a line."
- When the barcode data specified in data does not conform to the barcode type specified in type, an
error will not be returned as an exception and the barcode will not be printed.
- The "CODE 128 auto" type of barcode can be specified when the printer is TM-m30II, TM-m30II-H, TM-
m30II-NT, TMm30II-S, TM-m30II-SL, TM-m30III, TM-m30III-H, TM-m50, TM-m50II, TM-m50II-H, TM-T88VII,
TM-L100, TM-P20II or TM-P80II.

