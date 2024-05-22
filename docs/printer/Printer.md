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



