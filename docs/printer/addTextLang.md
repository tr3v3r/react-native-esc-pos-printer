## addTextLang

Adds language setting to the command buffer.

### Parameters

#### lang

- `number`

Specifies the target language.

| **Value** | **Description** |
| --- | --- |
| `PrinterConstants.LANG_EN` (default) | English (ANK specification) |
| `PrinterConstants.LANG_JA` | Japanese |
| `PrinterConstants.LANG_ZH_CN` | Simplified Chinese |
| `PrinterConstants.LANG_ZH_TW` | Traditional Chinese |
| `PrinterConstants.LANG_KO` | Korean |
| `PrinterConstants.LANG_TH` | Thai (South Asian specification) |
| `PrinterConstants.LANG_VI` | Vietnamese (South Asian specification) |
| `PrinterConstants.LANG_MULTI` | Multiple languages (UTF-8) |
| `PrinterConstants.PARAM_DEFAULT` | Specifies the default value (English). |

### Returns

`Promise<void>`

### Errors

| **Error status** | **Description** |
| --- | --- |
| ERR_PARAM | An invalid parameter was passed. |
| ERR_TIMEOUT | Failed to communicate with the devices within the specified time. |
| ERR_MEMORY | Necessary memory could not be allocated. |

### Supplementary explanation

- This API is called before the [addText](./addText.md) API.
- Use this API at the top of each print job.
- Available languages differ depending on character specifications of the printer. For details, see Technical Reference Guide of the printer.

