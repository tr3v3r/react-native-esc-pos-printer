import { EscPosPrinter } from '../../../specs';

const EscPosPrinterConstants = EscPosPrinter.getConstants();

export enum FontType {
  FONT_A = EscPosPrinterConstants.FONT_A,
  FONT_B = EscPosPrinterConstants.FONT_B,
  FONT_C = EscPosPrinterConstants.FONT_C,
  FONT_D = EscPosPrinterConstants.FONT_D,
  FONT_E = EscPosPrinterConstants.FONT_E,
}

export enum TextAlignType {
  ALIGN_LEFT = EscPosPrinterConstants.ALIGN_LEFT,
  ALIGN_CENTER = EscPosPrinterConstants.ALIGN_CENTER,
  ALIGN_RIGHT = EscPosPrinterConstants.ALIGN_RIGHT,
}

export enum PageDirectionType {
  DIRECTION_LEFT_TO_RIGHT = EscPosPrinterConstants.DIRECTION_LEFT_TO_RIGHT,
  DIRECTION_BOTTOM_TO_TOP = EscPosPrinterConstants.DIRECTION_BOTTOM_TO_TOP,
  DIRECTION_RIGHT_TO_LEFT = EscPosPrinterConstants.DIRECTION_RIGHT_TO_LEFT,
  DIRECTION_TOP_TO_BOTTOM = EscPosPrinterConstants.DIRECTION_TOP_TO_BOTTOM,
}
