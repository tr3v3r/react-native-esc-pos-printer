import { NativeModules } from 'react-native';

const { EscPosPrinter } = NativeModules;

const EscPosPrinterConstants: Record<string, number> =
  EscPosPrinter.getConstants();

export enum PrinterAddPulseDrawerType {
  DRAWER_2PIN = EscPosPrinterConstants.DRAWER_2PIN,
  DRAWER_5PIN = EscPosPrinterConstants.DRAWER_5PIN,
}

export enum PrinterAddPulseTimeType {
  PULSE_100 = EscPosPrinterConstants.PULSE_100,
  PULSE_200 = EscPosPrinterConstants.PULSE_200,
  PULSE_300 = EscPosPrinterConstants.PULSE_300,
  PULSE_400 = EscPosPrinterConstants.PULSE_400,
  PULSE_500 = EscPosPrinterConstants.PULSE_500,
}
