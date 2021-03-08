# EPSON ePOS SDK for React Native

_An unofficial React Native library for printing on an EPSON TM printer with the [Epson ePOS SDK for iOS](https://download.epson-biz.com/modules/pos/index.php?page=single_soft&cid=6621) and [Epson ePOS SDK for Android](https://download.epson-biz.com/modules/pos/index.php?page=single_soft&cid=6622)_

## Installation

```sh
npm install react-native-esc-pos-printer
```
or
```sh
yarn add react-native-esc-pos-printer
```

### Android RN >= 0.60

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

### iOS RN >= 0.60

```sh
pod install
```

When the Bluetooth or USB is used, set the protocol name. Set the protocol name according to the following procedure:
1. In Project Navigator, select *.plist. (The file name will be Project name-info.)
2. In the pop-up menu, select Add Row.
3. Select "Supported external accessory protocols".
4. Expand the items added in Step 3.
5. Enter com.epson.escpos as the Value for Item 0.

<img src="./assets/ios-install.png"
     alt="Indoor Building Map Android"
     height="300"
/>

## API

#### init({ target, seriesName })

Initializes printer using it's target and series name.

##### arguments
| Name | Type | Required | Description  |
| ---- | :--: | :------: | :----------: |
| `target` | `string` | `Yes` | The connection target of a device which can be specified by connectAPI: ("TCP:192.168.192.168"  "BT:00:22:15:7D:70:9C"  "USB:000000000000000000") |
| `seriesName` | `string` | `Yes` | Specifies the target printer model. |


```javascript
import EscPosPrinter from "react-native-esc-pos-printer"

EscPosPrinter.init({ target:  "TCP:192.168.192.168", seriesName: "EPOS2_TM_M10"  })
.then(() => console.log("Init success!"))
.catch((e) => console.log("Init error:", e.message))

```

#### discover()

`For iOS you must pair printer with device to search Bluetooth printers`

Starts searching for device.
Returns list of printers.

##### return type
```typescript
interface IPrinter {
  name: string;
  ip: string;
  mac: string;
  target: string;
  bt: string;
  usb: string;
}
```

```javascript
import EscPosPrinter from "react-native-esc-pos-printer"

EscPosPrinter.discovery()
.then((printers) => {
  console.log(printers[0])
  /*
    {
      name: "TM_M10",
      ip: "192.168.192.168" or "",
      mac: "12:34:56:78:56:78" or "",
      target: "TCP:192.168.192.168" or "BT:00:22:15:7D:70:9C" or "USB:000000000000000000",
      bt: "12:34:56:78:56:78" or "",
      usb: "000000000000000000" or "";
    }
  */
})
.catch((e) => console.log("Print error:", e.message))
```

#### printRawData(binaryData)

Prints with the given binary data (Uint8Array)

##### arguments
| Name | Type | Required | Description  |
| ---- | :--: | :------: | :----------: |
| `binaryData` | `Uint8Array` | `Yes` | string representing in JS Uint8Array data |


##### return type
```typescript
interface IMonitorStatus {
  connection: string;
  online: string;
  coverOpen: string;
  paper: string;
  paperFeed: string;
  panelSwitch: string;
  drawer: string;
  errorStatus: string;
  autoRecoverErr: string;
  adapter: string;
  batteryLevel: string;
}
```

```javascript
import EscPosPrinter, { getPrinterSeriesByName } from "react-native-esc-pos-printer"
import Encoder from 'esc-pos-encoder';

const encoder = new Encoder();

encoder
  .initialize()
  .line('The quick brown fox jumps over the lazy dog')
  .newline()
  .newline()
  .newline()
  .cut('partial');

let initialized = false;

if(!initialized) {
  const { target, name } = printer;

  await EscPosPrinter.init({
    target: target,
    seriesName: getPrinterSeriesByName(name),
  });

  initialized = true;
}

const status = await EscPosPrinter.printRawData(encoder.encode());

console.log("Print success!", status);

```

#### pairingBluetoothPrinter() - iOS only

Shows a list of Bluetooth devices available for pairing and pairs a selected device with the terminal.
Opens native dialog.

```javascript
import { pairingBluetoothPrinter } from "react-native-esc-pos-printer"

EscPosPrinter.pairingBluetoothPrinter()
.then(() => console.log("pairing success!"))
.catch((e) => console.log("pairing error:", e.message))

```

#### getPrinterCharsPerLine(seriesName)

Returns max characters per line for given printer series (Usefull while building receipt layout).
Supports only `font A` for now.

##### arguments
| Name | Type | Required | Description  |
| ---- | :--: | :------: | :----------: |
| `seriesName` | `string` | `Yes` | Specifies the target printer model. |

##### return type
```typescript
{
  fontA: number;
}
```

```javascript
import EscPosPrinter , { getPrinterSeriesByName } from "react-native-esc-pos-printer"

 const { name } = printer;

EscPosPrinter.getPrinterCharsPerLine(getPrinterSeriesByName(name))
.then((result) => console.log(result)) // { fontA: 48 }
.catch((e) => console.log("error:", e.message))

```

#### startMonitorPrinter(interval: number)

Monitors printer status with a given interval in seconds.

```javascript
import EscPosPrinter from "react-native-esc-pos-printer"

EscPosPrinter.addPrinterStatusListener((status) => {
  console.log(status.connection, status.online, status.paper); // will be executed every 5 sec
})

EscPosPrinter.startMonitorPrinter(5)
.then(() => console.log("Start monitor success!"))
.catch((e) => console.log("Start monitor error:", e.message))

```

#### stopMonitorPrinter()

Monitors printer status with a given interval in seconds.

```javascript
import EscPosPrinter from "react-native-esc-pos-printer"

EscPosPrinter.stopMonitorPrinter()
.then(() => console.log("Stopped!"))
.catch((e) => console.log("Stop error:", e.message))

```


## Limitations
1. For now it's not possible to print and discover on Android simulator. But you can always use real device.
2. For now you can print just using Uint8Array. Fortunately it's quite easy with [https://www.npmjs.com/package/esc-pos-encoder](https://www.npmjs.com/package/esc-pos-encoder).
3. You can not print images for now but work in progress ;)

## TODO

- [ ] Export all build in mehods including print image
- [ ] Make possible to print on Android simulator
## License

MIT
