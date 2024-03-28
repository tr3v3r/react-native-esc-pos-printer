import type { Printer } from '../Printer';
import type { PrinterStatusResponse } from '../types';

export async function tryToConnectUntil(
  printer: Printer,
  predicate: (status: PrinterStatusResponse) => boolean
) {
  async function connect() {
    try {
      await printer.connect(1500);
    } catch (error) {}
    const status = await printer.getStatus();

    if (!predicate(status)) {
      await connect();
    }
  }

  return connect();
}
