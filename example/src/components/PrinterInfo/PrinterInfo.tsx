import React from 'react';
import { Text, View } from 'react-native';
import { styles } from './styles';

interface Printer {
  deviceType: string;
  target: string;
  deviceName: string;
  ipAddress: string;
  macAddress: string;
  bdAddress: string;
}

interface PrinterInfoProps<T> {
  printer: T;
}

export const PrinterInfo = <T extends Printer>({
  printer,
}: PrinterInfoProps<T>) => {
  const renderPrinterInfo = () => {
    return Object.keys(printer).map((key) => {
      return (
        <Text style={styles.text}>
          <Text style={[styles.text, styles.bold]}>{key}</Text>: {printer[key]}
        </Text>
      );
    });
  };

  return <View style={styles.container}>{renderPrinterInfo()}</View>;
};
