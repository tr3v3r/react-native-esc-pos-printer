export function remapConstants<T extends object>(
  constants: T
): Record<string, keyof T> {
  return Object.keys(constants).reduce(
    (acc, key) => {
      const value = constants[key as keyof T];
      acc[String(value)] = key as keyof T;
      return acc;
    },
    {} as Record<string, keyof T>
  );
}
