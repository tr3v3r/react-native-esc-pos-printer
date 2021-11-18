import { nativeConstants } from '../constants';

export function getNativeCommand(command: string): number {
  return nativeConstants[command];
}
