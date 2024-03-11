export function assertIntParamRange(
  value: number,
  from: number,
  to: number,
  paramName: string,
  message?: string
) {
  if (typeof value !== 'number' || value < from || value > to) {
    throw new Error(
      `Invalid value for ${paramName}${
        message ? ` ${message}` : ''
      }. Expected integer in range ${from} - ${to}.`
    );
  }
}
