import { useRoute, type RouteProp } from '@react-navigation/native';
import { memo, useMemo, useRef, useState } from 'react';
import { StyleSheet, Text, View } from 'react-native';
import { Printer, PrinterConstants } from 'react-native-esc-pos-printer';
import { Button, ScreenTitle } from '../components';
import type { RootStackParamList } from '../navigation/RootNavigator';

type ImageFromViewPrintRouteProp = RouteProp<
  RootStackParamList,
  'PrintFromView'
>;
export const PrintFromView = memo(() => {
  const {
    params: { printer },
  } = useRoute<ImageFromViewPrintRouteProp>();

  const ref = useRef<View>(null);

  const [printing, setPrinting] = useState(false);

  const printerInstance = useMemo(
    () =>
      new Printer({
        target: printer.target,
        deviceName: printer.deviceName,
      }),
    [printer]
  );

  const print = async () => {
    try {
      setPrinting(true);

      await printerInstance.addQueueTask(async () => {
        await Printer.tryToConnectUntil(
          printerInstance,
          (status) => status.online.statusCode === PrinterConstants.TRUE
        );

        await printerInstance.addFeedLine();

        await Printer.addViewShot(printerInstance, {
          viewNode: ref.current,
        });

        await printerInstance.addCut();

        const result = await printerInstance.sendData();

        await printerInstance.disconnect();
        return result;
      });
    } catch (e) {
      await printerInstance.disconnect();
    } finally {
      setPrinting(false);
    }
  };

  return (
    <View style={styles.container}>
      <View style={styles.contentCotainer}>
        <ScreenTitle title={'Image From View Print'} />
      </View>
      <View ref={ref} collapsable={false} style={styles.receiptContainer}>
        <View style={styles.row}>
          <Text style={styles.boldText}>
            Burger{' '}
            <Text style={[styles.normalText, styles.smallText]}>
              (without cheese)
            </Text>
          </Text>
          <Text>16 EUR</Text>
        </View>

        <View style={styles.row}>
          <Text style={styles.boldText}>
            Fries{' '}
            <Text style={[styles.normalText, styles.smallText]}>(medium)</Text>
          </Text>
          <Text>30 EUR</Text>
        </View>

        <View style={styles.row}>
          <Text style={styles.boldText}>
            Sous{' '}
            <Text style={[styles.normalText, styles.smallText]}>(sour)</Text>
          </Text>
          <Text>10 EUR</Text>
        </View>
        <View style={styles.line} />

        <View style={styles.row}>
          <Text>Sum</Text>
          <Text style={styles.boldText}>56 EUR</Text>
        </View>
      </View>

      <View style={styles.contentCotainer}>
        <Button loading={printing} title="Test print" onPress={print} />
      </View>
    </View>
  );
});

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fcf9f9',
    alignItems: 'center',
    justifyContent: 'space-around',
    paddingVertical: 20,
  },

  contentCotainer: {
    alignItems: 'center',
    justifyContent: 'center',
  },
  receiptContainer: {
    width: 350,
    marginVertical: 40,
  },
  row: {
    paddingVertical: 10,
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },

  errorText: {
    color: 'red',
    fontSize: 16,
    marginTop: 20,
  },
  boldText: {
    fontWeight: '900',
  },

  normalText: {
    fontWeight: '300',
  },

  smallText: {
    fontSize: 9,
  },

  line: {
    borderBottomColor: 'black',
    borderBottomWidth: 1,
  },
});
