# Printer

Class that controls the printer connection and printing functions.

## [constructor](./constructor.md)

Initializes the printer object.

#### Example

```typescript
const printer = new Printer({
  target: "BT:00:22:15:7D:70:9C",
  deviceName: "TM-T88V",
})
```

## Methods

### [connect(`timeout?: string`): `Promise<void>`](./connect.md)

Starts communication with the printer.

#### Example

```typescript
await printerInstance.connect();
```
---

### [disconnect(): `Promise<void>`](./disconnect.md)

Ends communication with the printer.

#### Example

```typescript
await printerInstance.disconnect();
```
---
### [addText(`text: string`): `Promise<void>`](./addText.md)

Adds a character print command to the command buffer.

#### Example

```typescript
await printerInstance.addText("Hello, World!");
```
---
### [addFeedLine(`line?: number`): `Promise<void>`](./addFeedLine.md)

Adds a paper-feed-by-line command to the command buffer.

#### Example

```typescript
await printerInstance.addFeedLine(3);
```

---
### [addLineSpace(`linespc: number`): `Promise<void>`](./addLineSpace.md)

Adds line spacing setting to the command buffer.

#### Example

```typescript
await printerInstance.addLineSpace(50);
```

---
### [sendData(`timeout?: number`): `Promise<PrinterStatusResponse>`](./sendData.md)

Sends the print command.

#### Example

```typescript
const printerStatus = await printerInstance.sendData();
```
---

### [addCut(`type?: AddCutTypeParam`): `Promise<void>`](./addCut.md)

Adds a sheet cut command to the command buffer.
Sets how to cut paper.

#### Example

```typescript
await printerInstance.addCut(PrinterConstants.CUT_NO_FEED);
```

___
### [getPrinterSetting(`type: PrinterGetSettingsType, timeout?: number`): `Promise<PrinterSettingsResponse>`](./getPrinterSetting.md)

Acquires the set value of the printer setting.
The value acquired by this API is notified to the listener method specified in the listener parameter.

#### Example

```typescript

const printerSetting = await printerInstance.getPrinterSetting(PrinterConstants.PRINTER_SETTING_PAPERWIDTH);
```

___
### [getStatus(): `Promise<PrinterStatusResponse>`](./getStatus.md)

Acquires the current status information.

#### Example

```typescript
const printerStatus = await printerInstance.getStatus();
```
---

### [addImage(params: AddImageParams): `Promise<void>`](./addImage.md)

Adds a raster image print command to the command buffer.

#### Example

```typescript
await printerInstance.addImage({
  source: require('../store.png'),
  width: 100,
});
```


### [addBarcode(params: AddBarcodeParams): `Promise<void>`](./addBarcode.md)

Adds a barcode print command to the command buffer.

#### Example

```typescript
 await printerInstance.addBarcode({
  data: 'Test123',
  type: PrinterConstants.BARCODE_CODE93,
  hri: PrinterConstants.HRI_BELOW,
  width: 2,
  height: 50,
});
```

### [addSymbol(params: AddSymbolParams): `Promise<void>`](./addSymbol.md)

Adds a 2D symbol print command to the command buffer.

#### Example

```typescript
 await printerInstance.addSymbol({
  type: PrinterConstants.SYMBOL_QRCODE_MODEL_2,
  level: PrinterConstants.LEVEL_M,
  size: 5,
  data: 'Test123',
});
```

### [addCommand(`data: Uint8Array`): `Promise<void>`](./addCommand.md)

Adds a command to the command buffer. Sends the ESC/POS command.

#### Example

```typescript
import EscPosEncoder from 'esc-pos-encoder';

let encoder = new EscPosEncoder();

let result = encoder
    .initialize()
    .text('The quick brown fox jumps over the lazy dog')
    .newline()
    .qrcode('https://nielsleenheer.com')
    .encode(); // or any other way to get the Uint8Array

await printerInstance.addCommand(result);
```

