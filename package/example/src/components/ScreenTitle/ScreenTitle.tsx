import { Text } from 'react-native';
import { styles } from './styles';

export const ScreenTitle = ({ title }) => {
  return <Text style={styles.text}>{title}</Text>;
};
