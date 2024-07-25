## addImage

Adds a raster image print command to the command buffer.

A specified area of Image graphics is binarized according to the mode, halftone, and
brightness parameters and converted into a raster image.
The converted image is compressed or not compressed before transmission according to the compress
parameter value.
One pixel of an image corresponds to one dot of the pr

### Parameters

#### params

- [AddImageParams](../interfaces/addImageParams.md)

### Returns

`Promise<void>`

### Errors

| **Error status** | **Description** |
| --- | --- |
| ERR_PARAM | An invalid parameter was passed. |
| ERR_TIMEOUT | Failed to communicate with the devices within the specified time. |
| ERR_MEMORY | Necessary memory could not be allocated. |

### Supplementary explanation

- The "compress" parameter is effective when the printer is connected via Bluetooth. For other printers,
specify `PrinterConstants.COMPRESS_AUTO.`
- Printing may get slower if a transparent image is printed.
- Set an image size appropriate for the printer. If you set to print a large image, the API commands will be
succeeded, but the printer may print nothing.
- Even if the size of an image is printable, the ERR_MEMORY error may occur depending on the Android
device specification. In such case, reduce the image size.

