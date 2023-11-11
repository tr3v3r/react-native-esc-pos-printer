import React from 'react';

import { FlatList, View } from 'react-native';
import { PrinterItem } from '../PrinterItem';
import { styles } from './styles';

export const PrintersList = ({ printers, onPress }) => {
  const renderItem = ({ item }) => {
    return <PrinterItem printer={item} onPress={onPress} />;
  };

  return (
    <View style={styles.container}>
      <FlatList data={printers} renderItem={renderItem} />
    </View>
  );
};
