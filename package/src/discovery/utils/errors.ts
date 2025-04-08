import { PrinterDiscoveryError } from '../../core';
import {
  DiscoveryErrorMessageMapping,
  DiscoveryErrorStatusMapping,
  PrinterPairBluetoothErrorMessageMapping,
  PrinterPairBluetoothErrorStatusMapping,
  DiscoveryErrorResult,
} from '../constants';

export function getProcessedError({
  methodName,
  errorCode,
  messagesMapping = DiscoveryErrorMessageMapping,
  statusMapping = DiscoveryErrorStatusMapping,
}: {
  methodName: string;
  errorCode: string;
  messagesMapping?:
    | typeof DiscoveryErrorMessageMapping
    | typeof PrinterPairBluetoothErrorMessageMapping;
  statusMapping?:
    | typeof DiscoveryErrorStatusMapping
    | typeof PrinterPairBluetoothErrorStatusMapping;
}) {
  const result = !isNaN(Number(errorCode))
    ? errorCode
    : DiscoveryErrorResult.ERR_FAILURE;

  const message = messagesMapping[result];
  const status = statusMapping[result];

  return new PrinterDiscoveryError({
    status: status,
    message: message,
    methodName,
  });
}
