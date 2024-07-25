## static Printer.monitorPrinter

Starts monitoring the printer status.

### Parameters

#### printerInstance

- `Printer`

Printer instance defined by calling `new Printer(...)`.

#### listener

- (status: [PrinterStatus](../interfaces/printerStatus.md)) => void

Listener function that will be called with printer status.

#### interval (optional)

- `number`

Interval in milliseconds. Default: 1000.

### Returns

`() => void`


### Supplementary explanation

- Internaly uses [connect](./connect.md), [getStatus](./getStatus.md) and [disconnect](./disconnect.md) commands.

