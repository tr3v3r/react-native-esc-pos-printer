# Installation

```sh
npm install react-native-esc-pos-printer
```

or

```sh
yarn add react-native-esc-pos-printer
```

## Android RN >= 0.60

Add the following permissions to `android/app/src/main/AndroidManifest.xml`

```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.BLUETOOTH"/>
<uses-permission android:name="android.permission.BLUETOOTH_ADMIN"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
```

For Android >= 10 add:

```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
```

## iOS RN >= 0.60

```sh
pod install
```

When the Bluetooth or USB is used, set the protocol name. Set the protocol name according to the following procedure:

1. In Project Navigator, select \*.plist. (The file name will be Project name-info.)
2. In the pop-up menu, select Add Row.
3. Select "Supported external accessory protocols".
4. Expand the items added in Step 3.
5. Enter com.epson.escpos as the Value for Item 0.

<img src="../assets/ios-install.png"
     alt="Indoor Building Map Android"
     height="300"
/>
