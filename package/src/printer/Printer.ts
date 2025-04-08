import type PQueueType from 'p-queue';
import { PrinterWrapper } from './PrinterWrapper';
import { PrinterGetSettingsType, PrinterModelLang } from './constants';
import {
  addTextLine,
  addViewShot,
  monitorPrinter,
  tryToConnectUntil,
} from './printHelpers';
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

  public queue: unknown;

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

    this.initQueue();

    Printer.instances.set(target, this);
  }

  initQueue() {
    const PQueue = require('p-queue/dist').default;
    this.queue = new PQueue({ concurrency: 1 });
  }

  addQueueTask<TaskResultType>(
    task: () => Promise<TaskResultType>
  ): Promise<TaskResultType | void> {
    return (this.queue as PQueueType).add(task);
  }

  static addTextLine = addTextLine;
  static monitorPrinter = monitorPrinter;
  static tryToConnectUntil = tryToConnectUntil;
  static addViewShot = addViewShot;

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

  addLineSpace = (linespc: number) => {
    return this.printerWrapper.addLineSpace(linespc);
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

  addTextLang = (lang: AddTextLangParam) => {
    return this.printerWrapper.addTextLang(lang);
  };

  clearCommandBuffer = () => {
    return this.printerWrapper.clearCommandBuffer();
  };
}
