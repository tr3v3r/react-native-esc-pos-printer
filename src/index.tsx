import { NativeModules } from 'react-native';

type EscPosPrinterType = {
  multiply(a: number, b: number): Promise<number>;
  initLANprinter(ip: string): Promise<string>;
  printText(text: string): Promise<string>;
};

const { EscPosPrinter } = NativeModules;

export default EscPosPrinter as EscPosPrinterType;
