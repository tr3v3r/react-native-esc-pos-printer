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

### [connect(`timeout: string`): `Promise<void>`](./connect.md)

Starts communication with the printer.

#### Example

```typescript
await printerInstance.connect();
```
---
