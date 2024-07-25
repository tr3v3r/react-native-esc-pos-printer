# API

1. [discovery](./discovery/discovery.md)
2. [Printer](./printer/Printer.md)

## Example

```jsx
  import { usePrintersDiscovery, Printer } from 'react-native-esc-pos-printer';

  ...

  const { start, isDiscovering, printers } =
    usePrintersDiscovery();

  const print = () => {
    printersData.forEach(printersData => {
        const printerInstance = new Printer({
          target: printersData.target,
          deviceName: printersData.deviceName,
        });

        const res = await printerInstance.addQueueTask(async () => {
          await Printer.tryToConnectUntil(
            printerInstance,
            (status) => status.online.statusCode === PrinterConstants.TRUE
          );
          await printerInstance.addText('DUDE!');
          await printerInstance.addFeedLine();
          await printerInstance.addCut();
          const result = await printerInstance.sendData();
          await printerInstance.disconnect();
          return result;
      })
    })
  }

  return (
    ...
        <Button
          loading={isDiscovering}
          title="Search"
          onPress={() => start()}
        />
       {printers.length ? <Button
          title="Print"
          onPress={() => print()}
        /> : null}
    ...
  );
```
