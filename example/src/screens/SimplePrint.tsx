import React, { memo, useState } from 'react';
import { View, StyleSheet, Text } from 'react-native';
import { PrinterInfo, Button, ScreenTitle } from '../components';
import type { RootStackParamList } from '../navigation/RootNavigator';
import { Printer, PrinterConstants } from 'react-native-esc-pos-printer';
import { useRoute, type RouteProp } from '@react-navigation/native';
import { base64Image } from '../base64Image';

import { launchCamera, launchImageLibrary } from 'react-native-image-picker';
// import { base64Image } from '../base64Image';

type SimplePrintRouteProp = RouteProp<RootStackParamList, 'SimplePrint'>;

export const SimplePrint = memo(() => {
  const {
    params: { printer },
  } = useRoute<SimplePrintRouteProp>();

  const [printing, setPrinting] = useState(false);

  const printSimpleReceipt = async () => {
    const printerInstance = new Printer({
      target: printer.target,
      deviceName: printer.deviceName,
    });

    // const result = await launchImageLibrary({ mediaType: 'photo' });
    // console.log(result);
    try {
      setPrinting(true);
      const res = await printerInstance.queue.add(async () => {
        await printerInstance.connect();

        await printerInstance.addImage({
          source: { uri: base64Image },
          width: 100,
        });

        // await printerInstance.addImage({
        //   source: {
        //     uri: 'file:///data/user/0/com.escposprinterexample/cache/rn_image_picker_lib_temp_bed8229d-f605-4417-94b9-41062c6a80e5.jpg',
        //   },
        //   width: 200,
        // });

        await printerInstance.addBarcode({
          data: 'Test123',
          type: PrinterConstants.BARCODE_CODE93,
          width: 2,
          height: 50,
          hri: PrinterConstants.HRI_BELOW,
        });

        // await printerInstance.addSymbol({
        //   type: PrinterConstants.SYMBOL_QRCODE_MODEL_2,
        //   level: PrinterConstants.LEVEL_M,
        //   width: 5,
        //   height: 5,
        //   size: 5,
        //   data: 'Test123',
        // });

        await printerInstance.addFeedLine();
        await printerInstance.addCut();

        // const test = await printerInstance.getStatus();
        // console.log('test', test);
        // console.log('test', test);

        // const printerSettings = await printerInstance.getPrinterSetting(
        //   PrinterGetSettingsType.PRINTER_SETTING_PAPERWIDTH
        // );

        // console.log('printerSettings', printerSettings);

        const result = await printerInstance.sendData();

        await printerInstance.disconnect();
        return result;
      });

      console.log('result', res);
    } catch (e) {
      await printerInstance.disconnect();
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
