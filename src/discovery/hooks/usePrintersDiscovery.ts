import { useCallback, useEffect, useState } from 'react';
import { PrintersDiscovery } from '../PrintersDiscovery';
import type { DeficeInfo, DiscoveryStartParams } from '../types';
import type { PrinterDiscoveryError } from '../../core/errors';

export function usePrintersDiscovery() {
  const [printers, setPrinters] = useState<DeficeInfo[]>([]);
  const [isDiscovering, setIsDescovering] = useState<boolean>(false);
  const [
    printerError,
    setPrinterError,
  ] = useState<PrinterDiscoveryError | null>(null);

  useEffect(() => {
    const removeListener = PrintersDiscovery.onDiscovery(
      (deviceInfo: DeficeInfo[]) => {
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

  return {
    printers,
    isDiscovering,
    printerError,
    start,
    stop,
  };
}
