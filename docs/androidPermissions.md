# Android Permissions

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
