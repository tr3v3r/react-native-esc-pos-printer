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
    console.log(printer);
  }, [printer]);
  return (
    <View style={styles.container}>
      <Button
        title="discover"
        onPress={() => {
          console.log('discovering');
          EscPosPrinter.discover()
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
