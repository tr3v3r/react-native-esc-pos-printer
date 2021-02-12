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
    return EscPosPrinter.initBTprinter(address);
  },
  discover(): Promise<IPrinter[]> {
    return new Promise((res, rej) => {
      let listener: EmitterSubscription | null;
      function removeListener() {
        listener?.remove();
        listener = null;
      }
      listener = discoveryEventEmmiter.addListener(
        'onDiscoveryDone',
        (printers: IPrinter[]) => {
          res(printers);
          removeListener();
        }
      );

      EscPosPrinterDiscovery.discover()
        .then(() => {
          removeListener();
          res([]);
        })
        .catch((e: Error) => {
          removeListener();
          rej(e);
        });
    });
  },
  printRawData(uint8Array: Uint8Array): Promise<string> {
    const buffer = new BufferHelper();
    const base64String = buffer.bytesToString(uint8Array, 'base64');

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
