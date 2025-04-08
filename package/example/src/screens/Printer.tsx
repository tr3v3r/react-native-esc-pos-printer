import {
  useNavigation,
  useRoute,
  type RouteProp,
  type NavigationProp,
} from '@react-navigation/native';
import { memo } from 'react';
import { StyleSheet, View } from 'react-native';

import { Button, PrinterInfo, ScreenTitle } from '../components';
import type { RootStackParamList } from '../navigation/RootNavigator';

type PrinterRouteProp = RouteProp<RootStackParamList, 'Printer'>;

type PrinterNavigationProp = NavigationProp<RootStackParamList, 'Printer'>;

export const PrinterScreen = memo(() => {
  const {
    params: { printer },
  } = useRoute<PrinterRouteProp>();

  const navigation = useNavigation<PrinterNavigationProp>();

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
          loading={false}
          title="Simple Print"
          onPress={() => navigation.navigate('SimplePrint', { printer })}
        />
        <Button
          loading={false}
          title="Print From View"
          onPress={() => navigation.navigate('PrintFromView', { printer })}
          topOffset
        />
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
  },

  contentCotainer: {
    alignItems: 'center',
    justifyContent: 'center',
  },

  errorText: {
    color: 'red',
    fontSize: 16,
    marginTop: 20,
  },
});
