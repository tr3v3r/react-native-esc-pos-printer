# Interface: AddImageParams

### source

*source*: `ImageSource`
The image source (either a remote URL or a local file resource).

| *Value* | *Description* |
| --- | --- |
| `{ uri: base64String }` | Base64 string image |
| `{ uri: 'https://...' }` | Remote image |
| `{ uri: 'http://...' }` | Remote image |
| `{ uri: 'file://...' }` | Local image |
| `require('./path_to_local_image/image.png')` | Local image |


### width

*width*: `number`

Specifies the width of the print area (in pixels).

| *Value* | *Description* |
| --- | --- |
| Integer from 1 to 65535 | Width of the print area (in pixels) |

### color *(optional)*

*color?*: `number`

Specifies the color.

| *Value* | *Description* |
| --- | --- |
| `PrinterConstants.COLOR_NONE` | No printing |
| `PrinterConstants.COLOR_1` | First color |
| `PrinterConstants.COLOR_2` | Second color |
| `PrinterConstants.COLOR_3` | Third color |
| `PrinterConstants.COLOR_4` | Fourth color |
| `PrinterConstants.PARAM_DEFAULT` | Specifies the default value (first color). |

### mode *(optional)*

*mode?*: `number`

Specifies the color mode.

| *Value* | *Description* |
| --- | --- |
| `PrinterConstants.MODE_MONO` | Monochrome |
| `PrinterConstants.MODE_GRAY16` | 16-level grayscale |
| `PrinterConstants.MODE_MONO_HIGH_DENSITY` | High-density monochrome |
| `PrinterConstants.PARAM_DEFAULT` | Specifies the default value (monochrome). |

### brightness *(optional)*

*brightness?*: `number`

Specifies the brightness compensation value.

| *Value* | *Description* |
| --- | --- |
| Float from 0.1 to 10 | Brightness compensation value |
| `PrinterConstants.PARAM_DEFAULT` | Specifies the default value (1.0). |

### compress *(optional)*

*compress?*: `number`

Enables or disables compression.
Compressing print images can prevent white banding or streaks from occurring on printed images.
This works well when connecting with the printer using Bluetooth.

| *Value* | *Description* |
| --- | --- |
| `PrinterConstants.COMPRESS_DEFLATE` | Compresses the image. |
| `PrinterConstants.COMPRESS_NONE` | Does not compress the image. |
| `PrinterConstants.COMPRESS_AUTO` | Automatically compresses the image. |
| `PrinterConstants.PARAM_DEFAULT` | Specifies the default value (compression is automatically determined). |

### halftone *(optional)*

*halftone?*: `number`

Specifies the halftone processing method.

| *Value* | *Description* |
| --- | --- |
| `PrinterConstants.HALFTONE_DITHER` | Dithering (appropriate for printing graphics only) |
| `PrinterConstants.HALFTONE_ERROR_DIFFUSION` | Error diffusion (appropriate for printing text and graphics) |
| `PrinterConstants.HALFTONE_THRESHOLD` | Threshold (appropriate for printing text only) |
| `PrinterConstants.PARAM_DEFAULT` | Specifies the default value (dithering). |

Effective for the monochrome (2 scales) color mode only.




