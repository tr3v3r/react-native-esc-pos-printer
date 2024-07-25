# Interface: AddBarcodeParams

### data

*data*: `string`
Specifies barcode data as a text string.
Specify a string in accordance with the standard of the barcode specified in type.

| *Type* | *Description* |
| --- | --- |
| `UPC-A` | If an 11-digit figure is specified, the check digit is automatically appended.If a 12-digit figure is specified, the 12th digit is used as the check digit but verification is not performed. |
| `UPC-E` | Specify 0 in the first digit. Specify the manufacturer code in the 2nd to 6th digits. Specify the item code in right justification in the 7th to 11th digits. The number of digits of the item code depends on the manufacturer code. Specify 0 in each unused data. If an 11-digit figure is specified, the check digit is automatically appended. If a 12-digit figure is specified, the 12th digit is used as the check digit but verification is not performed. |
| `EAN13`, `JAN13` | If an 12-digit figure is specified, the check digit is automatically appended. If a 13-digit figure is specified, the 13th digit is used as the check digit but verification is not performed. |
| `EAN8`, `JAN8` | If an 7-digit figure is specified, the check digit is automatically appended. If an 8-digit figure is specified, the 8th digit is used as the check digit but verification is not performed. |
| `CODE39` | If the first character is * , this character is processed as the start character. If it is not , the start character is automatically added. |
| `ITF` | The start and stop codes are automatically added. Addition and verification of the check digit are not performed. |
| `CODABAR` | Specify the start character ((A to D, a to d). Specify the stop character ((A to D, a to d). Addition and verification of the check digit are not performed. |
| `CODE93` | The start and stop characters are automatically added. The check digit is automatically calculated and added. |
| `CODE128` | Specify the start character (CODE A, CODE B, CODE C). The stop character is automatically added. The check digit is automatically calculated and added. To encode the following characters, specify the corresponding 2-digit code starting with { :  <br>• FNC1: {1 <br>• FNC2: {2 <br>• FNC3: {3 <br>• FNC4: {4 <br>• CODE A: {A <br>• CODE B: {B <br>• CODE C: {C <br>• SHIFT: {S <br>• {: {{ <br> When specifying CODE C, specify the barcode data as the control code of the escape sequence. |
| `CODE128 auto` | The start character, check digit, and stop character are automatically added. The character string added to make the overall width of the CODE128 symbol as mini- mum is automatically converted. In this function, there is no need to specify the code set, and the barcode is printed simply by entering the data to be converted to symbols. Example) When entering numbers: "123", etc. When entering alphabets: "ABCabc", etc. Data from 0 to 255 (control codes and character codes) can be specified. Since the overall width changes automatically, use this function after confirming that the barcode fits into the print area and is printed without any problem. When using FNC1, etc., use CODE128 rather than CODE128 auto. |
| `GS1-128` | The start character, FNC1, check digit, and stop characters are automatically added. However, FNC1 used as a data separator is not added. To automatically calculate and add the application ID (AI) and the following check digit, specify "*" at the check digit position. The application ID (AI) can be put in parentheses. The parentheses are used as print characters for HRI and not encoded as data. A blank space can be inserted between the application ID (AI) and data. The blank space is used as print characters for HRI and not encoded as data. To encode the following characters, specify the corresponding 2-digit code starting with { : <br>• FNC1: {1 <br>• FNC3: {3 <br>• (: {( <br>• ): {} <br>• FNC1: {1 <br>• {: {{ |
| `GS1 DataBar Omnidirectional`, `GS1 DataBar Truncated`, `GS1 DataBar Limited` | Specify a 13-digit product ID (GTIN) excluding the application ID (AI) and check digit. |
| `GS1 DataBar Expanded` | The application ID (AI) can be put in parentheses. The parentheses are used as print characters for HRI and not encoded as data. To encode the following characters, specify the corresponding 2-digit code starting with { : <br>• FNC1: {1 <br>• (: {( <br>• ): {} |


### type

*type*: `number`

Specifies the barcode type.

| *Value* | *Description* |
| --- | --- |
| `PrinterConstants.BARCODE_UPC_A` | `UPC-A` |
| `PrinterConstants.BARCODE_UPC_E` | `UPC-E` |
| `PrinterConstants.BARCODE_EAN13` | `EAN13` |
| `PrinterConstants.BARCODE_JAN13` | `JAN13` |
| `PrinterConstants.BARCODE_EAN8` | `EAN8` |
| `PrinterConstants.BARCODE_JAN8` | `JAN8` |
| `PrinterConstants.BARCODE_CODE39` | `CODE39` |
| `PrinterConstants.BARCODE_ITF` | `ITF` |
| `PrinterConstants.BARCODE_CODABAR` | `CODABAR` |
| `PrinterConstants.BARCODE_CODE93` | `CODE93` |
| `PrinterConstants.BARCODE_CODE128` | `CODE128` |
| `PrinterConstants.BARCODE_CODE128_AUTO` | `CODE128 auto` |
| `PrinterConstants.BARCODE_GS1_128` | `GS1-128` |
| `PrinterConstants.BARCODE_GS1_DATABAR_OMNIDIRECTIONAL` | `GS1 DataBar Omnidirectional` |
| `PrinterConstants.BARCODE_GS1_DATABAR_TRUNCATED` | `GS1 DataBar Truncated` |
| `PrinterConstants.BARCODE_GS1_DATABAR_LIMITED` | `GS1 DataBar Limited` |
| `PrinterConstants.BARCODE_GS1_DATABAR_EXPANDED` | `GS1 DataBar Expanded` |


### hri *(optional)*

*hri?*: `number`

Specifies the HRI position.

| *Value* | *Description* |
| --- | --- |
| `PrinterConstants.HRI_NONE` (default) | `No printing` |
| `PrinterConstants.HRI_ABOVE` | `Above the barcode` |
| `PrinterConstants.HRI_BELOW` | `Below the barcode` |
| `PrinterConstants.HRI_BOTH` | `Both above and below the barcode` |
| `PrinterConstants.PARAM_DEFAULT` | `Specifies the default value (no printing)` |
| `PrinterConstants.PARAM_UNSPECIFIED` | `<Obsolete> Not specify` |


### font *(optional)*

*font?*: `number`

Specifies the HRI font.

| *Value* | *Description* |
| --- | --- |
| `PrinterConstants.FONT_A` (default) | Font A |
| `PrinterConstants.FONT_B` | Font B |
| `PrinterConstants.FONT_C` | Font C |
| `PrinterConstants.FONT_D` | Font D |
| `PrinterConstants.FONT_E` | Font E |
| `PrinterConstants.PARAM_DEFAULT` | Specifies the default value (font A). |
| `PrinterConstants.PARAM_UNSPECIFIED` | `<Obsolete> Not specify` |


### width *(optional)*

*width?*: `number`

Specifies the width of a single module in dots.

| *Value* | *Description* |
| --- | --- |
| Integer from 2 to 6 | idth of a single module (in dots) |

### height *(optional)*

*height?*: `number`

Specifies the height of the barcode in dots.

| *Value* | *Description* |
| --- | --- |
| Integer from 1 to 255 | Compresses the image. |
