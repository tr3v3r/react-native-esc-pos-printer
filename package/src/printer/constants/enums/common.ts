import { EscPosPrinter } from '../../../specs';

const EscPosPrinterConstants = EscPosPrinter.getConstants();

export enum CommonParams {
  PARAM_DEFAULT = EscPosPrinterConstants.PARAM_DEFAULT,
  PARAM_UNSPECIFIED = EscPosPrinterConstants.PARAM_UNSPECIFIED,
  TRUE = EscPosPrinterConstants.PRINTER_TRUE,
  FALSE = EscPosPrinterConstants.PRINTER_FALSE,
  UNKNOWN = EscPosPrinterConstants.UNKNOWN,
}

export enum ColorType {
  COLOR_NONE = EscPosPrinterConstants.COLOR_NONE,
  COLOR_1 = EscPosPrinterConstants.COLOR_1,
  COLOR_2 = EscPosPrinterConstants.COLOR_2,
  COLOR_3 = EscPosPrinterConstants.COLOR_3,
  COLOR_4 = EscPosPrinterConstants.COLOR_4,
}

export enum TextLangType {
  LANG_EN = EscPosPrinterConstants.LANG_EN,
  LANG_JA = EscPosPrinterConstants.LANG_JA,
  LANG_ZH_CN = EscPosPrinterConstants.LANG_ZH_CN,
  LANG_ZH_TW = EscPosPrinterConstants.LANG_ZH_TW,
  LANG_KO = EscPosPrinterConstants.LANG_KO,
  LANG_TH = EscPosPrinterConstants.LANG_TH,
  LANG_VI = EscPosPrinterConstants.LANG_VI,
  LANG_MULTI = EscPosPrinterConstants.LANG_MULTI,
}

export enum PrinterModelLang {
  MODEL_ANK = EscPosPrinterConstants.MODEL_ANK,
  MODEL_CHINESE = EscPosPrinterConstants.MODEL_CHINESE,
  MODEL_TAIWAN = EscPosPrinterConstants.MODEL_TAIWAN,
  MODEL_KOREAN = EscPosPrinterConstants.MODEL_KOREAN,
  MODEL_THAI = EscPosPrinterConstants.MODEL_THAI,
  MODEL_SOUTHASIA = EscPosPrinterConstants.MODEL_SOUTHASIA,
}

export enum PrinterAddCutType {
  CUT_FEED = EscPosPrinterConstants.CUT_FEED,
  CUT_NO_FEED = EscPosPrinterConstants.CUT_NO_FEED,
  CUT_RESERVE = EscPosPrinterConstants.CUT_RESERVE,
  FULL_CUT_FEED = EscPosPrinterConstants.FULL_CUT_FEED,
  FULL_CUT_NO_FEED = EscPosPrinterConstants.FULL_CUT_NO_FEED,
  FULL_CUT_RESERVE = EscPosPrinterConstants.FULL_CUT_RESERVE,
}

export enum PrinterErrorResult {
  ERR_PARAM = EscPosPrinterConstants.ERR_PARAM,
  ERR_MEMORY = EscPosPrinterConstants.ERR_MEMORY,
  ERR_UNSUPPORTED = EscPosPrinterConstants.ERR_UNSUPPORTED,
  ERR_FAILURE = EscPosPrinterConstants.ERR_FAILURE,
  ERR_PROCESSING = EscPosPrinterConstants.ERR_PROCESSING,
  ERR_CONNECT = EscPosPrinterConstants.ERR_CONNECT,
  ERR_TIMEOUT = EscPosPrinterConstants.ERR_TIMEOUT,
  ERR_ILLEGAL = EscPosPrinterConstants.ERR_ILLEGAL,
  ERR_NOT_FOUND = EscPosPrinterConstants.ERR_NOT_FOUND,
  ERR_IN_USE = EscPosPrinterConstants.ERR_IN_USE,
  ERR_TYPE_INVALID = EscPosPrinterConstants.ERR_TYPE_INVALID,
  ERR_RECOVERY_FAILURE = EscPosPrinterConstants.ERR_RECOVERY_FAILURE,
  ERR_DISCONNECT = EscPosPrinterConstants.ERR_DISCONNECT,
  ERR_INIT = EscPosPrinterConstants.ERR_INIT,
}
export enum PrinterErrorCodeResult {
  CODE_ERR_AUTORECOVER = EscPosPrinterConstants.CODE_ERR_AUTORECOVER,
  CODE_ERR_COVER_OPEN = EscPosPrinterConstants.CODE_ERR_COVER_OPEN,
  CODE_ERR_CUTTER = EscPosPrinterConstants.CODE_ERR_CUTTER,
  CODE_ERR_MECHANICAL = EscPosPrinterConstants.CODE_ERR_MECHANICAL,
  CODE_ERR_EMPTY = EscPosPrinterConstants.CODE_ERR_EMPTY,
  CODE_ERR_UNRECOVERABLE = EscPosPrinterConstants.CODE_ERR_UNRECOVERABLE,
  CODE_ERR_FAILURE = EscPosPrinterConstants.CODE_ERR_FAILURE,
  CODE_ERR_NOT_FOUND = EscPosPrinterConstants.CODE_ERR_NOT_FOUND,
  CODE_ERR_SYSTEM = EscPosPrinterConstants.CODE_ERR_SYSTEM,
  CODE_ERR_PORT = EscPosPrinterConstants.CODE_ERR_PORT,
  CODE_ERR_TIMEOUT = EscPosPrinterConstants.CODE_ERR_TIMEOUT,
  CODE_ERR_JOB_NOT_FOUND = EscPosPrinterConstants.CODE_ERR_JOB_NOT_FOUND,
  CODE_ERR_SPOOLER = EscPosPrinterConstants.CODE_ERR_SPOOLER,
  CODE_ERR_BATTERY_LOW = EscPosPrinterConstants.CODE_ERR_BATTERY_LOW,
  CODE_ERR_TOO_MANY_REQUESTS = EscPosPrinterConstants.CODE_ERR_TOO_MANY_REQUESTS,
  CODE_ERR_REQUEST_ENTITY_TOO_LARGE = EscPosPrinterConstants.CODE_ERR_REQUEST_ENTITY_TOO_LARGE,
  CODE_ERR_WAIT_REMOVAL = EscPosPrinterConstants.CODE_ERR_WAIT_REMOVAL,
  CODE_PRINTING = EscPosPrinterConstants.CODE_PRINTING,
  CODE_ERR_PARAM = EscPosPrinterConstants.CODE_ERR_PARAM,
  CODE_ERR_MEMORY = EscPosPrinterConstants.CODE_ERR_MEMORY,
  CODE_ERR_PROCESSING = EscPosPrinterConstants.CODE_ERR_PROCESSING,
  CODE_ERR_ILLEGAL = EscPosPrinterConstants.CODE_ERR_ILLEGAL,
  CODE_ERR_DEVICE_BUSY = EscPosPrinterConstants.CODE_ERR_DEVICE_BUSY,
}
