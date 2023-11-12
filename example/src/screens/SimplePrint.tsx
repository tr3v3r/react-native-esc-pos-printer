import React, { memo, useState } from 'react';
import { View, StyleSheet, Text } from 'react-native';
import { PrinterInfo, Button, ScreenTitle } from '../components';
import type { RootStackParamList } from '../navigation/RootNavigator';
import EscPosPrinter, {
  getPrinterSeriesByName,
} from 'react-native-esc-pos-printer';
import { useRoute, type RouteProp } from '@react-navigation/native';
import { base64Image } from '../base64Image';

type SimplePrintRouteProp = RouteProp<RootStackParamList, 'SimplePrint'>;

async function print() {
  const printing = new EscPosPrinter.printing();

  await printing
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
    .newline()
    .bold()
    .underline()
    .align('left')
    .text('Left')
    .newline()
    .align('right')
    .text('Right')
    .newline()
    .size(1, 1)
    .textLine(48, {
      left: 'Cheesburger',
      right: '3 EUR',
      gapSymbol: '_',
    })
    .newline()
    .textLine(48, {
      left: 'Chickenburger',
      right: '1.5 EUR',
      gapSymbol: '.',
    })
    .newline()
    .size(2, 2)
    .textLine(48, { left: 'Happy Meal', right: '7 EUR' })
    .newline()
    .align('left')
    .text('Left')
    .newline()

    .align('right')
    .text('Right')
    .newline()

    .align('center')
    .image(require('../store.png'), {
      width: 75,
      halftone: 'EPOS2_HALFTONE_THRESHOLD',
    })

    .image({ uri: base64Image }, { width: 75 })
    .image(
      {
        uri: 'https://raw.githubusercontent.com/tr3v3r/react-native-esc-pos-printer/main/ios/store.png',
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
}

export const SimplePrint = memo(() => {
  const {
    params: { printer },
  } = useRoute<SimplePrintRouteProp>();

  const [init, setInit] = useState(false);
  const [printing, setPrinting] = useState(false);

  const printSimpleReceipt = async () => {
    if (!init) {
      await EscPosPrinter.init({
        target: printer.target,
        seriesName: getPrinterSeriesByName(printer.deviceName),
        language: 'EPOS2_LANG_EN',
      });
      setInit(true);
    }
    try {
      setPrinting(true);
      await print();
    } catch (e) {
      console.log('Print error', e);
    } finally {
      setPrinting(false);
    }
  };

  return (
    <View style={styles.container}>
      <View style={styles.contentCotainer}>
        <ScreenTitle title={'Simple Print'} />
      </View>
      <View style={styles.contentCotainer}>
        <PrinterInfo printer={printer} />
      </View>
      <View style={styles.contentCotainer}>
        <Button
          loading={printing}
          title="Test print"
          onPress={printSimpleReceipt}
        />
        <Text style={styles.errorText} />
      </View>
    </View>
  );
});

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fcf9f9',
    alignItems: 'center',
    justifyContent: 'center',
  },

  contentCotainer: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },

  errorText: {
    color: 'red',
    fontSize: 16,
    marginTop: 20,
  },
});
