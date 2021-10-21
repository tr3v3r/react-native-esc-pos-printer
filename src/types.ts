export interface IPrinter {
  name: string;
  ip: string;
  mac: string;
  target: string;
  bt: string;
  usb: string;
  usbSerialNumber?: string;
}

export type PrinerEvents =
  | 'onDiscoveryDone'
  | 'onPrintSuccess'
  | 'onPrintFailure';

export type EventListenerCallback = (printers: IPrinter[]) => void;

export type PrinterSeriesName =
  | 'EPOS2_TM_M10'
  | 'EPOS2_TM_M30'
  | 'EPOS2_TM_P20'
  | 'EPOS2_TM_P60'
  | 'EPOS2_TM_P60II'
  | 'EPOS2_TM_P80'
  | 'EPOS2_TM_T20'
  | 'EPOS2_TM_T60'
  | 'EPOS2_TM_T70'
  | 'EPOS2_TM_T81'
  | 'EPOS2_TM_T82'
  | 'EPOS2_TM_T83'
  | 'EPOS2_TM_T88'
  | 'EPOS2_TM_T90'
  | 'EPOS2_TM_T90KP'
  | 'EPOS2_TM_U220'
  | 'EPOS2_TM_U330'
  | 'EPOS2_TM_L90'
  | 'EPOS2_TM_H6000'
  | 'EPOS2_TM_T83III'
  | 'EPOS2_TM_T100'
  | 'EPOS2_TM_M30II'
  | 'EPOS2_TS_100'
  | 'EPOS2_TM_M50';

export type PrinterLanguage =
  | 'EPOS2_LANG_EN'
  | 'EPOS2_LANG_JA'
  | 'EPOS2_LANG_ZH_CN'
  | 'EPOS2_LANG_ZH_TW'
  | 'EPOS2_LANG_KO'
  | 'EPOS2_LANG_TH'
  | 'EPOS2_LANG_VI'
  | 'EPOS2_LANG_MULTI';

export interface IPrinterInitParams {
  target: string;
  seriesName: PrinterSeriesName;
  language?: PrinterLanguage;
}

export interface IDiscoverParams {
  usbSerialNumber?: boolean;
}

export interface IMonitorStatus {
  connection: 'DISCONNECT' | 'DISCONNECT' | 'UNKNOWN';
  online: 'OFFLINE' | 'OFFLINE' | 'UNKNOWN';
  coverOpen: 'COVER_OPEN' | 'COVER_CLOSE' | 'UNKNOWN';
  paper: 'PAPER_OK' | 'PAPER_NEAR_END' | 'PAPER_EMPTY' | 'UNKNOWN';
  paperFeed: 'PAPER_FEED' | 'PAPER_STOP' | 'UNKNOWN';
  panelSwitch: 'SWITCH_ON' | 'SWITCH_OFF' | 'UNKNOWN';
  drawer: 'DRAWER_HIGH(Drawer close)' | 'DRAWER_LOW(Drawer open)' | 'UNKNOWN';
  errorStatus:
    | 'NO_ERR'
    | 'MECHANICAL_ERR'
    | 'AUTOCUTTER_ERR'
    | 'UNRECOVER_ERR'
    | 'AUTORECOVER_ERR'
    | 'UNKNOWN';
  autoRecoverErr:
    | 'HEAD_OVERHEAT'
    | 'MOTOR_OVERHEAT'
    | 'BATTERY_OVERHEAT'
    | 'WRONG_PAPER'
    | 'COVER_OPEN'
    | 'UNKNOWN';
  adapter: 'AC ADAPTER CONNECT' | 'AC ADAPTER DISCONNECT' | 'UNKNOWN';
  batteryLevel:
    | 'BATTERY_LEVEL_0'
    | 'BATTERY_LEVEL_1'
    | 'BATTERY_LEVEL_2'
    | 'BATTERY_LEVEL_3'
    | 'BATTERY_LEVEL_4'
    | 'BATTERY_LEVEL_5'
    | 'BATTERY_LEVEL_6'
    | 'UNKNOWN';
}
