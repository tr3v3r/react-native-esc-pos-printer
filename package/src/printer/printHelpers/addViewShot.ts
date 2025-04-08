import { Platform } from 'react-native';
import type { Printer } from '../Printer';

import type { AddViewShotParams } from '../types';
import { PrinterConstants, FULL_IMAGE_WIDTH_RATIO } from '../constants';

export async function addViewShot(
  printer: Printer,
  { width, viewNode }: AddViewShotParams
) {
  let captureRef = null;
  try {
    const RNViewShot = require('react-native-view-shot');

    captureRef = RNViewShot.captureRef;
  } catch (error) {}

  if (!captureRef) {
    console.error('Install react-native-view-shot to use addViewShot');

    return;
  }

  const { value: paperWidth } = await printer.getPrinterSetting(
    PrinterConstants.PRINTER_SETTING_PAPERWIDTH
  );

  const imageBaset64Uri = await captureRef(viewNode, {
    result: 'base64',
  });

  await printer.addImage({
    source: {
      uri: 'data:image/png;base64,' + imageBaset64Uri,
    },
    color: PrinterConstants.COLOR_4,
    mode: PrinterConstants.MODE_GRAY16,
    halftone: PrinterConstants.HALFTONE_THRESHOLD,
    brightness: Platform.OS === 'ios' ? 0.3 : 0.1,
    width: width || FULL_IMAGE_WIDTH_RATIO * paperWidth,
  });
}
