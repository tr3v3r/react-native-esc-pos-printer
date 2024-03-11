import {
  PrinterAddCutType,
  PrinterErrorResult,
  PrinterErrorCodeResult,
  PrinterModelLang,
  CommonParams,
  ColorType,
} from './common';

import {
  PrinterGetSettingsType,
  GetPrinterSettingsDensityValues,
  GetPrinterSettingsPaperWidthValues,
  GetPrinterSettingsPrintSpeedValues,
} from './settings';

export * from './status';
import {
  ImageCompressType,
  ImageHalftoneType,
  ImageColorModeType,
} from './image';

import { BarcodeType, BarcodeHRI } from './barcode';
import { SymbolType, SymbolLevel } from './symbol';
import {
  FontType,
  TextAlignType,
  TextReverseType,
  TextUnderscoreType,
  TextBoldType,
} from './textStyle';
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
  ...TextReverseType,
  ...TextUnderscoreType,
  ...TextBoldType,
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
  TextReverseType,
  TextUnderscoreType,
  TextBoldType,
};
