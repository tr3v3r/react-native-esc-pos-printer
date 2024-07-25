import { StyleSheet } from 'react-native';

export const styles = StyleSheet.create({
  contentContainer: {
    justifyContent: 'space-around',
  },
  indicator: {
    width: 6,
    height: 6,
    borderRadius: 5,
    marginRight: 15,
    marginLeft: 3,
  },
  indicatorGreen: {
    backgroundColor: 'green',
  },
  indicatorRed: {
    backgroundColor: 'red',
  },
  indicatorYellow: {
    backgroundColor: 'yellow',
  },
  container: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  text: {
    fontSize: 14,
    color: '#000',
  },
});
