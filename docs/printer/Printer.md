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
