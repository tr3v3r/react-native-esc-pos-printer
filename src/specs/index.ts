import { NativeModules, NativeEventEmitter, Platform } from 'react-native';
import type { Spec as NativeEscPosPrinterSpec } from './NativeEscPosPrinter';
import type { Spec as NativeEscPosPrinterDiscoverySpec } from './NativeEscPosPrinterDiscovery';
const isTurboModuleEnabled =
  !!global.__turboModuleProxy || !!global.RN$Bridgeless;

let EscPosPrinter: NativeEscPosPrinterSpec;
let EscPosPrinterDiscovery: NativeEscPosPrinterDiscoverySpec;

if (isTurboModuleEnabled) {
  EscPosPrinter = require('./NativeEscPosPrinter').default;
  EscPosPrinterDiscovery = require('./NativeEscPosPrinterDiscovery').default;
} else {
  const {
    EscPosPrinterDiscovery: OldArchEscPosPrinterDiscovery,
    EscPosPrinter: OldArchEscPosPrinter,
  } = NativeModules;
  const DiscoveryEventEmitter = new NativeEventEmitter(
    OldArchEscPosPrinterDiscovery
  );

  EscPosPrinterDiscovery = {
    ...NativeModules.EscPosPrinterDiscovery,
    onDiscovery: (callback) => {
      return DiscoveryEventEmitter.addListener('onDiscovery', callback);
    },
    ...(Platform.OS === 'android'
      ? {
          enableLocationSettingSuccess: (callback) => {
            return DiscoveryEventEmitter.addListener(
              'enableLocationSettingSuccess',
              callback
            );
          },
          enableLocationSettingFailure: (callback) => {
            return DiscoveryEventEmitter.addListener(
              'enableLocationSettingFailure',
              callback
            );
          },
        }
      : {}),
  };

  EscPosPrinter = OldArchEscPosPrinter;
}

export { EscPosPrinter, EscPosPrinterDiscovery };
