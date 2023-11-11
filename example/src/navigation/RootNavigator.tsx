import * as React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { Discovery } from '../screens';
import type { DeficeInfo } from 'react-native-esc-pos-printer';

export type RootStackParamList = {
  Discovery: undefined;
  SimplePrint: {
    printer: DeficeInfo;
  };
};

const Stack = createNativeStackNavigator<RootStackParamList>();

export const RootNavigator = () => {
  return (
    <NavigationContainer>
      <Stack.Navigator>
        <Stack.Screen name="Discovery" component={Discovery} />
        <Stack.Screen name="SimplePrint" component={Discovery} />
      </Stack.Navigator>
    </NavigationContainer>
  );
};
