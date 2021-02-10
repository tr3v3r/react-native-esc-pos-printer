export interface IPrinter {
  name: string;
  ip: string;
  mac: string;
  target: string;
  bt: string;
}

export type PrinerEvents =
  | 'onDiscoveryDone'
  | 'onPrintSuccess'
  | 'onPrintFailure';

export type EventListenerCallback = (printers: IPrinter[]) => void;
