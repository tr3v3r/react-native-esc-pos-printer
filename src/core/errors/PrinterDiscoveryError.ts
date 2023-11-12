export class PrinterDiscoveryError extends Error {
  message: string = '';
  name: string = 'PrinterDiscoveryError';
  timestamp: number = 0;
  status: string = '';
  methodName: string = '';

  constructor(params: { status: string; message: string; methodName: string }) {
    super(params.message);
    Object.assign(this, params);
  }
}

PrinterDiscoveryError.prototype.name = 'PrinterDiscoveryError';
