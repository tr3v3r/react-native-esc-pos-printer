import { PRINTER_SERIES } from '../constants';

export function getPrinterSeriesByName(printerName: string): number {
  const keys = Object.keys(PRINTER_SERIES);
  const key = keys.find((series) => {
    const [, , model] = series.split('_');
    return printerName.toLowerCase().includes(model?.toLowerCase?.());
  });

  return key ? PRINTER_SERIES[key] : PRINTER_SERIES.EPOS2_TM_T88;
}
