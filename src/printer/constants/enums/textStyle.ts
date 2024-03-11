import { NativeModules } from 'react-native';
import { CommonParams } from './common';

const { EscPosPrinter } = NativeModules;

const EscPosPrinterConstants: Record<string, number> =
  EscPosPrinter.getConstants();

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

export enum TextReverseType {
  TRUE = CommonParams.TRUE,
  FALSE = CommonParams.FALSE,
  PARAM_UNSPECIFIED = CommonParams.PARAM_UNSPECIFIED,
  PARAM_DEFAULT = CommonParams.PARAM_DEFAULT,
}

export enum TextUnderscoreType {
  TRUE = CommonParams.TRUE,
  FALSE = CommonParams.FALSE,
  PARAM_UNSPECIFIED = CommonParams.PARAM_UNSPECIFIED,
  PARAM_DEFAULT = CommonParams.PARAM_DEFAULT,
}

export enum TextBoldType {
  TRUE = CommonParams.TRUE,
  FALSE = CommonParams.FALSE,
  PARAM_UNSPECIFIED = CommonParams.PARAM_UNSPECIFIED,
  PARAM_DEFAULT = CommonParams.PARAM_DEFAULT,
}
