import { Text, TouchableOpacity, ActivityIndicator, View } from 'react-native';
import { styles } from './styles';

interface ButtonProps {
  onPress: () => void;
  title: string;
  loading: boolean;
  topOffset?: boolean;
}
export const Button = ({
  onPress,
  title,
  loading,
  topOffset = false,
}: ButtonProps) => {
  return (
    <TouchableOpacity
      onPress={onPress}
      activeOpacity={0.6}
      style={[styles.container, topOffset && styles.containerSpace]}
      disabled={loading}
    >
      <Text style={[styles.text, loading && styles.hidden]}>{title}</Text>
      {loading ? (
        <View style={styles.loadingContainer}>
          <ActivityIndicator size="small" />
        </View>
      ) : null}
    </TouchableOpacity>
  );
};
