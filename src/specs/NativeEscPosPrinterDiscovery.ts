import type { TurboModule } from 'react-native';
import { TurboModuleRegistry } from 'react-native';
import type { EventEmitter } from 'react-native/Libraries/Types/CodegenTypes';

export interface Spec extends TurboModule {
  readonly getConstants: () => {
    PORTTYPE_ALL: number;
    PORTTYPE_TCP: number;
    PORTTYPE_BLUETOOTH: number;
    PORTTYPE_USB: number;
    PORTTYPE_BLUETOOTH_LE: number;
    MODEL_ALL: number;
    TYPE_ALL: number;
    TYPE_PRINTER: number;
    TYPE_HYBRID_PRINTER: number;
    TYPE_DISPLAY: number;
    TYPE_KEYBOARD: number;
    TYPE_SCANNER: number;
    TYPE_SERIAL: number;
    TYPE_POS_KEYBOARD: number;
    TYPE_MSR: number;
    TYPE_GFE: number;
    TYPE_OTHER_PERIPHERAL: number;
    ERR_PARAM: number;
    ERR_ILLEGAL: number;
    ERR_MEMORY: number;
    ERR_FAILURE: number;
    ERR_PROCESSING: number;
    BT_ERR_PARAM: number;
    BT_ERR_UNSUPPORTED: number;
    BT_ERR_CANCEL: number;
    BT_ERR_ILLEGAL_DEVICE: number;
    FILTER_NONE: number;
    FILTER_NAME: number;
    PRINTER_TRUE: number;
    PRINTER_FALSE: number;
  };
  startDiscovery(filterOption: Object): Promise<void>;
  stopDiscovery(): Promise<void>;
  enableLocationSetting(): Promise<void>;
  pairBluetoothDevice(macAddress: string): Promise<void>;

  readonly onDiscovery: EventEmitter<Array<Object>>;
  readonly enableLocationSettingSuccess: EventEmitter<void>;
  readonly enableLocationSettingFailure: EventEmitter<void>;
}

export default TurboModuleRegistry.getEnforcing<Spec>('EscPosPrinterDiscovery');
