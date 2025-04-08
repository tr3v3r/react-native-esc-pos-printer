import { spaceBetween, getFontACharsPerLine } from '../utils';
import type { Printer } from '../Printer';
import type { SpaceBetweenParams } from '../types';
import { PrinterConstants, DEFAULT_PAPER_WIDTH } from '../constants';

export async function addTextLine(
  printer: Printer,
  params: SpaceBetweenParams,
  customCharsPerLine?: number
) {
  const printerCharsPerLinePerWidth = getFontACharsPerLine(printer.deviceName);
  const { value: paperWidth } = await printer.getPrinterSetting(
    PrinterConstants.PRINTER_SETTING_PAPERWIDTH
  );

  const charsPerLine = customCharsPerLine
    ? customCharsPerLine
    : printerCharsPerLinePerWidth[paperWidth || DEFAULT_PAPER_WIDTH];

  const text = spaceBetween(
    Math.ceil(charsPerLine / printer.currentFontWidth),
    params
  );

  await printer.addText(text);
}
