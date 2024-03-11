import { Image, NativeModules } from 'react-native';
import {
  InitPrinterErrorMessageMapping,
  ConnectPrinterErrorMessageMapping,
  DisconnectPrinterErrorMessageMapping,
  CommonOperationErrorMessageMapping,
  SendDataPrinterErrorMessageMapping,
  PrinterGetSettingsType,
  PrintErrorCodeMessageMapping,
  PrinterErrorStatusMapping,
  PrinterErrorCodeStatusMapping,
  PrinterConstants,
} from './constants';
import type {
  AddBarcodeParams,
  AddCutTypeParam,
  AddImageParams,
  AddSymbolParams,
  PrinterInitParams,
  AddPulseParams,
  AddTextAlignParam,
  AddTextSizeParams,
  AddTextSmoothParam,
  AddTextStyleParams,
} from './types';
import {
  throwProcessedError,
  parsePrinterSettings,
  processComplextError,
} from './utils';
import { parsePrinterStatus } from './utils/parsePrinterStatus';
import { BufferHelper } from '../utils';

const { EscPosPrinter } = NativeModules;

export class PrinterWrapper {
  private target: string;

  constructor(target: string) {
    this.target = target;
  }

  init = async ({ deviceName, lang }: PrinterInitParams) => {
    try {
      await EscPosPrinter.initWithPrinterDeviceName(
        this.target,
        deviceName,
        lang
      );
    } catch (error) {
      throwProcessedError({
        methodName: 'init',
        errorCode: error.message,
        messagesMapping: InitPrinterErrorMessageMapping,
      });
    }
  };

  connect = async (timeout: number = 15000) => {
    try {
      await EscPosPrinter.connect(this.target, timeout);
    } catch (error) {
      throwProcessedError({
        methodName: 'connect',
        errorCode: error.message,
        messagesMapping: ConnectPrinterErrorMessageMapping,
      });
    }
  };

  disconnect = async () => {
    try {
      await EscPosPrinter.disconnect(this.target);
    } catch (error) {
      throwProcessedError({
        methodName: 'disconnect',
        errorCode: error.message,
        messagesMapping: DisconnectPrinterErrorMessageMapping,
      });
    }
  };

  addText = async (data: string) => {
    try {
      await EscPosPrinter.addText(this.target, data);
    } catch (error) {
      throwProcessedError({
        methodName: 'addText',
        errorCode: error.message,
        messagesMapping: CommonOperationErrorMessageMapping,
      });
    }
  };

  addFeedLine = async (line: number = 1) => {
    try {
      await EscPosPrinter.addFeedLine(this.target, line);
    } catch (error) {
      throwProcessedError({
        methodName: 'addFeedLine',
        errorCode: error.message,
        messagesMapping: CommonOperationErrorMessageMapping,
      });
    }
  };

  addCut = async (type: AddCutTypeParam = PrinterConstants.PARAM_DEFAULT) => {
    try {
      await EscPosPrinter.addCut(this.target, type);
    } catch (error) {
      throwProcessedError({
        methodName: 'addCut',
        errorCode: error.message,
        messagesMapping: CommonOperationErrorMessageMapping,
      });
    }
  };

  sendData = async (timeout: number = 5000) => {
    try {
      const result = await EscPosPrinter.sendData(this.target, timeout);
      return parsePrinterStatus(result);
    } catch (error) {
      const { errorType, data } = processComplextError(error.message);

      throwProcessedError({
        methodName: 'sendData',
        errorCode: data,
        messagesMapping:
          errorType === 'code'
            ? PrintErrorCodeMessageMapping
            : SendDataPrinterErrorMessageMapping,
        statusMapping:
          errorType === 'code'
            ? PrinterErrorCodeStatusMapping
            : PrinterErrorStatusMapping,
      });
    }
  };

  getPrinterSetting = async (
    type: PrinterGetSettingsType,
    timeout: number = 10000
  ) => {
    try {
      const result = await EscPosPrinter.getPrinterSetting(
        this.target,
        timeout,
        type
      );

      return parsePrinterSettings(result);
    } catch (error) {
      const { errorType, data } = processComplextError(error.message);

      throwProcessedError({
        methodName: 'getPrinterSetting',
        errorCode: data,
        messagesMapping:
          errorType === 'code'
            ? PrintErrorCodeMessageMapping
            : CommonOperationErrorMessageMapping,
        statusMapping:
          errorType === 'code'
            ? PrinterErrorCodeStatusMapping
            : PrinterErrorStatusMapping,
      });
    }
  };

  getStatus = async () => {
    try {
      const result = await EscPosPrinter.getStatus(this.target);
      return parsePrinterStatus(result);
    } catch (error) {
      throwProcessedError({
        methodName: 'getStatus',
        errorCode: error.message,
        messagesMapping: CommonOperationErrorMessageMapping,
      });
    }
  };

