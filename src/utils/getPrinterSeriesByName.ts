import { PRINTER_SERIES } from '../constants';
import type { PrinterSeriesName } from '../types';

export function getPrinterSeriesByName(printerName: string): PrinterSeriesName {
  const keys = Object.keys(PRINTER_SERIES);
  const seriesName = keys.find((series) => {
    const [, , model] = series.split('_');
    return printerName.toLowerCase().includes(model?.toLowerCase?.());
  }) as PrinterSeriesName | undefined;

  return seriesName || 'EPOS2_TM_T88';
}
