import { NativeModules } from 'react-native';

const { EscPosPrinter } = NativeModules;

const EscPosPrinterConstants: Record<string, number> =
  EscPosPrinter.getConstants();

export enum SymbolType {
  SYMBOL_PDF417_STANDARD = EscPosPrinterConstants.SYMBOL_PDF417_STANDARD,
  SYMBOL_PDF417_TRUNCATED = EscPosPrinterConstants.SYMBOL_PDF417_TRUNCATED,
  SYMBOL_QRCODE_MODEL_1 = EscPosPrinterConstants.SYMBOL_QRCODE_MODEL_1,
  SYMBOL_QRCODE_MODEL_2 = EscPosPrinterConstants.SYMBOL_QRCODE_MODEL_2,
  SYMBOL_QRCODE_MICRO = EscPosPrinterConstants.SYMBOL_QRCODE_MICRO,
  SYMBOL_MAXICODE_MODE_2 = EscPosPrinterConstants.SYMBOL_MAXICODE_MODE_2,
  SYMBOL_MAXICODE_MODE_3 = EscPosPrinterConstants.SYMBOL_MAXICODE_MODE_3,
  SYMBOL_MAXICODE_MODE_4 = EscPosPrinterConstants.SYMBOL_MAXICODE_MODE_4,
  SYMBOL_MAXICODE_MODE_5 = EscPosPrinterConstants.SYMBOL_MAXICODE_MODE_5,
  SYMBOL_MAXICODE_MODE_6 = EscPosPrinterConstants.SYMBOL_MAXICODE_MODE_6,
  SYMBOL_GS1_DATABAR_STACKED = EscPosPrinterConstants.SYMBOL_GS1_DATABAR_STACKED,
  SYMBOL_GS1_DATABAR_STACKED_OMNIDIRECTIONAL = EscPosPrinterConstants.SYMBOL_GS1_DATABAR_STACKED_OMNIDIRECTIONAL,
  SYMBOL_GS1_DATABAR_EXPANDED_STACKED = EscPosPrinterConstants.SYMBOL_GS1_DATABAR_EXPANDED_STACKED,
  SYMBOL_AZTECCODE_FULLRANGE = EscPosPrinterConstants.SYMBOL_AZTECCODE_FULLRANGE,
  SYMBOL_AZTECCODE_COMPACT = EscPosPrinterConstants.SYMBOL_AZTECCODE_COMPACT,
  SYMBOL_DATAMATRIX_SQUARE = EscPosPrinterConstants.SYMBOL_DATAMATRIX_SQUARE,
  SYMBOL_DATAMATRIX_RECTANGLE_8 = EscPosPrinterConstants.SYMBOL_DATAMATRIX_RECTANGLE_8,
  SYMBOL_DATAMATRIX_RECTANGLE_12 = EscPosPrinterConstants.SYMBOL_DATAMATRIX_RECTANGLE_12,
  SYMBOL_DATAMATRIX_RECTANGLE_16 = EscPosPrinterConstants.SYMBOL_DATAMATRIX_RECTANGLE_16,
}

export enum SymbolLevel {
  LEVEL_0 = EscPosPrinterConstants.LEVEL_0,
  LEVEL_1 = EscPosPrinterConstants.LEVEL_1,
  LEVEL_2 = EscPosPrinterConstants.LEVEL_2,
  LEVEL_3 = EscPosPrinterConstants.LEVEL_3,
  LEVEL_4 = EscPosPrinterConstants.LEVEL_4,
  LEVEL_5 = EscPosPrinterConstants.LEVEL_5,
  LEVEL_6 = EscPosPrinterConstants.LEVEL_6,
  LEVEL_7 = EscPosPrinterConstants.LEVEL_7,
  LEVEL_8 = EscPosPrinterConstants.LEVEL_8,
  LEVEL_L = EscPosPrinterConstants.LEVEL_L,
  LEVEL_M = EscPosPrinterConstants.LEVEL_M,
  LEVEL_Q = EscPosPrinterConstants.LEVEL_Q,
  LEVEL_H = EscPosPrinterConstants.LEVEL_H,
}