  addImage = async ({
    source,
    width,
    color = PrinterConstants.PARAM_DEFAULT,
    mode = PrinterConstants.PARAM_DEFAULT,
    halftone = PrinterConstants.PARAM_DEFAULT,
    brightness = PrinterConstants.PARAM_DEFAULT,
    compress = PrinterConstants.PARAM_DEFAULT,
  }: AddImageParams) => {
    try {
      const resolvedSource = Image.resolveAssetSource(source);
      await EscPosPrinter.addImage(
        this.target,
        resolvedSource,
        width,
        color,
        mode,
        halftone,
        brightness,
        compress
      );
    } catch (error) {
      throwProcessedError({
        methodName: 'addImage',
        errorCode: error.message,
        messagesMapping: CommonOperationErrorMessageMapping,
      });
    }
  };

  addBarcode = async ({
    data,
    type,
    hri = PrinterConstants.PARAM_DEFAULT,
    font = PrinterConstants.PARAM_DEFAULT,
    width = PrinterConstants.PARAM_UNSPECIFIED,
    height = PrinterConstants.PARAM_UNSPECIFIED,
  }: AddBarcodeParams) => {
    try {
      await EscPosPrinter.addBarcode(
        this.target,
        data,
        type,
        hri,
        font,
        width,
        height
      );
    } catch (error) {
      throwProcessedError({
        methodName: 'addBarcode',
        errorCode: error.message,
        messagesMapping: CommonOperationErrorMessageMapping,
      });
    }
  };

  addSymbol = async ({
    data,
    type,
    level = PrinterConstants.PARAM_DEFAULT,
    width,
    height,
    size,
  }: AddSymbolParams) => {
    try {
      await EscPosPrinter.addSymbol(
        this.target,
        data,
        type,
        level,
        width,
        height,
        size
      );
    } catch (error) {
      throwProcessedError({
        methodName: 'addSymbol',
        errorCode: error.message,
        messagesMapping: CommonOperationErrorMessageMapping,
      });
    }
  };

  addCommand = async (uint8Array: Uint8Array) => {
    try {
      const buffer = new BufferHelper();
      const base64String = buffer.bytesToString(uint8Array, 'base64');
      await EscPosPrinter.addCommand(this.target, base64String);
    } catch (error) {
      throwProcessedError({
        methodName: 'addCommand',
        errorCode: error.message,
        messagesMapping: CommonOperationErrorMessageMapping,
      });
    }
  };

  addPulse = async ({
    drawer = PrinterConstants.PARAM_DEFAULT,
    time = PrinterConstants.PARAM_DEFAULT,
  }: AddPulseParams = {}) => {
    try {
      await EscPosPrinter.addPulse(this.target, drawer, time);
    } catch (error) {
      throwProcessedError({
        methodName: 'addPulse',
        errorCode: error.message,
        messagesMapping: CommonOperationErrorMessageMapping,
      });
    }
  };

  addTextAlign = async (
    align: AddTextAlignParam = PrinterConstants.PARAM_DEFAULT
  ) => {
    try {
      await EscPosPrinter.addTextAlign(this.target, align);
    } catch (error) {
      throwProcessedError({
        methodName: 'addTextAlign',
        errorCode: error.message,
        messagesMapping: CommonOperationErrorMessageMapping,
      });
    }
  };

  addTextSize = async ({
    width = PrinterConstants.PARAM_DEFAULT,
    height = PrinterConstants.PARAM_DEFAULT,
  }: AddTextSizeParams = {}) => {
    try {
      await EscPosPrinter.addTextSize(this.target, width, height);
    } catch (error) {
      throwProcessedError({
        methodName: 'addTextSize',
        errorCode: error.message,
        messagesMapping: CommonOperationErrorMessageMapping,
      });
    }
  };

  addTextSmooth = async (
    smooth: AddTextSmoothParam = PrinterConstants.TRUE
  ) => {
    try {
      await EscPosPrinter.addTextSmooth(this.target, smooth);
    } catch (error) {
      throwProcessedError({
        methodName: 'addTextSmooth',
        errorCode: error.message,
        messagesMapping: CommonOperationErrorMessageMapping,
      });
    }
  };

  addTextStyle = async ({
    color = PrinterConstants.PARAM_UNSPECIFIED,
    em = PrinterConstants.PARAM_UNSPECIFIED,
    reverse = PrinterConstants.PARAM_UNSPECIFIED,
    ul = PrinterConstants.PARAM_UNSPECIFIED,
  }: AddTextStyleParams) => {
    try {
      await EscPosPrinter.addTextStyle(this.target, reverse, ul, em, color);
    } catch (error) {
      throwProcessedError({
        methodName: 'addTextStyle',
        errorCode: error.message,
        messagesMapping: CommonOperationErrorMessageMapping,
      });
    }
  };
}
