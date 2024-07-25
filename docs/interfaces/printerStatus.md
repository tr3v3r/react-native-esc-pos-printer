# Interface: PrinterStatusResponse


### connection

*connection*: `{
  statusCode: number,
  status: string,
  message: string
}`

| *statusCode* | *status* | *message* |
| --- | --- | --- |
| `PrinterConstants.TRUE` | `"TRUE"` | `"Connected"` |
| `PrinterConstants.FALSE` | `"FALSE"` | `"Status is unknown."` |

### online

*online*: `{
  statusCode: number,
  status: string,
  message: string
}`

| *statusCode* | *status* | *message* |
| --- | --- | --- |
| `PrinterConstants.TRUE` | `"TRUE"` | `"Online"` |
| `PrinterConstants.FALSE` | `"FALSE"` | `"Offline"` |
| `PrinterConstants.UNKNOWN` | `"UNKNOWN"` | `"Status is unknown."` |

### coverOpen

*coverOpen*: `{
  statusCode: number,
  status: string,
  message: string
}`
| *statusCode* | *status* | *message* |
| --- | --- | --- |
| `PrinterConstants.TRUE` | `"TRUE"` | `"Cover is open."` |
| `PrinterConstants.FALSE` | `"FALSE"` | `"Cover is closed."` |
| `PrinterConstants.UNKNOWN` | `"UNKNOWN"` | `"Status is unknown."` |

### paper

*paper*: `{
  statusCode: number,
  status: string,
  message: string
}`

| *statusCode* | *status* | *message* |
| --- | --- | --- |
| `PrinterConstants.PAPER_OK` | `"PAPER_OK"` | `"Paper remains."` |
| `PrinterConstants.PAPER_NEAR_END` | `"PAPER_NEAR_END"` | `"Paper is running out."` |
| `PrinterConstants.PAPER_EMPTY` | `"PAPER_EMPTY"` | `"Paper has run out."` |
| `PrinterConstants.UNKNOWN` | `"UNKNOWN"` | `"Status is unknown."` |

### paperFeed

*paperFeed*: `{
  statusCode: number,
  status: string,
  message: string
}`

| *statusCode* | *status* | *message* |
| --- | --- | --- |
| `PrinterConstants.TRUE` | `"TRUE"` | `"Paper feed in progress"` |
| `PrinterConstants.FALSE` | `"FALSE"` | `"Stopped"` |
| `PrinterConstants.UNKNOWN` | `"UNKNOWN"` | `"Status is unknown."` |

### panelSwitch

*panelSwitch*: `{
  statusCode: number,
  status: string,
  message: string
}`

| *statusCode* | *status* | *message* |
| --- | --- | --- |
| `PrinterConstants.SWITCH_ON` | `"SWITCH_ON"` | `"Pressed"` |
| `PrinterConstants.SWITCH_OFF` | `"SWITCH_OFF"` | `"Not pressed"` |
| `PrinterConstants.UNKNOWN` | `"UNKNOWN"` | `"Status is unknown."` |

### drawer

*drawer*: `{
  statusCode: number,
  status: string,
  message: string
}`
| *statusCode* | *status* | *message* |
| --- | --- | --- |
| `PrinterConstants.DRAWER_HIGH` | `"DRAWER_HIGH"` | `"High"` |
| `PrinterConstants.DRAWER_LOW` | `"DRAWER_LOW"` | `"Low"` |
| `PrinterConstants.UNKNOWN` | `"UNKNOWN"` | `"Status is unknown."` |

### errorStatus

*errorStatus*: `{
  statusCode: number,
  status: string,
  message: string
}`

| *statusCode* | *status* | *message* |
| --- | --- | --- |
| `PrinterConstants.NO_ERR` | `"NO_ERR"` | `Normal` |
| `PrinterConstants.MECHANICAL_ERR` | `"MECHANICAL_ERR"` | `"Mechanical error occurred."` |
| `PrinterConstants.AUTOCUTTER_ERR` | `"AUTOCUTTER_ERR"` | `"Auto cutter error occurred."` |
| `PrinterConstants.UNRECOVER_ERR` | `"UNRECOVER_ERR"` | `"Unrecoverable error occurred."` |
| `PrinterConstants.AUTORECOVER_ERR` | `"AUTORECOVER_ERR"` | `"Automatic recovery error occurred."` |

### autoRecoverError

*autoRecoverError*: `{
  statusCode: number,
  status: string,
  message: string
}`

