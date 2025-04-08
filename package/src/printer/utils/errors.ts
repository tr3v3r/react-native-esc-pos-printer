import { PrinterError } from '../../core';
import {
  PrinterErrorResult,
  type PrinterErrorMessageMapping,
  type PrinterErrorCodesMapping,
  PrinterErrorStatusMapping,
} from '../constants';
import type { ComplexErrorData, ComplexErrorRawData } from '../types';

export function throwProcessedError({
  methodName,
  errorCode,
  messagesMapping,
  statusMapping = PrinterErrorStatusMapping,
}: {
  methodName: string;
  errorCode: string;
  messagesMapping:
    | PrinterErrorMessageMapping
    | Record<string, PrinterErrorMessageMapping>;
  statusMapping?: PrinterErrorCodesMapping;
}) {
  const result = !isNaN(Number(errorCode))
    ? errorCode
    : PrinterErrorResult.ERR_FAILURE;

  const message = messagesMapping[result];
  const status = statusMapping[result];

  throw new PrinterError({
    status: status,
    message: message,
    methodName,
  });
}

export function processComplextError(message: string): ComplexErrorData {
  try {
    const { type, data } = JSON.parse(message) as ComplexErrorRawData;

    return { errorType: type, data: String(data) };
  } catch (error) {
    return {
      errorType: 'result',
      data: message,
    };
  }
}
