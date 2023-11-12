import React from 'react';

import { Pressable, Text } from 'react-native';
import type { DeviceInfo } from 'react-native-esc-pos-printer';
import { styles } from './styles';
interface PrinterItemProps {
  printer: DeviceInfo;
  onPress: (printer: DeviceInfo) => void;
}

export const PrinterItem = ({ printer, onPress }: PrinterItemProps) => {
  return (
    <Pressable onPress={() => onPress(printer)} style={styles.container}>
      <Text style={styles.title}>{printer.deviceName}</Text>
      <Text style={styles.subtitle}>target: {printer.target}</Text>
    </Pressable>
  );
};
