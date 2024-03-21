import {
  PrinterErrorResult,
  PrinterErrorCodeResult,
  GetPrinterSettingsPaperWidthValues,
  GetPrinterSettingsDensityValues,
  GetPrinterSettingsPrintSpeedValues,
  PrinterPaperStatus,
  PrinterPanelSwitchStatus,
  PrinterDrawerStatus,
  PrinterErrorStatus,
  PrinterAutoRecoverErrorStatus,
  PrinterBatteryLevelStatus,
  PrinterRemovalWaitingStatus,
  PrinterPaperTakenSensorStatus,
  PrinterUnrecoverErrorStatus,
  CommonParams,
} from './enums';

import type { PrinterStatusProperties } from '../types';

export const InitPrinterErrorMessageMapping = {
  [PrinterErrorResult.ERR_PARAM]: 'An invalid parameter was passed.',
  [PrinterErrorResult.ERR_MEMORY]:
    'Memory necessary for processing could not be allocated.',
  [PrinterErrorResult.ERR_UNSUPPORTED]:
    'A model name or language not supported was specified.',
  [PrinterErrorResult.ERR_FAILURE]: 'An unknown error occurred.',
} as const;

export const ConnectPrinterErrorMessageMapping = {
  [PrinterErrorResult.ERR_PARAM]: 'An invalid parameter was passed.',
  [PrinterErrorResult.ERR_CONNECT]: 'Failed to open the device.',
  [PrinterErrorResult.ERR_TIMEOUT]:
    'Failed to communicate with the devices within the specified time.',
  [PrinterErrorResult.ERR_ILLEGAL]:
    'Tried to start communication with a printer with which communication had been already established. Tried to start communication with a printer during reconnection process.',
  [PrinterErrorResult.ERR_MEMORY]:
    'Memory necessary for processing could not be allocated.',
  [PrinterErrorResult.ERR_FAILURE]: 'An unknown error occurred.',
  [PrinterErrorResult.ERR_PROCESSING]: 'Could not run the process.',
  [PrinterErrorResult.ERR_NOT_FOUND]: 'The device could not be found.',
  [PrinterErrorResult.ERR_IN_USE]: 'The device was in use.',
  [PrinterErrorResult.ERR_TYPE_INVALID]: 'The device type is different.',
  [PrinterErrorResult.ERR_RECOVERY_FAILURE]: 'Failed to recover the printer.',
} as const;

export const DisconnectPrinterErrorMessageMapping = {
  [PrinterErrorResult.ERR_ILLEGAL]:
    'Tried to end communication where it had not been established.',
  [PrinterErrorResult.ERR_MEMORY]: 'Necessary memory could not be allocated.',
  [PrinterErrorResult.ERR_FAILURE]: 'An unknown error occurred.',
  [PrinterErrorResult.ERR_PROCESSING]: 'Could not run the process.',
  [PrinterErrorResult.ERR_DISCONNECT]:
    'Failed to disconnect the device.T ried to terminate communication with a printer during reconnection process.',
  [PrinterErrorResult.ERR_INIT]:
    'Printer is not initialized. Please call init() first.',
} as const;

export const CommonOperationErrorMessageMapping = {
  [PrinterErrorResult.ERR_PARAM]: 'An invalid parameter was passed.',
  [PrinterErrorResult.ERR_MEMORY]:
    'Memory necessary for processing could not be allocated.',
  [PrinterErrorResult.ERR_FAILURE]: 'An unknown error occurred.',
  [PrinterErrorResult.ERR_INIT]:
    'Printer is not initialized. Please call init() first.',
} as const;

export const SendDataPrinterErrorMessageMapping = {
  [PrinterErrorResult.ERR_PARAM]: 'An invalid parameter was passed.',
  [PrinterErrorResult.ERR_MEMORY]:
    'Memory necessary for processing could not be allocated.',
  [PrinterErrorResult.ERR_FAILURE]: 'An unknown error occurred.',
  [PrinterErrorResult.ERR_PROCESSING]: 'Could not run the process.',
  [PrinterErrorResult.ERR_ILLEGAL]:
    'The control commands have not been buffered. This API was called while no communication had been started.',
  [PrinterErrorResult.ERR_INIT]:
    'Printer is not initialized. Please call init() first.',
} as const;

