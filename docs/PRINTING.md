# Printing methods

### initialize

Initializes the chaining object - this must be the first call in the chain

```javascript
printing.initialize().text('printer?');
```

### text

Prints text

```javascript
printing.initialize().text('printer?');
```

### new line

Prints n numbers of newlines, defaults to 1 newline

```javascript
printing.initialize().newline(n);
```

### line

Prints text followed by a new line

```javascript
printing.initialize().line('Cats eating mangos right off the tree');
```

### underline

Sets the underline state - optional boolean parameter, if no parameter is supplied it will toggle the underline state

```javascript
printing.initialize().underline();
```

### bold

Sets the bold state - optional boolean parameter, if no parameter is supplied it will toggle the bold state

```javascript
printing.initialize().bold();
```

### smooth

Sets the smooth state - optional boolean parameter, if no parameter is supplied it will toggle the smooth state

```javascript
printing.initialize().smooth();
```

### size

Sets the text size. Text can be scaled from size 1 - 8. Optional width parameter, if not provided text will be scaled equal to the height.

```javascript
printing.initialize().size(5, 4);
```

### align

Sets the text alignment. Valid values are 'left' | 'center' | 'right'.

```javascript
printing.initialize().align('center');
```

### imageAsset

## (Depracted use .image() method instead).
Prints an image from iOS/Android local assets folder.

- Android: Save your image file under the directory `android/app/src/main/assets`. Note that files in this directory must be lowercase.
- iOS: Open Xcode and add your image file to the project (Right-click the project and select `Add Files to [PROJECTNAME]`)
- Use file name as first argument and image width as a second (width of the image 1 to 65535)

```javascript
printing.initialize().imageAsset('logo.png', 200);
```

### imageBase64

## (Depracted use .image() method instead).
Prints an image represented by base64 data (i.e. "data:image/png;base64,...").

- Use base64 string as first argument and image width as a second (width of the image 1 to 65535)
- If image is not printing for some reason try to play with width
- See example of usage in `example` folder

```javascript
export const base64Image =
  'data:image/png;base64,....'

printing.initialize().imageBase64(base64Image, 75);
```

### image

Prints image from local/remote source.

- source : Image source. `{ uri: base64String | https:// | http:// | file:// }` or `require('./path_to_local_image/image.png')`
- params
  - width: Width of the image (from 1 to 65535).
  - color? : Specifies the color. `'EPOS2_COLOR_1' | 'EPOS2_COLOR_2' | 'EPOS2_COLOR_3' | 'EPOS2_COLOR_4'`
  - mode? : Specifies the color mode. `'EPOS2_MODE_MONO' | 'EPOS2_MODE_GRAY16' | 'EPOS2_MODE_MONO_HIGH_DENSITY'`
  - halftone? : Specifies the halftone processing method. `'EPOS2_HALFTONE_DITHER' | 'EPOS2_HALFTONE_ERROR_DIFFUSION' | 'EPOS2_HALFTONE_THRESHOLD'`
  - brigtness? : Specifies the brightness compensation value (from 0.1 to 10).

```javascript

printing.initialize()
    .image(require('./store.png'), {
        width: 75,
        halftone: 'EPOS2_HALFTONE_THRESHOLD',
      })
    .image({ uri: base64Image }, { width: 75 })
    .image(
      {
        uri:
          'https://raw.githubusercontent.com/tr3v3r/react-native-esc-pos-printer/main/ios/store.png',
      },
      { width: 75 }
    )
    .cut()
    .send();
```

### barcode

Prints a barcode.

- value : The string of barcode data, it will be restricted by the `type`.
- type? : Sets the barcode type - optional string parameter, defaults to CODE93.
- hri? : Sets the position of human-robot interaction - optional string parameter, defaults to BELOW.
- width? : Sets the width of a single module in dots - optional number parameter, defaults to 2 (width of the barcode 2 to 6).
- height? : Sets the height of the barcode in dots - optional number parameter, defaults to 50 (height of the barcode 1 to 255).

```javascript
printing.initialize().barcode({
  value: 'Test123',
  type: 'EPOS2_BARCODE_CODE93',
  hri: 'EPOS2_HRI_BELOW',
  width: 2,
  height: 50,
});
```

### qrcode

Prints a QR Code.

- value : The string of QR Code data.
- width : Sets the size of the QR Code, defaults to 3 (width of the qrcode 3 to 16).
- type : Sets the type of the QR Code - optional string parameter, defaults to QRCODE_MODEL_2, and EPOS2_SYMBOL_QRCODE_MICRO is android only.
- level? : Sets the error correction level - optional string parameter, defaults to LEVEL_M.


```javascript
printing.initialize().qrcode({
  value: 'Test123',
  width: 5,
  type: 'EPOS2_SYMBOL_QRCODE_MODEL_2',
  level: 'EPOS2_LEVEL_M',
});
```

### data
Adds the given binary data (Uint8Array) to the print queue
See example folder for more details.

```javascript
printing.initialize().data(uint8ArrayData);
```

### cut

Adds a cut to the paper

```javascript
printing.initialize().cut();
```

### addPulse

Adds a drawer kick to open the cash drawer

- Specifies the drawer kick connector as first parameter - optional string parameter, defaults to DRAWER_2PIN. Valid values are: `EPOS2_DRAWER_2PIN` | `EPOS2_DRAWER_5PIN`

```javascript
printing.initialize().addPulse();   // uses default pin (pin 2)
printing.initialize().addPulse('EPOS2_DRAWER_2PIN');
```

### send

Is required at the end of a printer chain to send the commands to the printer

```javascript
printing.initialize().text("hello, is it me you're looking for").send();
```

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
