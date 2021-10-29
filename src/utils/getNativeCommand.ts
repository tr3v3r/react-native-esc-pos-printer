import { nativeConstants } from '../constants';

export function getNativeCommand(command: string) {
  return nativeConstants[command];
}
