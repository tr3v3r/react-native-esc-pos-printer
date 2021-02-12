import * as React from 'react';
import Encoder from 'esc-pos-encoder';

import { StyleSheet, View, Button } from 'react-native';
import EscPosPrinter from 'react-native-esc-pos-printer';
import {} from 'react-native';

export default function App() {
  const [init, setInit] = React.useState(false);
  return (
    <View style={styles.container}>
      <Button
        title="discover"
        onPress={() => {
          EscPosPrinter.discover().then(console.log).catch(console.log);
        }}
      />

      <Button
        title="testt"
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
            if (!init) {
              await EscPosPrinter.initLANprinter('192.168.1.6');
              setInit(true);
            }

            const status = await EscPosPrinter.printRawData(encoder.encode());

            console.log('print', status);
          } catch (error) {
            console.log('error', error.message);
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
