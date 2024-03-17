import PQueue from 'p-queue/dist';
import { Platform } from 'react-native';
import { PrinterWrapper } from './PrinterWrapper';
import { PrinterGetSettingsType, PrinterModelLang } from './constants';
import type {
    AddBarcodeParams,
    AddCutTypeParam,
    AddImageParams,
    AddPulseParams,
    AddSymbolParams,
    AddTextAlignParam,
    AddTextLangParam,
    AddTextSizeParams,
    AddTextSmoothParam,
    AddTextStyleParams,
    PrinterParams,
} from './types';

export class Printer {
  private static instances: Map<string, Printer> = new Map();

  public readonly deviceName: string;
  private lang: PrinterModelLang;
  private printerWrapper: PrinterWrapper;

  public queue: PQueue;

  constructor({
    target,
    deviceName,
    lang = PrinterModelLang.MODEL_ANK,
  }: PrinterParams) {
    if (Printer.instances.has(target)) {
      return Printer.instances.get(target);
    }

    this.deviceName = deviceName;
    this.lang = lang;
    this.printerWrapper = new PrinterWrapper(target);
    this.queue = new PQueue({ concurrency: 1 });

    Printer.instances.set(target, this);
  }

  get currentFontWidth() {
    return this.printerWrapper.currentFontWidth;
  }

  init = () => {
    return this.printerWrapper.init({
      deviceName: this.deviceName,
      lang: this.lang,
    });
  };

  connect = async (timeout?: number) => {
    await this.init();
    return this.printerWrapper.connect(timeout);
  };

  disconnect = () => {
    return this.printerWrapper.disconnect();
  };

  addText = (data: string) => {
    return this.printerWrapper.addText(data);
  };

  addFeedLine = (line?: number) => {
    return this.printerWrapper.addFeedLine(line);
  };

  sendData = (timeout?: number) => {
    return this.printerWrapper.sendData(timeout);
  };

  addCut = (type?: AddCutTypeParam) => {
    return this.printerWrapper.addCut(type);
  };

  getPrinterSetting = (type: PrinterGetSettingsType, timeout?: number) => {
    return this.printerWrapper.getPrinterSetting(type, timeout);
  };

  getStatus = () => {
    return this.printerWrapper.getStatus();
  };

  addImage = (params: AddImageParams) => {
    return this.printerWrapper.addImage(params);
  };

  addBarcode = (params: AddBarcodeParams) => {
    return this.printerWrapper.addBarcode(params);
  };

  addSymbol = (params: AddSymbolParams) => {
    return this.printerWrapper.addSymbol(params);
  };

  addCommand = (uint8Array: Uint8Array) => {
    return this.printerWrapper.addCommand(uint8Array);
  };

  addPulse = (params: AddPulseParams) => {
    return this.printerWrapper.addPulse(params);
  };

  addTextAlign = (params?: AddTextAlignParam) => {
    return this.printerWrapper.addTextAlign(params);
  };

  addTextSize = async (params?: AddTextSizeParams) => {
    await this.printerWrapper.addTextSize(params);
  };

  addTextSmooth = (smooth?: AddTextSmoothParam) => {
    return this.printerWrapper.addTextSmooth(smooth);
  };

  addTextStyle = (params?: AddTextStyleParams) => {
    return this.printerWrapper.addTextStyle(params);
  };

  pairBluetoothDevice = (macAddress: string) => {
    if (Platform.OS === 'ios') {
      return this.printerWrapper.pairBluetoothDevice(macAddress);
    }

    return Promise.resolve();
  };

  addTextLang = (lang: AddTextLangParam) => {
    return this.printerWrapper.addTextLang(lang);
  };

  /**
   * Forcefully Clears the command buffer of the printer
   * Caution ☢️: Use this method if disconnecting the printer is not an option.
   * 
   * Disconnecting will automatically clear the command buffer.
  */
  clearCommandBuffer = () => {
    return this.printerWrapper.clearCommandBuffer();
  }
}
