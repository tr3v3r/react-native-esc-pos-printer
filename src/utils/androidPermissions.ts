import {
  Platform,
  PermissionsAndroid,
  NativeModules,
  NativeEventEmitter,
  EmitterSubscription,
} from 'react-native';
const { EscPosPrinterDiscovery } = NativeModules;
const discoveryEventEmmiter = new NativeEventEmitter(EscPosPrinterDiscovery);

export async function requestAndroidPermissions() {
  const permission =
    Platform.Version >= 28
      ? PermissionsAndroid.PERMISSIONS.ACCESS_FINE_LOCATION
      : PermissionsAndroid.PERMISSIONS.ACCESS_COARSE_LOCATION;

  let granted = await PermissionsAndroid.check(permission);

  if (!granted) {
    const status = await PermissionsAndroid.request(permission, {
      title: 'App Bluetooth Permission',
      message: 'Searching for printers needs access to your bluetooth',
      buttonNeutral: 'Ask Me Later',
      buttonNegative: 'Cancel',
      buttonPositive: 'OK',
    });

    granted = status === PermissionsAndroid.RESULTS.GRANTED;
  }
  console.log('requestAndroidPermissions', granted);
  return granted;
}

export function enableLocationAccessAndroid10() {
  if (Platform.Version >= 28) {
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
          console.log('enableLocationSetting', true);
          removeListeners();
          res(true);
        }
      );

      errorListener = discoveryEventEmmiter.addListener(
        'enableLocationSettingFailure',
        () => {
          console.log('enableLocationSetting', false);
          removeListeners();
          rej(false);
        }
      );

      EscPosPrinterDiscovery.enableLocationSetting().then(() => {
        removeListeners();
        console.log('enableLocationSetting', true);
        res(true);
      });
    });
  }

  return Promise.resolve(true);
}
