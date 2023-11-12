import type {
  DiscoveryDeviceType,
  DiscoveryFilterType,
  DiscoveryPortType,
  DiscoveryDeviceModel,
  DiscoveryBooleanParams,
} from './constants';
export type DiscoveryStatus = 'discovering' | 'inactive';

export type RawDeviceInfo = {
  deviceType: number;
  target: string;
  deviceName: string;
  ipAddress: string;
  macAddress: string;
  bdAddress: string;
};

export type DeviceInfo = {
  deviceType: keyof typeof DiscoveryDeviceType;
  target: string;
  deviceName: string;
  ipAddress: string;
  macAddress: string;
  bdAddress: string;
};

export type FilterOption = {
  /**
   * @type {number} - Selects the port to search.
   */
  portType?: DiscoveryPortType;
  /**
   * @type {string} - Specify a Broadcast Address for TCP search as a string. Defaults to "255.255.255.255"
   */
  broadcast?: string;
  /**
   * @type {number} - Specifies the device model to search for. Defaults to Discovery.EPOS2_MODEL_ALL
   */
  deviceModel?: DiscoveryDeviceModel;
  /**
   * @type {number} - Android only. Filters the search result by the Epson printers.
      Search can be performed for printers connected via Bluetooth or USB.
   */
  epsonFilter?: DiscoveryFilterType;
  /**
   * @type {number} - Specifies the device type to search for.
    The device type settings other than "Discovery.TYPE_ALL" can be used for the following systems con- nected using Wi-Fi or Ethernet.
    • Customer Display Models (SSL/TLS communication only)
    • TM Printer + DM-D + barcode scanner model
    • TM Printer + barcode scanner model
    • POS Terminal Model
   */
  deviceType?: DiscoveryDeviceType;
  /**
   * @type {number} - Android only. Specifies the search target when searching for a device that can be connected via Bluetooth. Defaults to Discovery.FALSE
   */
  bondedDevices?: DiscoveryBooleanParams;

  /**
   * @type {number} - Android only.  Specifies whether to search USB devices by their names or not.. Defaults to Discovery.FALSE
   */
  usbDeviceName?: DiscoveryBooleanParams;
};

export type DiscoveryStartParams = {
  /**
   * @type {boolean} - If true, the search will be automatically stopped after timeout is passed. Defaults to true
   */
  autoStop?: boolean;
  /**
   * @type {number} - Search will be automatically stopped after timeout is passed. Defaults to 5000ms
   */
  timeout?: number;
  /**
   * @type {object} - In order to filter the search result, set the filter option in the FilterOption type and specify it in the parameter. When filter is omited, search is run with the default settings.
   */
  filterOption?: FilterOption;
};
