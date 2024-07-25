import {
  PrinterAddCutType,
  PrinterErrorResult,
  PrinterErrorCodeResult,
  PrinterModelLang,
  CommonParams,
  ColorType,
  TextLangType,
} from './common';

import {
  PrinterGetSettingsType,
  GetPrinterSettingsDensityValues,
  GetPrinterSettingsPaperWidthValues,
  GetPrinterSettingsPrintSpeedValues,
} from './settings';

import {
  PrinterPaperStatus,
  PrinterPanelSwitchStatus,
  PrinterDrawerStatus,
  PrinterErrorStatus,
  PrinterAutoRecoverErrorStatus,
  PrinterBatteryLevelStatus,
  PrinterRemovalWaitingStatus,
  PrinterPaperTakenSensorStatus,
  PrinterUnrecoverErrorStatus,
} from './status';
import {
  ImageCompressType,
  ImageHalftoneType,
  ImageColorModeType,
} from './image';

import { BarcodeType, BarcodeHRI } from './barcode';
import { SymbolType, SymbolLevel } from './symbol';
import { FontType, TextAlignType } from './textStyle';
import { PrinterAddPulseDrawerType, PrinterAddPulseTimeType } from './pulse';

export const PrinterConstants = {
  ...PrinterModelLang,
  ...PrinterAddCutType,
  ...PrinterGetSettingsType,
  ...GetPrinterSettingsPaperWidthValues,
  ...GetPrinterSettingsDensityValues,
  ...GetPrinterSettingsPrintSpeedValues,
  ...ColorType,
  ...ImageCompressType,
  ...ImageHalftoneType,
  ...ImageColorModeType,
  ...BarcodeType,
  ...BarcodeHRI,
  ...FontType,
  ...SymbolType,
  ...SymbolLevel,
  ...PrinterAddPulseDrawerType,
  ...PrinterAddPulseTimeType,
  ...TextAlignType,
  ...PrinterPaperStatus,
  ...PrinterPanelSwitchStatus,
  ...PrinterDrawerStatus,
  ...PrinterErrorStatus,
  ...PrinterAutoRecoverErrorStatus,
  ...PrinterBatteryLevelStatus,
  ...PrinterRemovalWaitingStatus,
  ...PrinterPaperTakenSensorStatus,
  ...PrinterUnrecoverErrorStatus,
  ...TextLangType,
  ...CommonParams,
} as const;

export {
  PrinterModelLang,
  PrinterGetSettingsType,
  GetPrinterSettingsDensityValues,
  GetPrinterSettingsPaperWidthValues,
  GetPrinterSettingsPrintSpeedValues,
  PrinterAddCutType,
  PrinterErrorResult,
  PrinterErrorCodeResult,
  ColorType,
  ImageCompressType,
  ImageHalftoneType,
  ImageColorModeType,
  CommonParams,
  BarcodeType,
  BarcodeHRI,
  FontType,
  SymbolType,
  SymbolLevel,
  PrinterAddPulseDrawerType,
  PrinterAddPulseTimeType,
  TextAlignType,
  PrinterPaperStatus,
  PrinterPanelSwitchStatus,
  PrinterDrawerStatus,
  PrinterErrorStatus,
  PrinterAutoRecoverErrorStatus,
  PrinterBatteryLevelStatus,
  PrinterRemovalWaitingStatus,
  PrinterPaperTakenSensorStatus,
  PrinterUnrecoverErrorStatus,
  TextLangType,
};
