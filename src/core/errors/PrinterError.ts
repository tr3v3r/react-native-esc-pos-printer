export class PrinterError extends Error {
  message: string = '';
  name: string = 'PrinterError';
  timestamp: number = 0;
  status: string = '';
  methodName: string = '';

  constructor(params: { status: string; message: string; methodName: string }) {
    super(params.message);
    Object.assign(this, params);
  }
}

PrinterError.prototype.name = 'PrinterError';
