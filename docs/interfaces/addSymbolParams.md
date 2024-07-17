# Interface: addSymbolParams

### data

*data*: `string`
Specifies 2D symbol data as a text string.
Specify a string in accordance with the standard of the 2D symbol specified in type.

| *Type* | *Description* |
| --- | --- |
| `Standard PDF417`, `Truncated PDF417` | Converts the string into UTF-8, processes the escape sequence(s), and encodes the data. The maximum number of code words in the data area is 928, the maximum number of code words in a single stage is 30, and the maximum number of stages is 90. |
| `QR Code Model 1`, `QR Code Model 2`, `QR Code Micro` | Converts the string into JIS, processes the escape sequence(s), and encodes the data by choosing the data type from the following:<br>• Figure:0to9 <br>• Alphanumeric:0to9,AtoZ,blankspace,$,%,*,+,-,.,/,:<br>• Kanji:CharacterswhichcanberepresentedwithShiftJIScodes<br>• 8-bitbytedata:0x00to0xff |
| `MaxiCode Mode 2`, `MaxiCode Mode 3`, `MaxiCode Mode 4`, `MaxiCode Mode 5`, `MaxiCode Mode 6` | Converts the string into UTF-8, processes the escape sequence(s), and encodes the data. In Mode 2 or 3, if the first data is ][)>\x1e01\x1dyy ("yy" is a 2-digit figure), this is pro- cessed as the message header and the second and succeeding data sequence is pro- cessed as the primary message. Otherwise, the primary message starts with the fist data. For the mode 2, specify the primary message in the following format:<br>• Zipcode(1-to9-digitfigure)GS:(\x1d)<br>• ISOcountrycode(1-to3-digitfigure)GS:(\x1d)<br>• Serviceclasscode(1-to3-digitfigure) <br>For the mode 3, specify the primary message in the following format:<br>• Zipcode(datawhichcanbeconvertedwith1to6codesetsA)GS(\x1d)<br>• ISOcountrycode(1-to3-digitfigure)GS(\x1d)<br>• Serviceclasscode(1-to3-digitfigure) |
| `GS1 DataBar Stacked`, `GS1 DataBar Stacked Omnidirectional` | Converts the string into UTF-8, processes the escape sequence(s), and encodes the data. Specify a 13-digit product ID (GTIN) excluding the application ID (AI) and check digit. |
| `GS1 DataBar Expanded Stacked` | Converts the string into UTF-8, processes the escape sequence(s), and encodes the data. The application ID (AI) can be put in parentheses. The parentheses are used as print characters for HRI and not encoded as data. To encode the following characters, specify the corresponding 2-digit code starting with{:<br>• FNC1:{1<br>• (:{(<br>• ):}{) |
| `Aztec Code`, `DataMatrix` | Converts the string into UTF-8, processes the escape sequence(s), and encodes the data. |

### type

*type*: `number`

Specifies the 2D symbol type.

| *Value* | *Description* |
| --- | --- |
| `PrinterConstants.SYMBOL_PDF417_STANDARD` | Standard PDF417 |
| `PrinterConstants.SYMBOL_PDF417_TRUNCATED` | Truncated PDF417 |
| `PrinterConstants.SYMBOL_QRCODE_MODEL_1` | QR Code Model 1 |
| `PrinterConstants.SYMBOL_QRCODE_MODEL_2` | QR Code Model 2 |
| `PrinterConstants.SYMBOL_QRCODE_MICRO` | QR Code Micro |
| `PrinterConstants.SYMBOL_MAXICODE_MODE_2` | MaxiCode Mode 2 |
| `PrinterConstants.SYMBOL_MAXICODE_MODE_3` | MaxiCode Mode 3 |
| `PrinterConstants.SYMBOL_MAXICODE_MODE_4` | MaxiCode Mode 4 |
| `PrinterConstants.SYMBOL_MAXICODE_MODE_5` | MaxiCode Mode 5 |
| `PrinterConstants.SYMBOL_MAXICODE_MODE_6` | MaxiCode Mode 6 |
| `PrinterConstants.SYMBOL_GS1_DATABAR_STACKED` | GS1 DataBar Stacked |
| `PrinterConstants.SYMBOL_GS1_DATABAR_STACKED_OMNIDIRECTIONAL` | GS1 DataBar Stacked Omnidirectional |
| `PrinterConstants.SYMBOL_GS1_DATABAR_EXPANDED_STACKED` | GS1 DataBar Expanded Stacked |
| `PrinterConstants.SYMBOL_AZTECCODE_FULLRANGE` | Aztec Code Full-Range mode |
| `PrinterConstants.SYMBOL_AZTECCODE_COMPACT` | Aztec Code Compact mode |
| `PrinterConstants.SYMBOL_DATAMATRIX_SQUARE` | DataMatrix Square |
| `PrinterConstants.SYMBOL_DATAMATRIX_RECTANGLE_8` | DataMatrix Rectangle, 8 lines |
| `PrinterConstants.SYMBOL_DATAMATRIX_RECTANGLE_12` | DataMatrix Rectangle, 12 lines |
| `PrinterConstants.SYMBOL_DATAMATRIX_RECTANGLE_16` | DataMatrix Rectangle, 16 lines |


### level

*level*: `number`

Specifies the error correction level.
Specify a value in accordance with the 2D symbol type.
Specify "PARAM_DEFAULT" for MaxiCode, 2D GS1 DataBar, and DataMatrix.

❏ PDF417
| *Value* | *Description* |
| --- | --- |
| `PrinterConstants.LEVEL_0` | Error correction level 0 |
| `PrinterConstants.LEVEL_1` | Error correction level 1 |
| `PrinterConstants.LEVEL_2` | Error correction level 2 |
| `PrinterConstants.LEVEL_3` | Error correction level 3 |
| `PrinterConstants.LEVEL_4` | Error correction level 4 |
| `PrinterConstants.LEVEL_5` | Error correction level 5 |
| `PrinterConstants.LEVEL_6` | Error correction level 6 |
| `PrinterConstants.LEVEL_7` | Error correction level 7 |
| `PrinterConstants.LEVEL_8` | Error correction level 8 |
| `PrinterConstants.PARAM_DEFAULT` | Specifies the default value (Error correction level 1). |
| `PrinterConstants.PARAM_UNSPECIFIED` | `<Obsolete> Not specify.` |

❏ QR Code

| *Value* | *Description* |
| --- | --- |
| `PrinterConstants.LEVEL_L` | Error correction level L |
| `PrinterConstants.LEVEL_M` | Error correction level M |
| `PrinterConstants.LEVEL_Q` | Error correction level Q |
| `PrinterConstants.LEVEL_H` | Error correction level H |
| `PrinterConstants.PARAM_DEFAULT` | Specifies the default value (Error correction level M). |
| `PrinterConstants.PARAM_UNSPECIFIED` | `<Obsolete> Not specify.` |

❏ Aztec Code

| *Value* | *Description* |
| --- | --- |
| `Integer from 5 to 95` | Error correction level (in percents) |
| `PrinterConstants.PARAM_DEFAULT` | Specifies the default value (Error correction level 23). |
| `PrinterConstants.PARAM_UNSPECIFIED` | `<Obsolete> Not specify.` |


### width *(optional)*

*width?*: `number`

Specifies the module width.
An integer from 1 to 255 can be specified.
When "PrinterConstants.PARAM_UNSPECIFIED" is specified, the current setting is retained. The range differs depending on the 2D symbol type.


| *2D symbol type* | *Valid value* | *Default value* |
| --- | --- | --- |
| `PDF417` | 2 to 8 | 3 |
| `QR Code` | 3 to 16 | 3 |
| `MaxiCode` | 1 to 255 (Ignored) |  |
| `2D GS1 DataBar` | 2 to 8 | 2 |
| `Aztec Code` | 2 to 16 | 3 |
| `DataMatrix` | 2 to 16 | 3 |



### height *(optional)*

*height?*: `number`

Specifies the module height.
An integer from 1 to 255 can be specified.
When "PrinterConstants.PARAM_UNSPECIFIED" is specified, the current setting is retained. The range differs depending on the 2D symbol type.

| *2D symbol type* | *Valid value* | *Default value* |
| --- | --- | --- |
| `PDF417` | 2 to 8 | 3 |
| `QR Code`, `MaxiCode`, `2D GS1 DataBar`, `Aztec Code`, `DataMatrix` | 1 to 255 (Ignored) |  |

### size
*size*: `number`

Specifies the maximum size of the 2D symbol.
An integer from **0 to 65535** can be specified.
