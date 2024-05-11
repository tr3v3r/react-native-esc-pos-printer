import {
  NativeEventEmitter,
  NativeModules,
  PermissionsAndroid,
  Platform,
} from 'react-native';

import type { EmitterSubscription, Permission } from 'react-native';
const { EscPosPrinterDiscovery } = NativeModules;
const discoveryEventEmmiter = new NativeEventEmitter(EscPosPrinterDiscovery);
const platformVersion = Platform.Version as number;
export async function requestAndroidPermissions(): Promise<boolean> {
  if (platformVersion < 23) return true;

  let permissions: Permission[] = [];

  if (platformVersion >= 31) {
    const permissionBluetoothScanGranted = await PermissionsAndroid.check(
      PermissionsAndroid.PERMISSIONS.BLUETOOTH_SCAN
    );

    const permissionBluetoothConnectGranted = await PermissionsAndroid.check(
      PermissionsAndroid.PERMISSIONS.BLUETOOTH_CONNECT
    );

    if (!permissionBluetoothScanGranted) {
      permissions.push(PermissionsAndroid.PERMISSIONS.BLUETOOTH_SCAN);
    }

    if (!permissionBluetoothConnectGranted) {
      permissions.push(PermissionsAndroid.PERMISSIONS.BLUETOOTH_CONNECT);
    }
  } else if (platformVersion >= 29 && platformVersion <= 30) {
    const permissionFineLocationGranted = await PermissionsAndroid.check(
      PermissionsAndroid.PERMISSIONS.ACCESS_FINE_LOCATION
    );

    if (!permissionFineLocationGranted) {
      permissions.push(PermissionsAndroid.PERMISSIONS.ACCESS_FINE_LOCATION);
    }
  } else {
    const permissionCoarseLocationGranted = await PermissionsAndroid.check(
      PermissionsAndroid.PERMISSIONS.ACCESS_COARSE_LOCATION
    );

    if (!permissionCoarseLocationGranted) {
      permissions.push(PermissionsAndroid.PERMISSIONS.ACCESS_COARSE_LOCATION);
    }
  }

  if (permissions.length > 0) {
    const status = await PermissionsAndroid.requestMultiple(permissions);
    return Object.keys(status ?? {}).every(
      (key) => status[key as Permission] === PermissionsAndroid.RESULTS.GRANTED
    );
  }

  return true;
}

export function enableLocationAccessAndroid10() {
  if (platformVersion > 28) {
    let successListener: EmitterSubscription | null;
    let errorListener: EmitterSubscription | null;

    function removeListeners() {
      successListener?.remove();
      errorListener?.remove();

      successListener = null;
      errorListener = null;
    }

    return new Promise((res, rej) => {
      successListener = discoveryEventEmmiter.addListener(
        'enableLocationSettingSuccess',
        () => {
          removeListeners();
          res(true);
        }
      );

      errorListener = discoveryEventEmmiter.addListener(
        'enableLocationSettingFailure',
        () => {
          removeListeners();
          rej(false);
        }
      );

      EscPosPrinterDiscovery.enableLocationSetting().then(() => {
        removeListeners();
        res(true);
      });
    });
  }

  return Promise.resolve(true);
}
