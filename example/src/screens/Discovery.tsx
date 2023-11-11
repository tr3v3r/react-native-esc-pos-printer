import React, { memo } from 'react';
import { View, Button, SafeAreaView } from 'react-native';
import {
  usePrintersDiscovery,
  DiscoveryFilterOption,
} from 'react-native-esc-pos-printer';

export const Discovery = memo(() => {
  const {
    start,
    printerError,
    isDiscovering,
    printers,
  } = usePrintersDiscovery();
  console.log(isDiscovering, printerError);
  return (
    <SafeAreaView style={{ flex: 1 }}>
      <View>
        <Button title="Discover" onPress={() => start()} />
      </View>
    </SafeAreaView>
  );
});
