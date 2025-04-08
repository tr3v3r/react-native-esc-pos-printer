import { Text, View } from 'react-native';
import { styles } from './styles';
import type { DeviceInfo } from 'react-native-esc-pos-printer';

interface PrinterInfoProps {
  printer: DeviceInfo;
}

export const PrinterInfo = ({ printer }: PrinterInfoProps) => {
  const renderPrinterInfo = () => {
    return Object.keys(printer).map((key) => {
      return (
        <Text key={key} style={styles.text}>
          <Text style={[styles.text, styles.bold]}>{key}</Text>: {printer[key]}
        </Text>
      );
    });
  };

  return <View style={styles.container}>{renderPrinterInfo()}</View>;
};
