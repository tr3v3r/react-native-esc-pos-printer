import { NativeModules } from 'react-native';

const { EscPosPrinter } = NativeModules;

const EscPosPrinterConstants: Record<string, number> =
  EscPosPrinter.getConstants();

export enum PrinterPaperStatus {
  PAPER_OK = EscPosPrinterConstants.PAPER_OK,
  PAPER_NEAR_END = EscPosPrinterConstants.PAPER_NEAR_END,
  PAPER_EMPTY = EscPosPrinterConstants.PAPER_EMPTY,
}

export enum PrinterPanelSwitchStatus {
  SWITCH_ON = EscPosPrinterConstants.SWITCH_ON,
  SWITCH_OFF = EscPosPrinterConstants.SWITCH_OFF,
}

export enum PrinterDrawerStatus {
  DRAWER_HIGH = EscPosPrinterConstants.DRAWER_HIGH,
  DRAWER_LOW = EscPosPrinterConstants.DRAWER_LOW,
}

export enum PrinterErrorStatus {
  NO_ERR = EscPosPrinterConstants.NO_ERR,
  MECHANICAL_ERR = EscPosPrinterConstants.MECHANICAL_ERR,
  AUTOCUTTER_ERR = EscPosPrinterConstants.AUTOCUTTER_ERR,
  UNRECOVER_ERR = EscPosPrinterConstants.UNRECOVER_ERR,
  AUTORECOVER_ERR = EscPosPrinterConstants.AUTORECOVER_ERR,
}

export enum PrinterAutoRecoverErrorStatus {
  HEAD_OVERHEAT = EscPosPrinterConstants.HEAD_OVERHEAT,
  MOTOR_OVERHEAT = EscPosPrinterConstants.MOTOR_OVERHEAT,
  BATTERY_OVERHEAT = EscPosPrinterConstants.BATTERY_OVERHEAT,
  WRONG_PAPER = EscPosPrinterConstants.WRONG_PAPER,
  COVER_OPEN = EscPosPrinterConstants.COVER_OPEN,
}

export enum PrinterBatteryLevelStatus {
  EPOS2_BATTERY_LEVEL_6 = EscPosPrinterConstants.EPOS2_BATTERY_LEVEL_6,
  EPOS2_BATTERY_LEVEL_5 = EscPosPrinterConstants.EPOS2_BATTERY_LEVEL_5,
  EPOS2_BATTERY_LEVEL_4 = EscPosPrinterConstants.EPOS2_BATTERY_LEVEL_4,
  EPOS2_BATTERY_LEVEL_3 = EscPosPrinterConstants.EPOS2_BATTERY_LEVEL_3,
  EPOS2_BATTERY_LEVEL_2 = EscPosPrinterConstants.EPOS2_BATTERY_LEVEL_2,
  EPOS2_BATTERY_LEVEL_1 = EscPosPrinterConstants.EPOS2_BATTERY_LEVEL_1,
  EPOS2_BATTERY_LEVEL_0 = EscPosPrinterConstants.EPOS2_BATTERY_LEVEL_0,
}

export enum PrinterRemovalWaitingStatus {
  REMOVAL_WAIT_PAPER = EscPosPrinterConstants.REMOVAL_WAIT_PAPER,
  REMOVAL_WAIT_NONE = EscPosPrinterConstants.REMOVAL_WAIT_NONE,
}

export enum PrinterPaperTakenSensorStatus {
  REMOVAL_DETECT_PAPER = EscPosPrinterConstants.REMOVAL_DETECT_PAPER,
  REMOVAL_DETECT_PAPER_NONE = EscPosPrinterConstants.REMOVAL_DETECT_PAPER_NONE,
  REMOVAL_DETECT_UNKNOWN = EscPosPrinterConstants.REMOVAL_DETECT_UNKNOWN,
}

export enum PrinterUnrecoverErrorStatus {
  HIGH_VOLTAGE_ERR = EscPosPrinterConstants.HIGH_VOLTAGE_ERR,
  LOW_VOLTAGE_ERR = EscPosPrinterConstants.LOW_VOLTAGE_ERR,
}
