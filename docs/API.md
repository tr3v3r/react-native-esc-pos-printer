# API

1. [init](#init-target-seriesname-language-)
2. [discover](#discoverparams)
3. [pairingBluetoothPrinter](#pairingbluetoothprinter---ios-only)
4. [getPrinterCharsPerLine](#getprintercharsperlineseriesname)
5. [startMonitorPrinter](#startmonitorprinterinterval-number)
6. [stopMonitorPrinter](#stopmonitorprinter)
7. [instantiate](#instantiate-target-seriesname-language)
8. [printing](./PRINTING.md)
9. [disconnectPrinter](#disconnectprintertarget-string)

### init({ target, seriesName, language? })

Initializes printer using it's target and series name.

#### arguments

| Name         |   Type   | Required |     Default     |                                                                   Description                                                                   |
| ------------ | :------: | :------: | :-------------: | :---------------------------------------------------------------------------------------------------------------------------------------------: |
| `target`     | `string` |  `Yes`   |        -        | The connection target of a device which can be specified by connectAPI: ("TCP:192.168.192.168" "BT:00:22:15:7D:70:9C" "USB:000000000000000000") |
| `seriesName` | `string` |  `Yes`   |        -        |                                                       Specifies the target printer model.                                                       |
| `language`   | `string` |   `No`   | `EPOS2_LANG_EN` |                                   Specifies the language : EPOS2_LANG_EN, EPOS2_LANG_JA, EPOS2_LANG_ZH_CN...                                    |

```javascript
import EscPosPrinter from 'react-native-esc-pos-printer';

EscPosPrinter.init({
  target: 'TCP:192.168.192.168',
  seriesName: 'EPOS2_TM_M10',
  language: 'EPOS2_LANG_EN',
})
  .then(() => console.log('Init success!'))
  .catch((e) => console.log('Init error:', e.message));
```

### discover(params?)

`For iOS you must` [pair printer](#pairingbluetoothprinter---ios-only) `with device to search Bluetooth printers`

Starts searching for device.
Returns list of printers.

#### params

| Name                     |   Type    | Required | Default |                                Description                                 |
| ------------------------ | :-------: | :------: | :-----: | :------------------------------------------------------------------------: |
| `usbSerialNumber`        | `boolean` |   `No`   | `false` |         To extract the serial number of the usb device on Android          |
| `scanningTimeoutIOS`     | `boolean` |   `No`   | `5000`  |          Timeout in milliseconds for scanning the printers on iOS          |
| `scanningTimeoutAndroid` | `boolean` |   `No`   | `5000`  |        Timeout in milliseconds for scanning the printers on Android        |
| `findFirstAndroid`       | `boolean` |   `No`   | `false` | Whether to finish the discovery when the first printer is found on Android |

#### return type

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
import EscPosPrinter from 'react-native-esc-pos-printer';

EscPosPrinter.discover()
  .then((printers) => {
    console.log(printers[0]);
    /*
    {
      name: "TM_M10",
      ip: "192.168.192.168" or "",
      mac: "12:34:56:78:56:78" or "",
      target: "TCP:192.168.192.168" or "BT:00:22:15:7D:70:9C" or "USB:000000000000000000",
      bt: "12:34:56:78:56:78" or "",
      usb: "000000000000000000" or "";
      usbSerialNumber: "123456789012345678" or ""; // available if usbSerialNumber === true
    }
  */
  })
  .catch((e) => console.log('Print error:', e.message));
```

```javascript
import EscPosPrinter from 'react-native-esc-pos-printer';

EscPosPrinter.discover({ usbSerialNumber: true })
  .then((printers) => {
    console.log(printers[0]);
    /*
    {
      name: "TM_M10",
      ip: "192.168.192.168" or "",
      mac: "12:34:56:78:56:78" or "",
      target: "TCP:192.168.192.168" or "BT:00:22:15:7D:70:9C" or "USB:000000000000000000",
      bt: "12:34:56:78:56:78" or "",
      usb: "000000000000000000" or "",
      usbSerialNumber: "123456789012345678" or ""
      };
    }
  */
  })
  .catch((e) => console.log('Print error:', e.message));
```

### pairingBluetoothPrinter() - iOS only

Shows a list of Bluetooth devices available for pairing and pairs a selected device with the terminal.
Opens native dialog.

```javascript
import { pairingBluetoothPrinter } from 'react-native-esc-pos-printer';

EscPosPrinter.pairingBluetoothPrinter()
  .then(() => console.log('pairing success!'))
  .catch((e) => console.log('pairing error:', e.message));
```

### getPrinterCharsPerLine(seriesName)

Returns max characters per line for given printer series (Usefull while building receipt layout).
Supports only `font A` for now. Not recommended to use right before printing since printer could be busy. For better performance use it right after init or add some delay before calling this printing method.

#### arguments

| Name         |   Type   | Required |             Description             |
| ------------ | :------: | :------: | :---------------------------------: |
| `seriesName` | `string` |  `Yes`   | Specifies the target printer model. |

#### return type

```typescript
{
  fontA: number;
}
```

```javascript
import EscPosPrinter, {
  getPrinterSeriesByName,
} from 'react-native-esc-pos-printer';

const { name } = printer;

EscPosPrinter.getPrinterCharsPerLine(getPrinterSeriesByName(name))
  .then((result) => console.log(result)) // { fontA: 48 }
  .catch((e) => console.log('error:', e.message));
```

### startMonitorPrinter(interval: number)

Monitors printer status with a given interval in seconds.

```javascript
import EscPosPrinter from 'react-native-esc-pos-printer';

EscPosPrinter.addPrinterStatusListener((status) => {
  console.log(status.connection, status.online, status.paper); // will be executed every 5 sec
});

EscPosPrinter.startMonitorPrinter(5)
  .then(() => console.log('Start monitor success!'))
  .catch((e) => console.log('Start monitor error:', e.message));
```

### stopMonitorPrinter()

Monitors printer status with a given interval in seconds.

```javascript
import EscPosPrinter from 'react-native-esc-pos-printer';

EscPosPrinter.stopMonitorPrinter()
  .then(() => console.log('Stopped!'))
  .catch((e) => console.log('Stop error:', e.message));
```

### instantiate({ target, seriesName, language? })

Initializes printer using it's target and series name. Using this method you can initialize multiple printers.

#### arguments

| Name         |   Type   | Required |     Default     |                                                                   Description                                                                   |
| ------------ | :------: | :------: | :-------------: | :---------------------------------------------------------------------------------------------------------------------------------------------: |
| `target`     | `string` |  `Yes`   |        -        | The connection target of a device which can be specified by connectAPI: ("TCP:192.168.192.168" "BT:00:22:15:7D:70:9C" "USB:000000000000000000") |
| `seriesName` | `string` |  `Yes`   |        -        |                                                       Specifies the target printer model.                                                       |
| `language`   | `string` |   `No`   | `EPOS2_LANG_EN` |                                   Specifies the language : EPOS2_LANG_EN, EPOS2_LANG_JA, EPOS2_LANG_ZH_CN...                                    |

```javascript
import EscPosPrinter from 'react-native-esc-pos-printer';

EscPosPrinter.instantiate({
  target: 'TCP:192.168.192.168',
  seriesName: 'EPOS2_TM_M10',
  language: 'EPOS2_LANG_EN',
})
  .then(() => console.log('Init success!'))
  .catch((e) => console.log('Init error:', e.message));
```

### disconnectPrinter(target: string)

Use this method to disconnect and delete the printer object initialized using [instantiate](#instantiate-target-seriesname-language) method. You need to call this function when the printer is no longer needed, but note that after calling this method you would need to re-instantiate the printer again before sending print jobs.

```javascript
import EscPosPrinter from 'react-native-esc-pos-printer';

EscPosPrinter.disconnectPrinter()
  .then(() => console.log('Disconnect success'))
  .catch((e) => console.log('Disconnect error', e.message));
```
