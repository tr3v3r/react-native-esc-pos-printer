import * as React from 'react';
import Encoder from 'esc-pos-encoder';

import { StyleSheet, View, Button, SafeAreaView } from 'react-native';
import EscPosPrinter, {
  getPrinterSeriesByName,
  IPrinter,
} from 'react-native-esc-pos-printer';
import { Modal } from 'react-native';

import { base64Image } from './base64Image';
import MultiPrint from './MultiPrint';
export default function App() {
  const [init, setInit] = React.useState(false);
  const [printer, setPrinter] = React.useState<IPrinter | null>(null);
  const [isModalOpen, setIsModalOpen] = React.useState(false);

  React.useEffect(() => {
    EscPosPrinter.addPrinterStatusListener((status) => {
      console.log('current printer status:', status);
    });
  }, []);
  React.useEffect(() => {
    console.log(printer);
  }, [printer]);

  return (
    <SafeAreaView style={styles.container}>
      <Modal visible={isModalOpen}>
        <MultiPrint
          closeModal={() => {
            setIsModalOpen(false);
          }}
        />
      </Modal>
      <View>
        <Button
          title="Discover"
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
          title="Get lines per row"
          disabled={!printer}
          color={!printer ? 'gray' : 'blue'}
          onPress={async () => {
            if (printer) {
              if (!init) {
                await EscPosPrinter.init({
                  target: printer.target,
                  seriesName: getPrinterSeriesByName(printer.name),
                  language: 'EPOS2_LANG_EN',
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
                  language: 'EPOS2_LANG_EN',
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
                  language: 'EPOS2_LANG_EN',
                });
                setInit(true);
              }

              const status = await EscPosPrinter.stopMonitorPrinter();

              console.log('Printer status:', status);
            }
          }}
        />

        <Button
          title="Print from data"
          disabled={!printer}
          color={!printer ? 'gray' : 'blue'}
          onPress={async () => {
            const encoder = new Encoder();

            encoder
              .initialize()
              .line('The quick brown fox jumps over the lazy dog')
              .newline()
              .newline()
              .newline();

            try {
              if (printer) {
                if (!init) {
                  await EscPosPrinter.init({
                    target: printer.target,
                    seriesName: getPrinterSeriesByName(printer.name),
                    language: 'EPOS2_LANG_EN',
                  });
                  setInit(true);
                }

                const printing = new EscPosPrinter.printing();

                const status = await printing
                  .data(encoder.encode())
                  .cut()
                  .send();

                console.log('print', status);
              }
            } catch (error) {
              console.log('error', error);
            }
          }}
        />
        <Button
          title="Test print chaining"
          disabled={!printer}
          color={!printer ? 'gray' : 'blue'}
          onPress={async () => {
            try {
              if (printer) {
                if (!init) {
                  await EscPosPrinter.init({
                    target: printer.target,
                    seriesName: getPrinterSeriesByName(printer.name),
                    language: 'EPOS2_LANG_EN',
                  });
                  setInit(true);
                }

                const printing = new EscPosPrinter.printing();
                const status = await printing
                  .initialize()
                  .align('center')
                  .size(3, 3)
                  .line('DUDE!')
                  .smooth(true)
                  .line('DUDE!')
                  .smooth(false)
                  .size(1, 1)
                  .text('is that a ')
                  .bold()
                  .underline()
                  .text('printer?')
                  .bold()
                  .underline()
                  .newline(2)
                  .align('center')
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
                  .barcode({
                    value: 'Test123',
                    type: 'EPOS2_BARCODE_CODE93',
                    width: 2,
                    height: 50,
                    hri: 'EPOS2_HRI_BELOW',
                  })
                  .qrcode({
                    value: 'Test123',
                    level: 'EPOS2_LEVEL_M',
                    width: 5,
                  })
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
      <Button
        title="Test multi print"
        onPress={() => {
          setIsModalOpen(true);
        }}
      />
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'space-between',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
});
