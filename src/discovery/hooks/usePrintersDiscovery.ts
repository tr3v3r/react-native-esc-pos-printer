import { useCallback, useEffect, useState } from 'react';
import { PrintersDiscovery } from '../PrintersDiscovery';
import type { DeviceInfo, DiscoveryStartParams } from '../types';
import type { PrinterDiscoveryError } from '../../core/errors';

export function usePrintersDiscovery() {
  const [printers, setPrinters] = useState<DeviceInfo[]>([]);
  const [isDiscovering, setIsDescovering] = useState<boolean>(false);
  const [printerError, setPrinterError] =
    useState<PrinterDiscoveryError | null>(null);

  useEffect(() => {
    const removeListener = PrintersDiscovery.onDiscovery(
      (deviceInfo: DeviceInfo[]) => {
        setPrinters(deviceInfo);
      }
    );

    return () => {
      removeListener();
    };
  }, []);

  useEffect(() => {
    const removeListener = PrintersDiscovery.onStatusChange((status) => {
      const isNextDiscovering = status === 'discovering';
      if (isNextDiscovering) {
        setPrinters([]);
        setPrinterError(null);
      }
      setIsDescovering(isNextDiscovering);
    });

    return () => {
      removeListener();
    };
  }, []);

  useEffect(() => {
    const removeListener = PrintersDiscovery.onError((error) => {
      setPrinterError(error);
    });

    return () => {
      removeListener();
    };
  }, []);

  const start = useCallback((params?: DiscoveryStartParams) => {
    PrintersDiscovery.start(params);
  }, []);

  const stop = useCallback(() => {
    PrintersDiscovery.stop();
  }, []);

  const pairBluetoothDevice = useCallback(async (macAddress?: string) => {
    await PrintersDiscovery.pairBluetoothDevice(macAddress);
  }, []);

  return {
    printers,
    isDiscovering,
    printerError,
    start,
    stop,
    pairBluetoothDevice,
  };
}
