# Installation

```sh
npx expo install react-native-esc-pos-printer
npx expo prebuild
```

Modify `app.json`:

### Android
```JSON
{
  "android": {
    "permissions": [
     "android.permission.INTERNET",
     "android.permission.BLUETOOTH_SCAN",
     "android.permission.BLUETOOTH_CONNECT",
     "android.permission.BLUETOOTH",
     "android.permission.BLUETOOTH_ADMIN",
     "android.permission.ACCESS_FINE_LOCATION",
     "android.permission.ACCESS_COARSE_LOCATION",
     "android.permission.WRITE_EXTERNAL_STORAGE",
     "android.permission.READ_EXTERNAL_STORAGE"
     ]
  }
}
```

See explanation of permissions [here](./androidPermissions.md)

### iOS

```JSON
{
  "ios": {
    "infoPlist": {
      // Set the item in the Information Property List.
      "NSBluetoothAlwaysUsageDescription": "Use this to communicate with the printer.",
      // When the Bluetooth or USB is used, set the protocol name. Set the protocol name according to the following procedure:
      "UISupportedExternalAccessoryProtocols": ["com.epson.escpos"]
    }
  }
}
```
