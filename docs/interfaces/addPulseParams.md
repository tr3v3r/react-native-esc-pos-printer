# Interface: AddPulseParams

### drawer *(optional)*

*drawer?*: `number`

Specifies the drawer kick connector.

| *Value* | *Description* |
| --- | --- |
| `PrinterConstants.DRAWER_2PIN` | Drawer kick connector pin No.2 |
| `PrinterConstants.DRAWER_5PIN` | Drawer kick connector pin No.5 |
| `PrinterConstants.PARAM_DEFAULT` | Specifies the default (drawer kick connector pin No.2). |

### time *(optional)*

*time?*: `number`

Specifies the on time of the drawer kick signal.

| *Value* | *Description* |
| --- | --- |
| `PrinterConstants.PULSE_100` | 100-msec signal |
| `PrinterConstants.PULSE_200` | 200-msec signal |
| `PrinterConstants.PULSE_300` | 300-msec signal |
| `PrinterConstants.PULSE_400` | 400-msec signal |
| `PrinterConstants.PULSE_500` | 500-msec signal |
| `PrinterConstants.PARAM_DEFAULT` | Specifies the default (100-msec signal). |