export const PrintErrorCodeMessageMapping = {
  [PrinterErrorCodeResult.CODE_ERR_AUTORECOVER]:
    'Automatic recovery error occurred.',
  [PrinterErrorCodeResult.CODE_ERR_COVER_OPEN]: 'Cover open error occurred.',
  [PrinterErrorCodeResult.CODE_ERR_CUTTER]: 'Auto cutter error occurred.',
  [PrinterErrorCodeResult.CODE_ERR_MECHANICAL]: 'Mechanical error occurred.',
  [PrinterErrorCodeResult.CODE_ERR_EMPTY]:
    'No paper is left in the roll paper end detector.',
  [PrinterErrorCodeResult.CODE_ERR_UNRECOVERABLE]:
    'Unrecoverable error occurred.',
  [PrinterErrorCodeResult.CODE_ERR_FAILURE]:
    'Error exists in the requested document syntax.',
  [PrinterErrorCodeResult.CODE_ERR_NOT_FOUND]:
    'Printer specified by the device ID does not exist.',
  [PrinterErrorCodeResult.CODE_ERR_SYSTEM]:
    'Error occurred with the printing system.',
  [PrinterErrorCodeResult.CODE_ERR_PORT]:
    'Error was detected with the communication port.',
  [PrinterErrorCodeResult.CODE_ERR_TIMEOUT]: 'Print timeout occurred.',
  [PrinterErrorCodeResult.CODE_ERR_JOB_NOT_FOUND]:
    'Specified print job ID does not exist.',
  [PrinterErrorCodeResult.CODE_ERR_SPOOLER]: 'Print queue is full.',
  [PrinterErrorCodeResult.CODE_ERR_BATTERY_LOW]: 'Battery has run out.',
  [PrinterErrorCodeResult.CODE_ERR_TOO_MANY_REQUESTS]:
    'The number of print jobs sent to the printer has exceeded the allowable limit.',
  [PrinterErrorCodeResult.CODE_ERR_REQUEST_ENTITY_TOO_LARGE]:
    'The size of the print job data exceeds the capacity of the printer.',
  [PrinterErrorCodeResult.CODE_ERR_WAIT_REMOVAL]:
    'Print command sent while waiting for paper removal.',
  [PrinterErrorCodeResult.CODE_PRINTING]: 'Printing.',

  [PrinterErrorCodeResult.CODE_ERR_MEMORY]:
    'Sufficient memory required for processing could not be allocated.',
  [PrinterErrorCodeResult.CODE_ERR_PROCESSING]: 'Could not run the process.',
  [PrinterErrorCodeResult.CODE_ERR_ILLEGAL]:
    'This API was called while no communication had been started.',
  [PrinterErrorCodeResult.CODE_ERR_DEVICE_BUSY]:
    'Could not run the process because the printer is operating.',
};

export const GetPrinterSettingsPaperWidthValuesMapping = {
  [GetPrinterSettingsPaperWidthValues.PRINTER_SETTING_PAPERWIDTH58_0]: 58,
  [GetPrinterSettingsPaperWidthValues.PRINTER_SETTING_PAPERWIDTH60_0]: 60,
  [GetPrinterSettingsPaperWidthValues.PRINTER_SETTING_PAPERWIDTH70_0]: 70,
  [GetPrinterSettingsPaperWidthValues.PRINTER_SETTING_PAPERWIDTH76_0]: 76,
  [GetPrinterSettingsPaperWidthValues.PRINTER_SETTING_PAPERWIDTH80_0]: 80,
};

export const GetPrinterSettingsPrintDencityValuesMapping = {
  [GetPrinterSettingsDensityValues.PRINTER_SETTING_PRINTDENSITYDIP]: 0,
  [GetPrinterSettingsDensityValues.PRINTER_SETTING_PRINTDENSITY70]: 70,
  [GetPrinterSettingsDensityValues.PRINTER_SETTING_PRINTDENSITY75]: 75,
  [GetPrinterSettingsDensityValues.PRINTER_SETTING_PRINTDENSITY80]: 80,
  [GetPrinterSettingsDensityValues.PRINTER_SETTING_PRINTDENSITY85]: 85,
  [GetPrinterSettingsDensityValues.PRINTER_SETTING_PRINTDENSITY90]: 90,
  [GetPrinterSettingsDensityValues.PRINTER_SETTING_PRINTDENSITY95]: 95,
  [GetPrinterSettingsDensityValues.PRINTER_SETTING_PRINTDENSITY100]: 100,
  [GetPrinterSettingsDensityValues.PRINTER_SETTING_PRINTDENSITY105]: 105,
  [GetPrinterSettingsDensityValues.PRINTER_SETTING_PRINTDENSITY110]: 110,
  [GetPrinterSettingsDensityValues.PRINTER_SETTING_PRINTDENSITY115]: 115,
  [GetPrinterSettingsDensityValues.PRINTER_SETTING_PRINTDENSITY120]: 120,
  [GetPrinterSettingsDensityValues.PRINTER_SETTING_PRINTDENSITY125]: 125,
  [GetPrinterSettingsDensityValues.PRINTER_SETTING_PRINTDENSITY130]: 130,
};

