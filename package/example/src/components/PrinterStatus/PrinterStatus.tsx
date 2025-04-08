import { memo } from 'react';
import { Text, View } from 'react-native';
import {
  type PrinterStatusResponse,
  PrinterConstants,
} from 'react-native-esc-pos-printer';
import { styles } from './styles';

interface PrinterStatusProps {
  status: PrinterStatusResponse;
}

export const PrinterStatus = memo(({ status }: PrinterStatusProps) => {
  const { connection, online, coverOpen, paper } = status;

  const renderRow = (
    title: string,
    isGreenIndicator: boolean,
    isYellowIndicator?: boolean
  ) => {
    return (
      <View style={styles.container}>
        <Text style={styles.text}>{title}</Text>
        <View
          style={[
            styles.indicator,
            isGreenIndicator ? styles.indicatorGreen : styles.indicatorRed,
            isYellowIndicator && styles.indicatorYellow,
          ]}
        />
      </View>
    );
  };

  return (
    <View style={[styles.container, styles.contentContainer]}>
      {renderRow('Connected', connection.statusCode === PrinterConstants.TRUE)}
      {renderRow('Online', online.statusCode === PrinterConstants.TRUE)}
      {renderRow('Cover open', coverOpen.statusCode === PrinterConstants.FALSE)}
      {renderRow(
        'Paper',
        paper.statusCode === PrinterConstants.PAPER_OK,
        paper.statusCode === PrinterConstants.PAPER_NEAR_END
      )}
    </View>
  );
});
