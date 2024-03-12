import { NativeModules } from 'react-native';

const { EscPosPrinter } = NativeModules;

const EscPosPrinterConstants: Record<string, number> =
  EscPosPrinter.getConstants();

export enum BarcodeType {
  BARCODE_UPC_A = EscPosPrinterConstants.BARCODE_UPC_A,
  BARCODE_UPC_E = EscPosPrinterConstants.BARCODE_UPC_E,
  BARCODE_EAN13 = EscPosPrinterConstants.BARCODE_EAN13,
  BARCODE_JAN13 = EscPosPrinterConstants.BARCODE_JAN13,
  BARCODE_EAN8 = EscPosPrinterConstants.BARCODE_EAN8,
  BARCODE_JAN8 = EscPosPrinterConstants.BARCODE_JAN8,
  BARCODE_CODE39 = EscPosPrinterConstants.BARCODE_CODE39,
  BARCODE_ITF = EscPosPrinterConstants.BARCODE_ITF,
  BARCODE_CODABAR = EscPosPrinterConstants.BARCODE_CODABAR,
  BARCODE_CODE93 = EscPosPrinterConstants.BARCODE_CODE93,
  BARCODE_CODE128 = EscPosPrinterConstants.BARCODE_CODE128,
  BARCODE_CODE128_AUTO = EscPosPrinterConstants.BARCODE_CODE128_AUTO,
  BARCODE_GS1_128 = EscPosPrinterConstants.BARCODE_GS1_128,
  BARCODE_GS1_DATABAR_OMNIDIRECTIONAL = EscPosPrinterConstants.BARCODE_GS1_DATABAR_OMNIDIRECTIONAL,
  BARCODE_GS1_DATABAR_TRUNCATED = EscPosPrinterConstants.BARCODE_GS1_DATABAR_TRUNCATED,
  BARCODE_GS1_DATABAR_LIMITED = EscPosPrinterConstants.BARCODE_GS1_DATABAR_LIMITED,
  BARCODE_GS1_DATABAR_EXPANDED = EscPosPrinterConstants.BARCODE_GS1_DATABAR_EXPANDED,
}

export enum BarcodeHRI {
  HRI_NONE = EscPosPrinterConstants.HRI_NONE,
  HRI_ABOVE = EscPosPrinterConstants.HRI_ABOVE,
  HRI_BELOW = EscPosPrinterConstants.HRI_BELOW,
  HRI_BOTH = EscPosPrinterConstants.HRI_BOTH,
}
