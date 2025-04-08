import { memo } from 'react';
import { View, StyleSheet, Text } from 'react-native';
import { usePrintersDiscovery } from 'react-native-esc-pos-printer';
import { PrintersList, Button, ScreenTitle } from '../components';
import { useNavigation, type NavigationProp } from '@react-navigation/native';
import type { RootStackParamList } from '../navigation/RootNavigator';

type DiscoveryNavigationProp = NavigationProp<
  RootStackParamList,
  'SimplePrint'
>;

export const Discovery = memo(() => {
  const { start, printerError, isDiscovering, printers } =
    usePrintersDiscovery();

  const navigation = useNavigation<DiscoveryNavigationProp>();

  return (
    <View style={styles.container}>
      <View style={styles.contentCotainer}>
        <ScreenTitle title={'Discovery'} />
      </View>
      <PrintersList
        onPress={(printer) => {
          if (printer) {
            navigation.navigate('Printer', { printer });
          }
        }}
        printers={printers}
      />
      <View style={styles.contentCotainer}>
        <Button
          loading={isDiscovering}
          title="Search"
          onPress={() => start()}
        />
        {printerError ? (
          <Text style={styles.errorText}>{printerError.message}</Text>
        ) : null}
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
