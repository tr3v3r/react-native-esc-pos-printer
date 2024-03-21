import {
  GetPrinterStatusMessageMapping,
  PrinterStatusMapping,
} from '../../constants';
import type {
  PrinterStatusRawResponse,
  PrinterStatusResponse,
} from '../../types';

export function parsePrinterStatus(
  response: PrinterStatusRawResponse
): PrinterStatusResponse {
  return Object.keys(response).reduce((acc, propName) => {
    const statusCode = response[propName];
    const message = GetPrinterStatusMessageMapping[propName][statusCode];
    const status = PrinterStatusMapping[propName][statusCode];
    acc[propName] = { status, message, statusCode: Number(statusCode) };
    return acc;
  }, {} as PrinterStatusResponse);
}
