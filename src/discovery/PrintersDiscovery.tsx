import { NativeEventEmitter, NativeModules, Platform } from 'react-native';

import {
  PrinterDiscoveryError,
  enableLocationAccessAndroid10,
  requestAndroidPermissions,
} from '../core';
import type {
  DiscoveryStartParams,
  DeficeInfo,
  DiscoveryStatus,
  RawDeviceInfo,
} from './types';
import {
  DEFAULT_DISCOVERY_TIMEOUT,
  DiscoveryErrorMessageMapping,
  DiscoveryErrorStatusMapping,
  DiscoveryErrorResult,
  DiscoveryDeviceTypeMapping,
} from './constants';

const { EscPosPrinterDiscovery } = NativeModules;
const discoveryEventEmmiter = new NativeEventEmitter(EscPosPrinterDiscovery);

export const PrintersDiscovery = new (class PrintersDiscovery {
  timeout: ReturnType<typeof setTimeout> | null = null;
  status: DiscoveryStatus = 'inactive';
  statusListeners: ((status: DiscoveryStatus) => void)[] = [];
  errorListeners: ((error: PrinterDiscoveryError) => void)[] = [];

  public start = async ({
    timeout = DEFAULT_DISCOVERY_TIMEOUT,
    autoStop = true,
    filterOption,
  }: DiscoveryStartParams = {}) => {
    try {
      if (this.status === 'discovering') return;

      if (
        Platform.OS === 'android' ||
        !(await requestAndroidPermissions()) ||
        !(await enableLocationAccessAndroid10())
      ) {
        this.triggerError(
          'PrintersDiscovery.start',
          DiscoveryErrorResult.PERMISSION_ERROR
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
      this.triggerError('PrintersDiscovery.start', error as number | Error);
    }
  };

  public stop = async () => {
    try {
      if (this.status === 'inactive') return;
      this.clearTimeout();

      await EscPosPrinterDiscovery.stopDiscovery();

      this.setStatus('inactive');
    } catch (error) {
      this.triggerError('PrintersDiscovery.stop', error as number | Error);
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

  public onDiscovery = (callback: (printers: DeficeInfo[]) => void) => {
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

  private triggerError = (methodName: string, error: number | Error) => {
    const result =
      typeof error === 'number'
        ? (error as DiscoveryErrorResult)
        : DiscoveryErrorResult.ERR_FAILURE;

    const message = `${methodName}: ${DiscoveryErrorMessageMapping[result]}`;
    const status = DiscoveryErrorStatusMapping[result]!;

    const discoveryError = new PrinterDiscoveryError({
      status: status,
      message: message,
    });
    this.errorListeners.forEach((listener) => listener(discoveryError));
  };

  private triggerStatusChange = (status: DiscoveryStatus) => {
    this.statusListeners.forEach((listener) => listener(status));
  };

  private setStatus = (status: DiscoveryStatus) => {
    this.status = status;
    this.triggerStatusChange(status);
  };
})();
