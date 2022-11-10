# Installation

```sh
npm install react-native-esc-pos-printer
```

or

```sh
yarn add react-native-esc-pos-printer
```

## Android
Add the following permissions to `android/app/src/main/AndroidManifest.xml`
### TCP
When using an application software that runs on Android 4.3.1 or lower, add permissions for the storage shown below.
```xml
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
```
### Wi-Fi
```xml
<uses-permission android:name="android.permission.INTERNET"/>
```
### Bluetooth
For API Level 28 or lower, specify "BLUETOOTH," "BLUETOOTH_ADMIN" and "ACCESS_COARSE_LOCATION."
```xml
<uses-permission android:name="android.permission.BLUETOOTH"/>
<uses-permission android:name="android.permission.BLUETOOTH_ADMIN"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
```
For API Level 29 to 30, specify "BLUETOOTH," "BLUETOOTH_ADMIN" and "ACCESS_FINE_LOCATION."
```xml
<uses-permission android:name="android.permission.BLUETOOTH"/>
<uses-permission android:name="android.permission.BLUETOOTH_ADMIN"/>
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
```
For API Level 31 or higher, specify "BLUETOOTH_SCAN" and "BLUETOOTH_CONNECT."
If the application does not acquire the physical location information, specify neverForLocation for android:usesPermissionFlags.
When acquiring physical location information, specify "ACCESS_FINE_LOCATION."
```xml
<uses-permission android:name="android.permission.BLUETOOTH_SCAN" android:usesPermissionFlags="neverForLocation"/>
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT"/>
```

## iOS

```sh
pod install
```


#### Set the item in the Information Property List.
For iOS13 or later, add Privacy-Bluetooth Always Usage Description.
1. In Project Navigator, select *.plist. (The file name will be Project name-info.)
2. In the pop-up menu, select Add Row.
3. Select "Privacy-Bluetooth Always Usage Description".
4. Enter the intended use of Bluetooth in the "Value" field. (Example: Use this to communicate with the printer.)

<img src="../assets/ios-install-0.png"
     alt="Indoor Building Map Android"
     height="300"
/>

##### When the Bluetooth or USB is used, set the protocol name. Set the protocol name according to the following procedure:

1. In Project Navigator, select *.plist. (The file name will be Project name-info.)
2. In the pop-up menu, select Add Row.
3. Select "Supported external accessory protocols".
4. Expand the items added in Step 3.
5. Enter com.epson.escpos as the Value for Item 0.

<img src="../assets/ios-install.png"
     alt="Indoor Building Map Android"
     height="300"
/>
