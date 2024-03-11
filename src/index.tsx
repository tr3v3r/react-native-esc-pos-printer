import { NativeModules, NativeEventEmitter, Platform } from 'react-native';

import type { EmitterSubscription } from 'react-native';
import { getPrinterSeriesByName, getPrinterLanguage } from './utils';
import type {
  PrinerEvents,
  EventListenerCallback,
  IPrinter,
  IPrinterInitParams,
  PrinterSeriesName,
  IMonitorStatus,
  IPrinterStatus,
} from './types';
import {
  PRINTER_SERIES,
  FONT_A_CHARS_PER_LINE,
  DEFAULT_FONT_A_CHARS_PER_LINE,
  DEFAULT_PAPER_WIDTH,
  PRINTER_LANGUAGE,
} from './constants';

export * from './discovery';
export * from './printer';

const { EscPosPrinter, ThePrinterWrapper } = NativeModules;

const printEventEmmiter = new NativeEventEmitter(EscPosPrinter);
import printing from './printing';

const _default = {
  init({
    target,
    seriesName,
    language = 'EPOS2_LANG_EN',
  }: IPrinterInitParams): Promise<number> {
    const series = PRINTER_SERIES[seriesName];
    const lang = getPrinterLanguage(language);
    return EscPosPrinter.init(target, series, lang);
  },

  instantiate({
    target,
    seriesName,
    language = 'EPOS2_LANG_EN',
  }: IPrinterInitParams): Promise<number> {
    const series = PRINTER_SERIES[seriesName];
    const lang = getPrinterLanguage(language);
    return ThePrinterWrapper.init(target, series, lang);
  },

  connect(target: string): Promise<number> {
    return ThePrinterWrapper.connect(target);
  },

  disconnectPrinter(target: string): Promise<number> {
    return ThePrinterWrapper.disconnectAndDeallocate(target);
  },

  getPaperWidth(): Promise<80 | 60 | 58> {
    let successListener: EmitterSubscription | null;
    let errorListener: EmitterSubscription | null;

    function removeListeners() {
      successListener?.remove();
      errorListener?.remove();

      successListener = null;
      errorListener = null;
    }

    return new Promise((res, rej) => {
      successListener = printEventEmmiter.addListener(
        'onGetPaperWidthSuccess',
        (status) => {
          removeListeners();
          res(status);
        }
      );

      errorListener = printEventEmmiter.addListener(
        'onGetPaperWidthFailure',
        (status) => {
          removeListeners();
          rej(status);
        }
      );

      EscPosPrinter.getPaperWidth().catch((e: Error) => {
        removeListeners();
        rej(e);
      });
    });
  },

  async getPrinterCharsPerLine(
    seriesName: PrinterSeriesName
  ): Promise<{ fontA: number }> {
    const paperWidth: 80 | 60 | 58 =
      (await this.getPaperWidth()) || DEFAULT_PAPER_WIDTH;

    const key = String(paperWidth) as '80' | '60' | '58';

    const seriesCharsPerLineFontA = FONT_A_CHARS_PER_LINE[seriesName];
    const fontAcplForCurrentWidth = seriesCharsPerLineFontA?.[key];

    return {
      fontA:
        fontAcplForCurrentWidth || DEFAULT_FONT_A_CHARS_PER_LINE[paperWidth],
    };
  },

  pairingBluetoothPrinter(): Promise<string> {
    if (Platform.OS === 'ios') {
      return EscPosPrinter.pairingBluetoothPrinter();
    }
    return Promise.resolve('Successs');
  },

  disconnect() {
    EscPosPrinter.disconnect();
  },

  getPrinterStatus(): Promise<IPrinterStatus> {
    return EscPosPrinter.getPrinterStatus();
  },

  startMonitorPrinter(interval: number = 5) {
    return EscPosPrinter.startMonitorPrinter(Math.max(5, Math.floor(interval)));
  },

  stopMonitorPrinter() {
    return EscPosPrinter.stopMonitorPrinter();
  },

  addPrinterStatusListener(listener: (status: IMonitorStatus) => void) {
    const statusListener = printEventEmmiter.addListener(
      'onMonitorStatusUpdate',
      listener
    );

    return () => {
      statusListener.remove();
    };
  },
  printing,
};

export { getPrinterSeriesByName, PRINTER_SERIES, PRINTER_LANGUAGE };
export type {
  PrinerEvents,
  EventListenerCallback,
  IPrinter,
  PrinterSeriesName,
  IPrinterStatus,
};

export default _default;
