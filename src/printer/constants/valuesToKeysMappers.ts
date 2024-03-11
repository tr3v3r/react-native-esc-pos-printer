import { remapConstants } from '../../core/utils';
import type { PrinterStatusProperties } from '../types';
import {
  PrinterErrorResult,
  PrinterErrorCodeResult,
  PrinterGetSettingsType,
  PrinterConnectionStatus,
  PrinterOnlineStatus,
  PrinterCoverStatus,
  PrinterPaperStatus,
  PrinterPaperFeedStatus,
  PrinterPanelSwitchStatus,
  PrinterDrawerStatus,
  PrinterErrorStatus,
  PrinterAutoRecoverErrorStatus,
  PrinterBuzzerStatus,
  PrinterAdapterStatus,
  PrinterBatteryLevelStatus,
  PrinterRemovalWaitingStatus,
  PrinterPaperTakenSensorStatus,
  PrinterUnrecoverErrorStatus,
} from './enums';

export const PrinterErrorStatusMapping = remapConstants(PrinterErrorResult);
export const PrinterGetSettingsTypeMapping = remapConstants(
  PrinterGetSettingsType
);
export const PrinterErrorCodeStatusMapping = remapConstants(
  PrinterErrorCodeResult
);

export const PrinterStatusMapping: Record<
  PrinterStatusProperties,
  Record<string, string>
> = {
  connection: remapConstants(PrinterConnectionStatus),
  online: remapConstants(PrinterOnlineStatus),
  coverOpen: remapConstants(PrinterCoverStatus),
  paper: remapConstants(PrinterPaperStatus),
  paperFeed: remapConstants(PrinterPaperFeedStatus),
  panelSwitch: remapConstants(PrinterPanelSwitchStatus),
  drawer: remapConstants(PrinterDrawerStatus),
  errorStatus: remapConstants(PrinterErrorStatus),
  autoRecoverError: remapConstants(PrinterAutoRecoverErrorStatus),
  buzzer: remapConstants(PrinterBuzzerStatus),
  adapter: remapConstants(PrinterAdapterStatus),
  batteryLevel: remapConstants(PrinterBatteryLevelStatus),
  removalWaiting: remapConstants(PrinterRemovalWaitingStatus),
  paperTakenSensor: remapConstants(PrinterPaperTakenSensorStatus),
  unrecoverError: remapConstants(PrinterUnrecoverErrorStatus),
};

export type PrinterErrorCodesMapping =
  | typeof PrinterErrorStatusMapping
  | typeof PrinterErrorCodeStatusMapping;