### [addPulse(`params?: AddPulseParams`): `Promise<void>`](./addPulse.md)

Adds a drawer kick command to the command buffer. Sets the drawer kick.

#### Example

```typescript
await printerInstance.addPulse();
```

### [addTextAlign(`params?: AddTextAlignParam`): `Promise<void>`](./addTextAlign.md)

Adds a text alignment command to the command buffer.

#### Example

```typescript
await printerInstance.addTextAlign(PrinterConstants.ALIGN_CENTER);
```

### [addTextSize(`params?: AddTextSizeParams`): `Promise<void>`](./addTextSize.md)

Adds character scaling factor setting to the command buffer.

#### Example

```typescript
await printerInstance.addTextSize({
  width: 2,
  height: 2,
});
```

### [addTextSmooth(`params?: AddTextSmoothParam`): `Promise<void>`](./addTextSmooth.md)

Adds smoothing setting to the command buffer.

#### Example

```typescript
await printerInstance.addTextSmooth(PrinterConstants.TRUE);
```

### [addTextStyle(`params?: AddTextStyleParams`): `Promise<void>`](./addTextStyle.md)

Adds character style setting to the command buffer.

#### Example

```typescript
await printerInstance.addTextStyle({
  em: PrinterConstants.TRUE,
  ul: PrinterConstants.TRUE,
  color: PrinterConstants.PARAM_UNSPECIFIED,
} as const);
```

### [addTextLang(`lang: AddTextLangParam`): `Promise<void>`](./addTextLang.md)

Adds language setting to the command buffer.
A text string specified by the [addText](./addText.md) API is encoded according to the language specified by this API.

#### Example

```typescript
await printerInstance.addTextLang(PrinterConstants.LANG_JA);
```

### clearCommandBuffer(): `Promise<void>`

Clears the command buffer.

#### Example

```typescript
await printerInstance.clearCommandBuffer();
```

## Static Methods

### [Printer.addTextLine(`printerInstance: Printer, params: AddTextLineParams`): `Promise<void>`](./addTextLine.md)

Prints text line with left and right parts

#### Example

```typescript
await Printer.addTextLine(printerInstance, {
  left: 'Cheesburger',
  right: '3 EUR',
  gapSymbol: '_',
});
```

Find more examples [here](../../src/printer/utils/layout/__tests__/spaceBetween.test.tsx)



### [Printer.monitorPrinter(`printerInstance: Printer, listener: Listener, interval: number`): () => void](./monitorPrinter.md)

Starts monitoring the printer status.

#### Example

```typescript
 const stop = Printer.monitorPrinter(printerInstance, (status) => {
     console.log(status)
 });

 // call stop() to stop monitoring
```


### [Printer.tryToConnectUntil(`printerInstance: Printer, condition: (status: PrinterStatusResponse) => boolean`): `Promise<void>`](./tryToConnectUntil.md)


Tries to connect to the printer until the condition is met.

#### Example

```typescript
await Printer.tryToConnectUntil(
  printerInstance,
  (status) => status.online.statusCode === PrinterConstants.TRUE
)
```

### [Printer.addViewShot(`printerInstance: Printer, params: AddViewShotParams`): `Promise<void>`](./addViewShot.md)

Prints image captured from React Native View

Requires `react-native-view-shot` to be installed

```bash
yarn add react-native-view-shot
```

for iOS, run

```bash
cd ios && pod install
```


#### Example

```typescript
const ref = useRef<View>(null);

...

await Printer.addViewShot(printerInstance, {
 viewNode: ref.current,
});

...

return (
  <View ref={ref}>
    <Text>Print me</Text>
  </View>
);
```

<img src="../../assets/viewShotCode.jpg" width="200">
<img src="../../assets/viewShotResult.jpg" width="200">

Find detailed examples [here](../../example/src/screens/PrintFromView.tsx)