export const GetPrinterSettingsPrintSpeendValuesMapping = {
  [GetPrinterSettingsPrintSpeedValues.PRINTER_SETTING_PRINTSPEED1]: 1,
  [GetPrinterSettingsPrintSpeedValues.PRINTER_SETTING_PRINTSPEED2]: 2,
  [GetPrinterSettingsPrintSpeedValues.PRINTER_SETTING_PRINTSPEED3]: 3,
  [GetPrinterSettingsPrintSpeedValues.PRINTER_SETTING_PRINTSPEED4]: 4,
  [GetPrinterSettingsPrintSpeedValues.PRINTER_SETTING_PRINTSPEED5]: 5,
  [GetPrinterSettingsPrintSpeedValues.PRINTER_SETTING_PRINTSPEED6]: 6,
  [GetPrinterSettingsPrintSpeedValues.PRINTER_SETTING_PRINTSPEED7]: 7,
  [GetPrinterSettingsPrintSpeedValues.PRINTER_SETTING_PRINTSPEED8]: 8,
  [GetPrinterSettingsPrintSpeedValues.PRINTER_SETTING_PRINTSPEED9]: 9,
  [GetPrinterSettingsPrintSpeedValues.PRINTER_SETTING_PRINTSPEED10]: 10,
  [GetPrinterSettingsPrintSpeedValues.PRINTER_SETTING_PRINTSPEED11]: 11,
  [GetPrinterSettingsPrintSpeedValues.PRINTER_SETTING_PRINTSPEED12]: 12,
  [GetPrinterSettingsPrintSpeedValues.PRINTER_SETTING_PRINTSPEED13]: 13,
  [GetPrinterSettingsPrintSpeedValues.PRINTER_SETTING_PRINTSPEED14]: 14,
  [GetPrinterSettingsPrintSpeedValues.PRINTER_SETTING_PRINTSPEED15]: 15,
  [GetPrinterSettingsPrintSpeedValues.PRINTER_SETTING_PRINTSPEED16]: 16,
  [GetPrinterSettingsPrintSpeedValues.PRINTER_SETTING_PRINTSPEED17]: 17,
};

export const GetPrinterStatusMessageMapping: Record<
  PrinterStatusProperties,
  Record<string, string>