| *statusCode* | *status* | *message* |
| --- | --- | --- |
| `PrinterConstants.HEAD_OVERHEAT` | `"HEAD_OVERHEAT"` | `"Head overheat error"` |
| `PrinterConstants.MOTOR_OVERHEAT` | `"MOTOR_OVERHEAT"` | `"Motor driver IC overheat error"` |
| `PrinterConstants.BATTERY_OVERHEAT` | `"BATTERY_OVERHEAT"` | `"Battery overheat error"` |
| `PrinterConstants.WRONG_PAPER` | `"WRONG_PAPER"` | `"Paper error"` |
| `PrinterConstants.COVER_OPEN` | `"COVER_OPEN"` | `"Cover is open."` |
| `PrinterConstants.UNKNOWN` | `"UNKNOWN"` | `"Unknown status"` |

### buzzer

*buzzer*: `{
  statusCode: number,
  status: string,
  message: string
}`

| *statusCode* | *status* | *message* |
| --- | --- | --- |
| `PrinterConstants.TRUE` | `"TRUE"` | `"Sounding (Applicable printer only)"` |
| `PrinterConstants.FALSE` | `"FALSE"` | `"Stopped (Applicable printer only)"` |
| `PrinterConstants.UNKNOWN` | `"UNKNOWN"` | `"Status is unknown."` |

### adapter

*adapter*: `{
  statusCode: number,
  status: string,
  message: string
}`

| *statusCode* | *status* | *message* |
| --- | --- | --- |
| `PrinterConstants.TRUE` | `"TRUE"` | `"Connected"` |
| `PrinterConstants.FALSE` | `"FALSE"` | `"Disconnected"` |
| `PrinterConstants.UNKNOWN` | `"UNKNOWN"` | `"Status is unknown."` |

### batteryLevel

*batteryLevel*: `{
  statusCode: number,
  status: string,
  message: string
}`

| *statusCode* | *status* | *message* |
| --- | --- | --- |
| `PrinterConstants.BATTERY_LEVEL_6` | `"BATTERY_LEVEL_6"` | `"Remaining battery capacity 6"` |
| `PrinterConstants.BATTERY_LEVEL_5` | `"BATTERY_LEVEL_5"` | `"Remaining battery capacity 5"` |
| `PrinterConstants.BATTERY_LEVEL_4` | `"BATTERY_LEVEL_4"` | `"Remaining battery capacity 4"` |
| `PrinterConstants.BATTERY_LEVEL_3` | `"BATTERY_LEVEL_3"` | `"Remaining battery capacity 3"` |
| `PrinterConstants.BATTERY_LEVEL_2` | `"BATTERY_LEVEL_2"` | `"Remaining battery capacity 2"` |
| `PrinterConstants.BATTERY_LEVEL_1` | `"BATTERY_LEVEL_1"` | `"Remaining battery capacity 1 (almost run out)"` |
| `PrinterConstants.BATTERY_LEVEL_0` | `"BATTERY_LEVEL_0"` | `"Remaining battery capacity 0 (run out)"` |
| `PrinterConstants.UNKNOWN` | `"UNKNOWN"` | `"Status is unknown."` |

### removalWaiting

*removalWaiting*: `{
  statusCode: number,
  status: string,
  message: string
}`

| *statusCode* | *status* | *message* |
| --- | --- | --- |
| `PrinterConstants.REMOVAL_WAIT_PAPER` | `"REMOVAL_WAIT_PAPER"` | `"Waiting for removal."` |
| `PrinterConstants.REMOVAL_WAIT_NONE` | `"REMOVAL_WAIT_NONE"` | `"Not waiting for removal."` |
| `PrinterConstants.UNKNOWN` | `"UNKNOWN"` | `"Status is unknown."` |

### paperTakenSensor

*paperTakenSensor*: `{
  statusCode: number,
  status: string,
  message: string
}`

| *statusCode* | *status* | *message* |
| --- | --- | --- |
| `PrinterConstants.REMOVAL_DETECT_PAPER` | `"REMOVAL_DETECT_PAPER"` | `"The paper removal sensor is detecting paper."` |
| `PrinterConstants.REMOVAL_DETECT_PAPER_NONE` | `"REMOVAL_DETECT_PAPER_NONE"` | `"The paper removal sensor is not detecting paper."` |
| `PrinterConstants.REMOVAL_DETECT_UNKNOWN` | `"REMOVAL_DETECT_UNKNOWN"` | `"A state that is not detectable by the paper removal sensor."` |

### unrecoverError

*unrecoverError*: `{
  statusCode: number,
  status: string,
  message: string
}`

| *statusCode* | *status* | *message* |
| --- | --- | --- |
| `PrinterConstants.HIGH_VOLTAGE_ERR` | `"HIGH_VOLTAGE_ERR"` | `"High voltage error"` |
| `PrinterConstants.LOW_VOLTAGE_ERR` | `"LOW_VOLTAGE_ERR"` | `"Low voltage error"` |
| `PrinterConstants.UNKNOWN` | `"UNKNOWN"` | `"Status is unknown."` |
