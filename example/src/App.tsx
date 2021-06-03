import * as React from 'react';
import Encoder from 'esc-pos-encoder';

import { StyleSheet, View, Button } from 'react-native';
import EscPosPrinter, {
  getPrinterSeriesByName,
  IPrinter,
} from 'react-native-esc-pos-printer';
import {} from 'react-native';

export default function App() {
  const [init, setInit] = React.useState(false);
  const [printer, setPrinter] = React.useState<IPrinter | null>(null);
  React.useEffect(() => {
    EscPosPrinter.addPrinterStatusListener((status) => {
      console.log('current printer status:', status);
    });
  }, []);
  React.useEffect(() => {
    console.log(printer);
  }, [printer]);
  return (
    <View style={styles.container}>
      <Button
        title="discover"
        onPress={() => {
          console.log('discovering');
          EscPosPrinter.discover({ usbSerialNumber: true })
            .then((printers) => {
              console.log('done!', printers);
              if (printers[0]) {
                setPrinter(printers[0]);
              }
            })
            .catch(console.log);
        }}
      />

      <Button
        title="gett lines per row"
        disabled={!printer}
        color={!printer ? 'gray' : 'blue'}
        onPress={async () => {
          if (printer) {
            if (!init) {
              await EscPosPrinter.init({
                target: printer.target,
                seriesName: getPrinterSeriesByName(printer.name),
              });
              setInit(true);
            }

            const status = await EscPosPrinter.getPrinterCharsPerLine(
              getPrinterSeriesByName(printer.name)
            );

            console.log('print', status);
          }
        }}
      />

      <Button
        title="Start monitor printer status"
        disabled={!printer}
        color={!printer ? 'gray' : 'blue'}
        onPress={async () => {
          if (printer) {
            if (!init) {
              await EscPosPrinter.init({
                target: printer.target,
                seriesName: getPrinterSeriesByName(printer.name),
              });
              setInit(true);
            }

            const status = await EscPosPrinter.startMonitorPrinter();

            console.log('Printer status:', status);
          }
        }}
      />

      <Button
        title="Stop monitor printer status"
        disabled={!printer}
        color={!printer ? 'gray' : 'blue'}
        onPress={async () => {
          if (printer) {
            if (!init) {
              await EscPosPrinter.init({
                target: printer.target,
                seriesName: getPrinterSeriesByName(printer.name),
              });
              setInit(true);
            }

            const status = await EscPosPrinter.stopMonitorPrinter();

            console.log('Printer status:', status);
          }
        }}
      />

      <Button
        title="testt"
        disabled={!printer}
        color={!printer ? 'gray' : 'blue'}
        onPress={async () => {
          const encoder = new Encoder();

          encoder
            .initialize()
            .line('The quick brown fox jumps over the lazy dog')
            .newline()
            .newline()
            .newline()
            .cut('partial');

          try {
            if (printer) {
              if (!init) {
                await EscPosPrinter.init({
                  target: printer.target,
                  seriesName: getPrinterSeriesByName(printer.name),
                });
                setInit(true);
              }
              // const paper = await EscPosPrinter.getPaperWidth();
              // console.log(paper);
              const status = await EscPosPrinter.printRawData(encoder.encode());
              // const pairingSatus = await EscPosPrinter.pairingBluetoothPrinter();
              // console.log(pairingSatus);
              console.log('print', status);
            }
          } catch (error) {
            console.log('error', error);
          }
        }}
      />
      <Button
        title="test print chaining"
        disabled={!printer}
        color={!printer ? 'gray' : 'blue'}
        onPress={async () => {
          try {
            if (printer) {
              if (!init) {
                await EscPosPrinter.init({
                  target: printer.target,
                  seriesName: getPrinterSeriesByName(printer.name),
                });
                setInit(true);
              }

              const printing = new EscPosPrinter.printing();
              const status = await printing
                .initialize()
                .align('center')
                .size(6, 6)
                .line('DUDE!')
                .size(1, 1)
                .text('is that a ')
                .bold()
                .underline()
                .text('printer?')
                .bold()
                .underline()
                .newline(2)
                .align('center')
                .imageAsset('store.png', 75)
                .cut()
                .send();

              console.log('printing', status);
            }
          } catch (error) {
            console.log('error', error);
          }
        }}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
});