> = {
  connection: {
    [CommonParams.TRUE]: 'Connected',
    [CommonParams.FALSE]: 'Status is unknown.',
  },
  online: {
    [CommonParams.TRUE]: 'Online',
    [CommonParams.FALSE]: 'Offline',
    [CommonParams.UNKNOWN]: 'Status is unknown.',
  },
  coverOpen: {
    [CommonParams.TRUE]: 'Cover is open.',
    [CommonParams.FALSE]: 'Cover is closed.',
    [CommonParams.UNKNOWN]: 'Status is unknown.',
  },
  paper: {
    [PrinterPaperStatus.PAPER_OK]: 'Paper remains.',
    [PrinterPaperStatus.PAPER_NEAR_END]: 'Paper is running out.',
    [PrinterPaperStatus.PAPER_EMPTY]: 'Paper has run out.',
    [CommonParams.UNKNOWN]: 'Status is unknown.',
  },
  paperFeed: {
    [CommonParams.TRUE]: 'Paper feed in progress',
    [CommonParams.FALSE]: 'Stopped',
    [CommonParams.UNKNOWN]: 'Status is unknown.',
  },
  panelSwitch: {
    [PrinterPanelSwitchStatus.SWITCH_ON]: 'Pressed',
    [PrinterPanelSwitchStatus.SWITCH_OFF]: 'Not pressed',
    [CommonParams.UNKNOWN]: 'Status is unknown.',
  },
  drawer: {
    [PrinterDrawerStatus.DRAWER_HIGH]: 'High',
    [PrinterDrawerStatus.DRAWER_LOW]: 'Low',
    [CommonParams.UNKNOWN]: 'Status is unknown.',
  },
  errorStatus: {
    [PrinterErrorStatus.NO_ERR]: 'Normal',
    [PrinterErrorStatus.MECHANICAL_ERR]: 'Mechanical error occurred.',
    [PrinterErrorStatus.AUTOCUTTER_ERR]: 'Auto cutter error occurred.',
    [PrinterErrorStatus.UNRECOVER_ERR]: 'Unrecoverable error occurred.',
    [PrinterErrorStatus.AUTORECOVER_ERR]: 'Automatic recovery error occurred.',
    [CommonParams.UNKNOWN]: 'Status is unknown.',
  },
  autoRecoverError: {
    [PrinterAutoRecoverErrorStatus.HEAD_OVERHEAT]: 'Head overheat error',
    [PrinterAutoRecoverErrorStatus.MOTOR_OVERHEAT]:
      'Motor driver IC overheat error',
    [PrinterAutoRecoverErrorStatus.BATTERY_OVERHEAT]: 'Battery overheat error',
    [PrinterAutoRecoverErrorStatus.WRONG_PAPER]: 'Paper error',
    [PrinterAutoRecoverErrorStatus.COVER_OPEN]: 'Cover is open.',
    [CommonParams.UNKNOWN]: 'Status is unknown.',
  },
  buzzer: {
    [CommonParams.TRUE]: 'Sounding',
    [CommonParams.FALSE]: 'Stopped',
    [CommonParams.UNKNOWN]: 'Status is unknown.',
  },
  adapter: {
    [CommonParams.TRUE]: 'Connected',
    [CommonParams.FALSE]: 'Disconnected',
    [CommonParams.UNKNOWN]: 'Status is unknown.',
  },
  batteryLevel: {
    [PrinterBatteryLevelStatus.EPOS2_BATTERY_LEVEL_6]:
      'Remaining battery capacity 6',
    [PrinterBatteryLevelStatus.EPOS2_BATTERY_LEVEL_5]:
      'Remaining battery capacity 5',
    [PrinterBatteryLevelStatus.EPOS2_BATTERY_LEVEL_4]:
      'Remaining battery capacity 4',
    [PrinterBatteryLevelStatus.EPOS2_BATTERY_LEVEL_3]:
      'Remaining battery capacity 3',
    [PrinterBatteryLevelStatus.EPOS2_BATTERY_LEVEL_2]:
      'Remaining battery capacity 2',
    [PrinterBatteryLevelStatus.EPOS2_BATTERY_LEVEL_1]:
      'Remaining battery capacity 1',
    [PrinterBatteryLevelStatus.EPOS2_BATTERY_LEVEL_0]:
      'Remaining battery capacity 0',
    [CommonParams.UNKNOWN]: 'Status is unknown.',
  },
  removalWaiting: {
    [PrinterRemovalWaitingStatus.REMOVAL_WAIT_PAPER]:
      'Waiting for paper removal',
    [PrinterRemovalWaitingStatus.REMOVAL_WAIT_NONE]: 'Not waiting for removal.',
    [CommonParams.UNKNOWN]: 'Status is unknown.',
  },
  paperTakenSensor: {
    [PrinterPaperTakenSensorStatus.REMOVAL_DETECT_PAPER]:
      'The paper removal sensor is detecting paper',
    [PrinterPaperTakenSensorStatus.REMOVAL_DETECT_PAPER_NONE]:
      'The paper removal sensor is not detecting paper.',
    [PrinterPaperTakenSensorStatus.REMOVAL_DETECT_UNKNOWN]:
      'A state that is not detectable by the paper removal sensor',
    [CommonParams.UNKNOWN]: 'Status is unknown.',
  },
  unrecoverError: {
    [PrinterUnrecoverErrorStatus.HIGH_VOLTAGE_ERR]: 'High voltage error',
    [PrinterUnrecoverErrorStatus.LOW_VOLTAGE_ERR]: 'Low voltage error',
    [CommonParams.UNKNOWN]: 'Status is unknown.',
  },
};

export type PrinterErrorMessageMapping =
  | typeof InitPrinterErrorMessageMapping
  | typeof ConnectPrinterErrorMessageMapping
  | typeof DisconnectPrinterErrorMessageMapping
  | typeof CommonOperationErrorMessageMapping
  | typeof SendDataPrinterErrorMessageMapping
  | typeof PrintErrorCodeMessageMapping
  | typeof GetPrinterSettingsPaperWidthValuesMapping;
