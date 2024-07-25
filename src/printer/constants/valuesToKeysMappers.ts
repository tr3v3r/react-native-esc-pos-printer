import { remapConstants } from '../../core/utils';
import type { PrinterStatusProperties } from '../types';
import {
  PrinterErrorResult,
  PrinterErrorCodeResult,
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

export const PrinterErrorStatusMapping = remapConstants(PrinterErrorResult);

export const PrinterErrorCodeStatusMapping = remapConstants(
  PrinterErrorCodeResult
);

export const PrinterStatusMapping: Record<
  PrinterStatusProperties,
  Record<string, string>
> = {
  connection: {
    [CommonParams.TRUE]: CommonParams[CommonParams.TRUE],
    [CommonParams.FALSE]: CommonParams[CommonParams.FALSE],
  },
  online: {
    [CommonParams.TRUE]: CommonParams[CommonParams.TRUE],
    [CommonParams.FALSE]: CommonParams[CommonParams.FALSE],
    [CommonParams.UNKNOWN]: CommonParams[CommonParams.UNKNOWN],
  },
  coverOpen: {
    [CommonParams.TRUE]: CommonParams[CommonParams.TRUE],
    [CommonParams.FALSE]: CommonParams[CommonParams.FALSE],
    [CommonParams.UNKNOWN]: CommonParams[CommonParams.UNKNOWN],
  },
  paper: {
    [PrinterPaperStatus.PAPER_OK]:
      PrinterPaperStatus[PrinterPaperStatus.PAPER_OK],
    [PrinterPaperStatus.PAPER_NEAR_END]:
      PrinterPaperStatus[PrinterPaperStatus.PAPER_NEAR_END],
    [PrinterPaperStatus.PAPER_EMPTY]:
      PrinterPaperStatus[PrinterPaperStatus.PAPER_EMPTY],
    [CommonParams.UNKNOWN]: CommonParams[CommonParams.UNKNOWN],
  },
  paperFeed: {
    [CommonParams.TRUE]: CommonParams[CommonParams.TRUE],
    [CommonParams.FALSE]: CommonParams[CommonParams.FALSE],
    [CommonParams.UNKNOWN]: CommonParams[CommonParams.UNKNOWN],
  },
  panelSwitch: {
    [PrinterPanelSwitchStatus.SWITCH_ON]:
      PrinterPanelSwitchStatus[PrinterPanelSwitchStatus.SWITCH_ON],
    [PrinterPanelSwitchStatus.SWITCH_OFF]:
      PrinterPanelSwitchStatus[PrinterPanelSwitchStatus.SWITCH_OFF],
    [CommonParams.UNKNOWN]: CommonParams[CommonParams.UNKNOWN],
  },
  drawer: {
    [PrinterDrawerStatus.DRAWER_HIGH]:
      PrinterDrawerStatus[PrinterDrawerStatus.DRAWER_HIGH],
    [PrinterDrawerStatus.DRAWER_LOW]:
      PrinterDrawerStatus[PrinterDrawerStatus.DRAWER_LOW],
    [CommonParams.UNKNOWN]: CommonParams[CommonParams.UNKNOWN],
  },
  errorStatus: {
    [PrinterErrorStatus.NO_ERR]: PrinterErrorStatus[PrinterErrorStatus.NO_ERR],
    [PrinterErrorStatus.MECHANICAL_ERR]:
      PrinterErrorStatus[PrinterErrorStatus.MECHANICAL_ERR],
    [PrinterErrorStatus.AUTOCUTTER_ERR]:
      PrinterErrorStatus[PrinterErrorStatus.AUTOCUTTER_ERR],
    [PrinterErrorStatus.UNRECOVER_ERR]:
      PrinterErrorStatus[PrinterErrorStatus.UNRECOVER_ERR],
    [PrinterErrorStatus.AUTORECOVER_ERR]:
      PrinterErrorStatus[PrinterErrorStatus.AUTORECOVER_ERR],
    [CommonParams.UNKNOWN]: CommonParams[CommonParams.UNKNOWN],
  },
  autoRecoverError: {
    [PrinterAutoRecoverErrorStatus.HEAD_OVERHEAT]:
      PrinterAutoRecoverErrorStatus[
        PrinterAutoRecoverErrorStatus.HEAD_OVERHEAT
      ],
    [PrinterAutoRecoverErrorStatus.MOTOR_OVERHEAT]:
      PrinterAutoRecoverErrorStatus[
        PrinterAutoRecoverErrorStatus.MOTOR_OVERHEAT
      ],
    [PrinterAutoRecoverErrorStatus.BATTERY_OVERHEAT]:
      PrinterAutoRecoverErrorStatus[
        PrinterAutoRecoverErrorStatus.BATTERY_OVERHEAT
      ],
    [PrinterAutoRecoverErrorStatus.WRONG_PAPER]:
      PrinterAutoRecoverErrorStatus[PrinterAutoRecoverErrorStatus.WRONG_PAPER],
    [PrinterAutoRecoverErrorStatus.COVER_OPEN]:
      PrinterAutoRecoverErrorStatus[PrinterAutoRecoverErrorStatus.COVER_OPEN],
    [CommonParams.UNKNOWN]: CommonParams[CommonParams.UNKNOWN],
  },
  buzzer: {
    [CommonParams.TRUE]: CommonParams[CommonParams.TRUE],
    [CommonParams.FALSE]: CommonParams[CommonParams.FALSE],
    [CommonParams.UNKNOWN]: CommonParams[CommonParams.UNKNOWN],
  },
  adapter: {
    [CommonParams.TRUE]: CommonParams[CommonParams.TRUE],
    [CommonParams.FALSE]: CommonParams[CommonParams.FALSE],
    [CommonParams.UNKNOWN]: CommonParams[CommonParams.UNKNOWN],
  },
  batteryLevel: {
    [PrinterBatteryLevelStatus.EPOS2_BATTERY_LEVEL_6]:
      PrinterBatteryLevelStatus[
        PrinterBatteryLevelStatus.EPOS2_BATTERY_LEVEL_6
      ],
    [PrinterBatteryLevelStatus.EPOS2_BATTERY_LEVEL_5]:
      PrinterBatteryLevelStatus[
        PrinterBatteryLevelStatus.EPOS2_BATTERY_LEVEL_5
      ],
    [PrinterBatteryLevelStatus.EPOS2_BATTERY_LEVEL_4]:
      PrinterBatteryLevelStatus[
        PrinterBatteryLevelStatus.EPOS2_BATTERY_LEVEL_4
      ],
    [PrinterBatteryLevelStatus.EPOS2_BATTERY_LEVEL_3]:
      PrinterBatteryLevelStatus[
        PrinterBatteryLevelStatus.EPOS2_BATTERY_LEVEL_3
      ],
    [PrinterBatteryLevelStatus.EPOS2_BATTERY_LEVEL_2]:
      PrinterBatteryLevelStatus[
        PrinterBatteryLevelStatus.EPOS2_BATTERY_LEVEL_2
      ],
    [PrinterBatteryLevelStatus.EPOS2_BATTERY_LEVEL_1]:
      PrinterBatteryLevelStatus[
        PrinterBatteryLevelStatus.EPOS2_BATTERY_LEVEL_1
      ],
    [PrinterBatteryLevelStatus.EPOS2_BATTERY_LEVEL_0]:
      PrinterBatteryLevelStatus[
        PrinterBatteryLevelStatus.EPOS2_BATTERY_LEVEL_0
      ],
    [CommonParams.UNKNOWN]: CommonParams[CommonParams.UNKNOWN],
  },
  removalWaiting: {
    [PrinterRemovalWaitingStatus.REMOVAL_WAIT_PAPER]:
      PrinterRemovalWaitingStatus[
        PrinterRemovalWaitingStatus.REMOVAL_WAIT_PAPER
      ],
    [PrinterRemovalWaitingStatus.REMOVAL_WAIT_NONE]:
      PrinterRemovalWaitingStatus[
        PrinterRemovalWaitingStatus.REMOVAL_WAIT_NONE
      ],
    [CommonParams.UNKNOWN]: CommonParams[CommonParams.UNKNOWN],
  },
  paperTakenSensor: {
    [PrinterPaperTakenSensorStatus.REMOVAL_DETECT_PAPER]:
      PrinterPaperTakenSensorStatus[
        PrinterPaperTakenSensorStatus.REMOVAL_DETECT_PAPER
      ],
    [PrinterPaperTakenSensorStatus.REMOVAL_DETECT_PAPER_NONE]:
      PrinterPaperTakenSensorStatus[
        PrinterPaperTakenSensorStatus.REMOVAL_DETECT_PAPER_NONE
      ],
    [PrinterPaperTakenSensorStatus.REMOVAL_DETECT_UNKNOWN]:
      PrinterPaperTakenSensorStatus[
        PrinterPaperTakenSensorStatus.REMOVAL_DETECT_UNKNOWN
      ],
    [CommonParams.UNKNOWN]: CommonParams[CommonParams.UNKNOWN],
  },
  unrecoverError: {
    [PrinterUnrecoverErrorStatus.HIGH_VOLTAGE_ERR]:
      PrinterUnrecoverErrorStatus[PrinterUnrecoverErrorStatus.HIGH_VOLTAGE_ERR],
    [PrinterUnrecoverErrorStatus.LOW_VOLTAGE_ERR]:
      PrinterUnrecoverErrorStatus[PrinterUnrecoverErrorStatus.LOW_VOLTAGE_ERR],
    [CommonParams.UNKNOWN]: CommonParams[CommonParams.UNKNOWN],
  },
};

export type PrinterErrorCodesMapping =
  | typeof PrinterErrorStatusMapping
  | typeof PrinterErrorCodeStatusMapping;
