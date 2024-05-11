import type { Printer } from '../Printer';
import type { PrinterStatusResponse } from '../types';

function wait(ms: number) {
  return new Promise((resolve) => {
    setTimeout(resolve, ms);
  });
}

export function monitorPrinter(
  printer: Printer,
  listener: (status: PrinterStatusResponse) => void,
  interval: number = 5000
) {
  let isMonitoring = true;

  async function performMonitor() {
    await printer.addQueueTask(async () => {
      try {
        await printer.connect();
      } catch (error) {}
      const status = await printer.getStatus();
      listener(status);
      await printer.disconnect();

      return status;
    });

    await wait(interval);

    if (isMonitoring) {
      await performMonitor();
    }
  }

  performMonitor();

  return () => {
    isMonitoring = false;
  };
}
