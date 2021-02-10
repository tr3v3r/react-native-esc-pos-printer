import {
  NativeModules,
  NativeEventEmitter,
  EmitterSubscription,
} from 'react-native';
import { BufferHelper } from './utils';
import type { PrinerEvents, EventListenerCallback, IPrinter } from './types';

const { EscPosPrinter, EscPosPrinterDiscovery } = NativeModules;

const discoveryEventEmmiter = new NativeEventEmitter(EscPosPrinterDiscovery);
const printEventEmmiter = new NativeEventEmitter(EscPosPrinter);

const _default = {
  initLANprinter(ip: string): Promise<number> {
    return EscPosPrinter.initLANprinter(ip);
  },
  initBTprinter(address: string): Promise<number> {
    return EscPosPrinter.initLANprinter(address);
  },
  discover(): Promise<IPrinter[]> {
    return new Promise((res, rej) => {
      const listener = discoveryEventEmmiter.addListener(
        'onDiscoveryDone',
        (printers: IPrinter[]) => {
          res(printers);
          listener.remove();
        }
      );

      EscPosPrinterDiscovery.discover().catch((e: Error) => {
        listener.remove();
        rej(e);
      });
    });
  },
  printRawData(uint8Array: Uint8Array): Promise<string> {
    const buffer = new BufferHelper();
    const base64String = buffer.bytesToString(uint8Array, 'base64');

    let successListener: EmitterSubscription;
    let errorListener: EmitterSubscription;

    function removeListeners() {
      successListener?.remove();
      errorListener?.remove();
    }

    return new Promise((res, rej) => {
      successListener = printEventEmmiter.addListener(
        'onPrintSuccess',
        (status) => {
          removeListeners();
          res(status);
        }
      );

      errorListener = printEventEmmiter.addListener(
        'onPrintFailure',
        (status) => {
          removeListeners();
          rej(status);
        }
      );

      EscPosPrinter.printBase64(base64String).catch((e: Error) => {
        removeListeners();
        rej(e);
      });
    });
  },

  disconnect() {
    EscPosPrinter.disconnect();
  },
};
export type { PrinerEvents, EventListenerCallback, IPrinter };

export default _default;
