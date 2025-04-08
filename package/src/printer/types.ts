import type { View } from 'react-native';
import type {
  PrinterModelLang,
  ColorType,
  ImageCompressType,
  ImageHalftoneType,
  ImageColorModeType,
  PrinterAddCutType,
  FontType,
  BarcodeType,
  BarcodeHRI,
  PrinterAddPulseDrawerType,
  PrinterAddPulseTimeType,
  TextAlignType,
  CommonParams,
  TextLangType,
} from './constants';

import { SymbolLevel, SymbolType } from './constants/enums/symbol';

export type PrinterParams = {
  target: string;
  deviceName: string;
  lang?: PrinterModelLang;
};

export type PrinterInitParams = {
  deviceName: string;
  lang: PrinterModelLang;
};

export type PrinterSettingsRawResponse = {
  type: number;
  value: number;
};

export type PrinterSettingsResponse = {
  typeCode: number;
  type: string;
  value: number;
};

export type ComplexErrorRawData = {
  type: 'code' | 'result';
  data: number;
};

export type ComplexErrorData = {
  errorType: 'code' | 'result';
  data: string;
};

export type PrinterStatusProperties =
  | 'connection'
  | 'online'
  | 'coverOpen'
  | 'paper'
  | 'paperFeed'
  | 'panelSwitch'
  | 'drawer'
  | 'errorStatus'
  | 'autoRecoverError'
  | 'buzzer'
  | 'adapter'
  | 'batteryLevel'
  | 'removalWaiting'
  | 'paperTakenSensor'
  | 'unrecoverError';

export type DefaultOrUnspecifiedParam =
  | CommonParams.PARAM_DEFAULT
  | CommonParams.PARAM_UNSPECIFIED;

export type TrueFalseParam = CommonParams.TRUE | CommonParams.FALSE;

export type PrinterStatusRawResponse = Record<PrinterStatusProperties, string>;
export type PrinterStatusResponse = Record<
  PrinterStatusProperties,
  { status: string; message: string; statusCode: number }
>;

export type ImageSource =
  | number
  | {
      uri: string;
    };

export type AddImageParams = {
  source: ImageSource;
  width: number;
  color?: ColorType | CommonParams.PARAM_DEFAULT;
  mode?: ImageColorModeType | CommonParams.PARAM_DEFAULT;
  halftone?: ImageHalftoneType | CommonParams.PARAM_DEFAULT;
  brightness?: number | CommonParams.PARAM_DEFAULT;
  compress?: ImageCompressType | CommonParams.PARAM_DEFAULT;
};

export type AddBarcodeParams = {
  data: string;
  type: BarcodeType;
  hri?: BarcodeHRI | DefaultOrUnspecifiedParam;
  font?: FontType | DefaultOrUnspecifiedParam;
  width?: number | CommonParams.PARAM_UNSPECIFIED;
  height?: number | CommonParams.PARAM_UNSPECIFIED;
};

export type AddSymbolParams = {
  type: SymbolType;
  width?: number;
  data: string;
  level?: SymbolLevel | DefaultOrUnspecifiedParam;
  height?: number;
  size: number;
};

export type AddCutTypeParam = PrinterAddCutType | CommonParams.PARAM_DEFAULT;

export interface AddPulseParams {
  drawer?: PrinterAddPulseDrawerType | CommonParams.PARAM_DEFAULT;
  time?: PrinterAddPulseTimeType | CommonParams.PARAM_DEFAULT;
}

export type AddTextAlignParam = TextAlignType | CommonParams.PARAM_DEFAULT;
export type AddTextSizeParams = {
  width?: number | DefaultOrUnspecifiedParam;
  height?: number | DefaultOrUnspecifiedParam;
};

export type AddTextSmoothParam = TrueFalseParam | CommonParams.PARAM_DEFAULT;

export type AddTextStyleParams = {
  reverse?: TrueFalseParam | DefaultOrUnspecifiedParam;
  ul?: TrueFalseParam | DefaultOrUnspecifiedParam;
  em?: TrueFalseParam | DefaultOrUnspecifiedParam;
  color?: ColorType | DefaultOrUnspecifiedParam;
};

export interface SpaceBetweenParams {
  left: string;
  right: string;
  textToWrap?: 'right' | 'left';
  textToWrapWidth?: number;
  gapSymbol?: string;
  noTrim?: boolean;
}

export interface AddViewShotParams {
  viewNode: View;
  width?: number;
}

export type AddTextLangParam = TextLangType | CommonParams.PARAM_DEFAULT;
