import React from 'react';

import { Pressable, Text } from 'react-native';
import { styles } from './styles';
interface PrinterItemProps<T> {
  printer: T;
  onPress: (printer: T) => void;
}

export const PrinterItem = <T extends { name: string; target: string }>({
  printer,
  onPress,
}: PrinterItemProps<T>) => {
  return (
    <Pressable onPress={() => onPress(printer)} style={styles.container}>
      <Text style={styles.title}>{printer.name}</Text>
      <Text style={styles.subtitle}>target: {printer.target}</Text>
    </Pressable>
  );
};
