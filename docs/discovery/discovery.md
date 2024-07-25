# Discovery

Starts searching for the specified device type.
Each device is reported by the callback as it is detected.


### 1. Hook based: [usePrintersDiscovery](./usePrintersDiscovery.md)

`For iOS you must` [pair printer](./usePrintersDiscovery.md#pairbluetoothdevice-ios-only) `with device to search Bluetooth printers`

#### Example

```tsx
import { usePrintersDiscovery } from 'react-native-esc-pos-printer';

const PrintersDiscovering = () => {
const {
    start,
    printerError,
    isDiscovering,
    printers,
  } = usePrintersDiscovery();

  useEffect(() => {
    if (printerError) {
      Snackbar.showError(printerError);
    }
  }, [printerError]);

  return (
    <View>
      <FlatList data={printers} renderItem={renderPrinterItem}>
      <SearchPrinterButton loading={isDiscovering} onPress={start}>
    </View>
  )
}
```

### 2. Class based: [PrintersDiscovery](./PrintersDiscovery.md)

`For iOS you must` [pair printer](./PrintersDiscovery.md#pairbluetoothdevice-ios-only) `with device to search Bluetooth printers`


#### Example

```typescript
import { PrintersDiscovery } from 'react-native-esc-pos-printer';

// add listener
PrintersDiscovery.onDiscovery(printers => {
  console.log(printers);
})

// start discovering
PrintersDiscovery.start()


// handle error
PrintersDiscovery.onError(error => {
  console.log(error);
})

// handle status change
PrintersDiscovery.onStatusChange(status => {
  console.log(status);
})

```


#### Supplementary explanation
Android:
- The search result of this API is reported to the callback function for each device detected.
An already opened device is also reported. However, a USB device and a Bluetooth device are not reported if they have been already opened.
- In search for TCP devices, if multiple devices with the same IP address exist, the device information is treated as a single device. Consistency for such device information is not guaranteed.
- If the printer has its TCP address and TCPS address, and the both are detected, only the TCPS address is reported to the callback function.
- Hybrid model printers can be detected as deviceType of TYPE_PRINTER and TYPE_HYBRID_PRINTER.
- To search for a hybrid model printer connected via USB, specify TYPE_ALL in deviceType.
- After the search begins and the process ends, make sure to end the search.
- This search function is not available in Android Studio simulator.
- When searching for a device running on Android 10 or later as a Bluetooth-capable device, enable access to location information of the device.
- When searching for a device connected to the USB-A - Device Charging connector by using API Level 29 or higher application software, a dialogue box that tells you to acquire access permissions may pop up if USB permission has not been acquired.
- If a USB device is connected while searching the device, the device may not be found. In that case, terminate and restart the search.
- When searching for a Bluetooth-capable device, depending on API Level, the following permissions are necessary.
API Level 28 or lower application software: ACCESS_COARSE_LOCATION
API Level 29 to 30 application software: ACCESS_FINE_LOCATION
API Level 31 or higher application software: ACCESS_FINE_LOCATION (when acquiring physical location information)

iOS:

- The search result of this API is reported to the callback function for each device detected.
An already opened device is also reported. However, an already opened Bluetooth device is not reported.
- In search for TCP devices, if multiple devices with the same IP address exist, the device information is treated as a single device. Consistency for such device information is not guaranteed.
- If the printer has its TCP address and TCPS address, and the both are detected, only the TCPS address is reported to the callback function.
- Hybrid model printers can be detected as deviceType of TYPE_PRINTER and TYPE_HYBRID_PRINTER.
- After the search begins and the process ends, make sure to end the search.
- In iOS14 or later, when a dialog asking permission to access the local network appears after this API is executed, execute stop after permission to access the local network is granted, end the search, and then execute this API again and perform a search.



