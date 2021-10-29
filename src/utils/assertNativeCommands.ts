import { nativeConstants } from '../constants';

export function assertNativeCommands(commands: string[], context: string) {
  commands.forEach((command) => {
    if (typeof nativeConstants[command] !== 'number') {
      throw new Error(
        `Error: ${command} is not valide property value for ${context}`
      );
    }
  });
}
