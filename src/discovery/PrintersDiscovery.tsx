import { NativeEventEmitter, NativeModules, Platform } from 'react-native';

import {
  PrinterDiscoveryError,
  enableLocationAccessAndroid10,
  requestAndroidPermissions,
} from '../core';
import type {
  DiscoveryStartParams,
  DeviceInfo,
  DiscoveryStatus,
  RawDeviceInfo,
} from './types';
import {
  DEFAULT_DISCOVERY_TIMEOUT,
  DiscoveryErrorResult,
  DiscoveryDeviceTypeMapping,
  PrinterPairBluetoothErrorMessageMapping,
  PrinterPairBluetoothErrorStatusMapping,
} from './constants';
import { getProcessedError } from './utils';

const { EscPosPrinterDiscovery } = NativeModules;
const discoveryEventEmmiter = new NativeEventEmitter(EscPosPrinterDiscovery);

class PrintersDiscoveryClass {
  timeout: ReturnType<typeof setTimeout> | null = null;
  status: DiscoveryStatus = 'inactive';
  statusListeners: ((status: DiscoveryStatus) => void)[] = [];
  errorListeners: ((error: PrinterDiscoveryError) => void)[] = [];

  public start = async ({
    timeout = DEFAULT_DISCOVERY_TIMEOUT,
    autoStop = true,
    filterOption = {},
  }: DiscoveryStartParams = {}) => {
    try {
      if (this.status === 'discovering') return;

      if (
        (Platform.OS === 'android' && !(await requestAndroidPermissions())) ||
        !(await enableLocationAccessAndroid10())
      ) {
        this.triggerError(
          'PrintersDiscovery.start',
          new Error(String(DiscoveryErrorResult.PERMISSION_ERROR))
        );
        return;
      }

      this.setStatus('discovering');

      await EscPosPrinterDiscovery.startDiscovery(filterOption);

      if (autoStop) {
        this.stopAfterDelay(timeout);
      }
    } catch (error) {
      this.setStatus('inactive');
      this.triggerError('start', error as Error);
    }
  };

  public stop = async () => {
    try {
      if (this.status === 'inactive') return;
      this.clearTimeout();

      await EscPosPrinterDiscovery.stopDiscovery();

      this.setStatus('inactive');
    } catch (error) {
      this.triggerError('stop', error as Error);
    }
  };

  private stopAfterDelay = (timeout: number) => {
    this.timeout = setTimeout(() => {
      this.timeout = null;
      this.stop();
    }, timeout);
  };

  private clearTimeout = () => {
    if (this.timeout) {
      clearTimeout(this.timeout);
      this.timeout = null;
    }
  };

  public onStatusChange = (callback: (status: DiscoveryStatus) => void) => {
    this.statusListeners.push(callback);

    return () => {
      this.statusListeners = this.statusListeners.filter(
        (listener) => listener !== callback
      );
    };
  };

  public onError = (callback: (error: PrinterDiscoveryError) => void) => {
    this.errorListeners.push(callback);

    return () => {
      this.errorListeners = this.errorListeners.filter(
        (listener) => listener !== callback
      );
    };
  };

  public onDiscovery = (callback: (printers: DeviceInfo[]) => void) => {
    const listener = discoveryEventEmmiter.addListener(
      'onDiscovery',
      (printer: RawDeviceInfo[]) => {
        callback(
          printer.map((info) => ({
            ...info,
            deviceType: DiscoveryDeviceTypeMapping[info.deviceType]!,
          }))
        );
      }
    );

    return () => {
      listener.remove();
    };
  };

  pairBluetoothDevice = async (macAddress?: string) => {
    if (Platform.OS === 'ios') {
      try {
        await EscPosPrinterDiscovery.pairBluetoothDevice(macAddress || '');
      } catch (error) {
        throw getProcessedError({
          methodName: 'pairBluetoothDevice',
          errorCode: error.message,
          messagesMapping: PrinterPairBluetoothErrorMessageMapping,
          statusMapping: PrinterPairBluetoothErrorStatusMapping,
        });
      }
    } else {
      return Promise.resolve();
    }
  };

  private triggerError = (methodName: string, error: Error) => {
    const processedError = getProcessedError({
      methodName,
      errorCode: error.message,
    });

    this.errorListeners.forEach((listener) => listener(processedError));
  };

  private triggerStatusChange = (status: DiscoveryStatus) => {
    this.statusListeners.forEach((listener) => listener(status));
  };

  private setStatus = (status: DiscoveryStatus) => {
    this.status = status;
    this.triggerStatusChange(status);
  };
}

function initPrintersClass() {
  return new PrintersDiscoveryClass();
}

export const PrintersDiscovery = initPrintersClass();
