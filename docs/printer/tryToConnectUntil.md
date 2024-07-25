## static Printer.tryToConnectUntil

Tries to connect to the printer until the condition is met.

### Parameters

#### printerInstance

- `Printer`

Printer instance defined by calling `new Printer(...)`.

#### predicate

- (status: [PrinterStatus](../interfaces/printerStatus.md)) => boolean

Predicate function that will be called with printer status. If returns `true` promise will be resolved and next steps will be executed.

### Returns

`Promise<void>`

### Supplementary explanation

- Can be used to wait for printer to be ready based on its status. I.e. connection loss.
- Internaly uses [connect](./connect.md), [getStatus](./getStatus.md) commands.

