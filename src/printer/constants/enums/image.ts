import { NativeModules } from 'react-native';

const { EscPosPrinter } = NativeModules;

const EscPosPrinterConstants: Record<string, number> =
  EscPosPrinter.getConstants();

export enum ImageColorModeType {
  MODE_MONO = EscPosPrinterConstants.MODE_MONO,
  MODE_GRAY16 = EscPosPrinterConstants.MODE_GRAY16,
  MODE_MONO_HIGH_DENSITY = EscPosPrinterConstants.MODE_MONO_HIGH_DENSITY,
}

export enum ImageHalftoneType {
  HALFTONE_DITHER = EscPosPrinterConstants.HALFTONE_DITHER,
  HALFTONE_ERROR_DIFFUSION = EscPosPrinterConstants.HALFTONE_ERROR_DIFFUSION,
  HALFTONE_THRESHOLD = EscPosPrinterConstants.HALFTONE_THRESHOLD,
}

export enum ImageCompressType {
  COMPRESS_DEFLATE = EscPosPrinterConstants.COMPRESS_DEFLATE,
  COMPRESS_NONE = EscPosPrinterConstants.COMPRESS_NONE,
  COMPRESS_AUTO = EscPosPrinterConstants.COMPRESS_AUTO,
}
