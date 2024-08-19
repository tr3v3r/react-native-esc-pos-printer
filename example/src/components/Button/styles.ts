import { StyleSheet } from 'react-native';

export const styles = StyleSheet.create({
  container: {
    borderWidth: StyleSheet.hairlineWidth,
    borderRadius: 20,
    width: 300,
    paddingVertical: 20,
    justifyContent: 'center',
    alignItems: 'center',
  },

  containerSpace: {
    marginTop: 10,
  },

  text: {
    fontSize: 16,
    fontWeight: '600',
  },
  loadingContainer: {
    ...StyleSheet.absoluteFillObject,
    justifyContent: 'center',
    alignItems: 'center',
  },
  hidden: {
    opacity: 0,
  },
});
