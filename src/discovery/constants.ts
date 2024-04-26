import { NativeModules, Platform } from 'react-native';
import { remapConstants } from '../core/utils';

const { EscPosPrinterDiscovery } = NativeModules;

export const DEFAULT_DISCOVERY_TIMEOUT = Platform.OS === 'ios' ? 5000 : 10000;

const DiscoveryModuleConstants: Record<string, number> =
  EscPosPrinterDiscovery.getConstants();

export enum DiscoveryDeviceType {
  TYPE_ALL = DiscoveryModuleConstants.TYPE_ALL,
  TYPE_PRINTER = DiscoveryModuleConstants.TYPE_PRINTER,
  TYPE_HYBRID_PRINTER = DiscoveryModuleConstants.TYPE_HYBRID_PRINTER,
  TYPE_DISPLAY = DiscoveryModuleConstants.TYPE_DISPLAY,
  TYPE_KEYBOARD = DiscoveryModuleConstants.TYPE_KEYBOARD,
  TYPE_SCANNER = DiscoveryModuleConstants.TYPE_SCANNER,
  TYPE_SERIAL = DiscoveryModuleConstants.TYPE_SERIAL,
  TYPE_POS_KEYBOARD = DiscoveryModuleConstants.TYPE_POS_KEYBOARD,
  TYPE_MSR = DiscoveryModuleConstants.TYPE_MSR,
  TYPE_GFE = DiscoveryModuleConstants.TYPE_GFE,
  TYPE_OTHER_PERIPHERAL = DiscoveryModuleConstants.TYPE_OTHER_PERIPHERAL,
}

export enum DiscoveryFilterType { // Android only
  FILTER_NAME = DiscoveryModuleConstants.FILTER_NAME,
  FILTER_NONE = DiscoveryModuleConstants.FILTER_NONE,
}
export enum DiscoveryPortType {
  PORTTYPE_ALL = DiscoveryModuleConstants.PORTTYPE_ALL,
  PORTTYPE_TCP = DiscoveryModuleConstants.PORTTYPE_TCP,
  PORTTYPE_BLUETOOTH = DiscoveryModuleConstants.PORTTYPE_BLUETOOTH,
  PORTTYPE_USB = DiscoveryModuleConstants.PORTTYPE_USB,

  PORTTYPE_BLUETOOTH_LE = DiscoveryModuleConstants.PORTTYPE_BLUETOOTH_LE, // iOS only
}

export enum DiscoveryDeviceModel {
  MODEL_ALL = DiscoveryModuleConstants.MODEL_ALL,
}

export enum DiscoveryBooleanParams { // Android only
  TRUE = DiscoveryModuleConstants.TRUE,
  FALSE = DiscoveryModuleConstants.FALSE,
}

export enum PrinterPairBluetoothError {
  BT_ERR_PARAM = DiscoveryModuleConstants.BT_ERR_PARAM,
  BT_ERR_UNSUPPORTED = DiscoveryModuleConstants.BT_ERR_UNSUPPORTED,
  BT_ERR_CANCEL = DiscoveryModuleConstants.BT_ERR_CANCEL,
  BT_ERR_ILLEGAL_DEVICE = DiscoveryModuleConstants.BT_ERR_ILLEGAL_DEVICE,
  ERR_FAILURE = DiscoveryModuleConstants.ERR_FAILURE,
}

export const DiscoveryFilterOption = {
  ...DiscoveryDeviceType,
  ...DiscoveryFilterType,
  ...DiscoveryPortType,
  ...DiscoveryDeviceModel,
  ...DiscoveryBooleanParams,
} as const;

export enum DiscoveryErrorResult {
  ERR_PARAM = DiscoveryModuleConstants.ERR_PARAM,
  ERR_ILLEGAL = DiscoveryModuleConstants.ERR_ILLEGAL,
  ERR_MEMORY = DiscoveryModuleConstants.ERR_MEMORY,
  ERR_FAILURE = DiscoveryModuleConstants.ERR_FAILURE,
  ERR_PROCESSING = DiscoveryModuleConstants.ERR_PROCESSING,
  PERMISSION_ERROR = -2,
}

export const DiscoveryErrorMessageMapping = {
  [DiscoveryErrorResult.ERR_PARAM]: 'An invalid parameter was passed.',
  [DiscoveryErrorResult.ERR_ILLEGAL]:
    'Tried to start search when search had been already done.' +
    (Platform.OS === 'android'
      ? '\nBluetooth is OFF\nThere is no permission for the position information'
      : ''),
  [DiscoveryErrorResult.ERR_MEMORY]:
    'Memory necessary for processing could not be allo- cated.',
  [DiscoveryErrorResult.ERR_FAILURE]: 'An unknown error occurred.',
  [DiscoveryErrorResult.ERR_PROCESSING]: 'Could not run the process.',

  [DiscoveryErrorResult.PERMISSION_ERROR]: 'Permission error',
};

export const PrinterPairBluetoothErrorMessageMapping = {
  [PrinterPairBluetoothError.BT_ERR_CANCEL]: 'Pairing connection was canceled.',
  [PrinterPairBluetoothError.BT_ERR_PARAM]: 'An invalid parameter was passed.',
  [PrinterPairBluetoothError.BT_ERR_UNSUPPORTED]:
    'The function was executed on an unsupported OS.',
  [PrinterPairBluetoothError.BT_ERR_ILLEGAL_DEVICE]:
    'An invalid device was selected.',
  [DiscoveryErrorResult.ERR_FAILURE]: 'An unknown error occurred.',
};

export const DiscoveryErrorStatusMapping = remapConstants(DiscoveryErrorResult);
export const PrinterPairBluetoothErrorStatusMapping = remapConstants(
  PrinterPairBluetoothError
);

export const DiscoveryDeviceTypeMapping = remapConstants(DiscoveryDeviceType);
