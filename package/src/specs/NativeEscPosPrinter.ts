import type { TurboModule } from 'react-native';
import { TurboModuleRegistry } from 'react-native';

export interface Spec extends TurboModule {
  getConstants: () => {
    MODEL_ANK: number;
    MODEL_CHINESE: number;
    MODEL_TAIWAN: number;
    MODEL_KOREAN: number;
    MODEL_THAI: number;
    MODEL_SOUTHASIA: number;
    CUT_FEED: number;
    CUT_NO_FEED: number;
    CUT_RESERVE: number;
    FULL_CUT_FEED: number;
    FULL_CUT_NO_FEED: number;
    FULL_CUT_RESERVE: number;
    PARAM_DEFAULT: number;
    PARAM_UNSPECIFIED: number;
    ERR_PARAM: number;
    ERR_MEMORY: number;
    ERR_UNSUPPORTED: number;
    ERR_FAILURE: number;
    ERR_PROCESSING: number;
    ERR_CONNECT: number;
    ERR_TIMEOUT: number;
    ERR_ILLEGAL: number;
    ERR_NOT_FOUND: number;
    ERR_IN_USE: number;
    ERR_TYPE_INVALID: number;
    ERR_RECOVERY_FAILURE: number;
    ERR_DISCONNECT: number;
    ERR_INIT: number;
    CODE_ERR_AUTORECOVER: number;
    CODE_ERR_COVER_OPEN: number;
    CODE_ERR_CUTTER: number;
    CODE_ERR_MECHANICAL: number;
    CODE_ERR_EMPTY: number;
    CODE_ERR_UNRECOVERABLE: number;
    CODE_ERR_FAILURE: number;
    CODE_ERR_NOT_FOUND: number;
    CODE_ERR_SYSTEM: number;
    CODE_ERR_PORT: number;
    CODE_ERR_TIMEOUT: number;
    CODE_ERR_JOB_NOT_FOUND: number;
    CODE_ERR_SPOOLER: number;
    CODE_ERR_BATTERY_LOW: number;
    CODE_ERR_TOO_MANY_REQUESTS: number;
    CODE_ERR_REQUEST_ENTITY_TOO_LARGE: number;
    CODE_ERR_WAIT_REMOVAL: number;
    CODE_PRINTING: number;
    CODE_ERR_PARAM: number;
    CODE_ERR_MEMORY: number;
    CODE_ERR_PROCESSING: number;
    CODE_ERR_ILLEGAL: number;
    CODE_ERR_DEVICE_BUSY: number;
    PRINTER_SETTING_PAPERWIDTH: number;
    PRINTER_SETTING_PRINTDENSITY: number;
    PRINTER_SETTING_PRINTSPEED: number;
    PRINTER_SETTING_PAPERWIDTH58_0: number;
    PRINTER_SETTING_PAPERWIDTH60_0: number;
    PRINTER_SETTING_PAPERWIDTH70_0: number;
    PRINTER_SETTING_PAPERWIDTH76_0: number;
    PRINTER_SETTING_PAPERWIDTH80_0: number;
    PRINTER_SETTING_PRINTDENSITYDIP: number;
    PRINTER_SETTING_PRINTDENSITY70: number;
    PRINTER_SETTING_PRINTDENSITY75: number;
    PRINTER_SETTING_PRINTDENSITY80: number;
    PRINTER_SETTING_PRINTDENSITY85: number;
    PRINTER_SETTING_PRINTDENSITY90: number;
    PRINTER_SETTING_PRINTDENSITY95: number;
    PRINTER_SETTING_PRINTDENSITY100: number;
    PRINTER_SETTING_PRINTDENSITY105: number;
    PRINTER_SETTING_PRINTDENSITY110: number;
    PRINTER_SETTING_PRINTDENSITY115: number;
    PRINTER_SETTING_PRINTDENSITY120: number;
    PRINTER_SETTING_PRINTDENSITY125: number;
    PRINTER_SETTING_PRINTDENSITY130: number;
    PRINTER_SETTING_PRINTSPEED1: number;
    PRINTER_SETTING_PRINTSPEED2: number;
    PRINTER_SETTING_PRINTSPEED3: number;
    PRINTER_SETTING_PRINTSPEED4: number;
    PRINTER_SETTING_PRINTSPEED5: number;
    PRINTER_SETTING_PRINTSPEED6: number;
    PRINTER_SETTING_PRINTSPEED7: number;
    PRINTER_SETTING_PRINTSPEED8: number;
    PRINTER_SETTING_PRINTSPEED9: number;
    PRINTER_SETTING_PRINTSPEED10: number;
    PRINTER_SETTING_PRINTSPEED11: number;
    PRINTER_SETTING_PRINTSPEED12: number;
    PRINTER_SETTING_PRINTSPEED13: number;
    PRINTER_SETTING_PRINTSPEED14: number;
    PRINTER_SETTING_PRINTSPEED15: number;
    PRINTER_SETTING_PRINTSPEED16: number;
    PRINTER_SETTING_PRINTSPEED17: number;
    PRINTER_TRUE: number;
    PRINTER_FALSE: number;
    UNKNOWN: number;
    PAPER_OK: number;
    PAPER_NEAR_END: number;
    PAPER_EMPTY: number;
    SWITCH_ON: number;
    SWITCH_OFF: number;
    DRAWER_HIGH: number;
    DRAWER_LOW: number;
    NO_ERR: number;
    MECHANICAL_ERR: number;
    AUTOCUTTER_ERR: number;
    UNRECOVER_ERR: number;
    AUTORECOVER_ERR: number;
    HEAD_OVERHEAT: number;
    MOTOR_OVERHEAT: number;
    BATTERY_OVERHEAT: number;
    WRONG_PAPER: number;
    COVER_OPEN: number;
    EPOS2_BATTERY_LEVEL_6: number;
    EPOS2_BATTERY_LEVEL_5: number;
    EPOS2_BATTERY_LEVEL_4: number;
    EPOS2_BATTERY_LEVEL_3: number;
    EPOS2_BATTERY_LEVEL_2: number;
    EPOS2_BATTERY_LEVEL_1: number;
    EPOS2_BATTERY_LEVEL_0: number;
    REMOVAL_WAIT_PAPER: number;
    REMOVAL_WAIT_NONE: number;
    REMOVAL_DETECT_PAPER: number;
    REMOVAL_DETECT_PAPER_NONE: number;
    REMOVAL_DETECT_UNKNOWN: number;
    HIGH_VOLTAGE_ERR: number;
    LOW_VOLTAGE_ERR: number;
    COLOR_NONE: number;
    COLOR_1: number;
    COLOR_2: number;
    COLOR_3: number;
    COLOR_4: number;
    MODE_MONO: number;
    MODE_GRAY16: number;
    MODE_MONO_HIGH_DENSITY: number;
    HALFTONE_DITHER: number;
    HALFTONE_ERROR_DIFFUSION: number;
    HALFTONE_THRESHOLD: number;
    COMPRESS_DEFLATE: number;
    COMPRESS_NONE: number;
    COMPRESS_AUTO: number;
    BARCODE_UPC_A: number;
    BARCODE_UPC_E: number;
    BARCODE_EAN13: number;
    BARCODE_JAN13: number;
    BARCODE_EAN8: number;
    BARCODE_JAN8: number;
    BARCODE_CODE39: number;
    BARCODE_ITF: number;
    BARCODE_CODABAR: number;
    BARCODE_CODE93: number;
    BARCODE_CODE128: number;
    BARCODE_CODE128_AUTO: number;
    BARCODE_GS1_128: number;
    BARCODE_GS1_DATABAR_OMNIDIRECTIONAL: number;
    BARCODE_GS1_DATABAR_TRUNCATED: number;
    BARCODE_GS1_DATABAR_LIMITED: number;
    BARCODE_GS1_DATABAR_EXPANDED: number;
    HRI_NONE: number;
    HRI_ABOVE: number;
    HRI_BELOW: number;
    HRI_BOTH: number;
    FONT_A: number;
    FONT_B: number;
    FONT_C: number;
    FONT_D: number;
    FONT_E: number;
    SYMBOL_PDF417_STANDARD: number;
    SYMBOL_PDF417_TRUNCATED: number;
    SYMBOL_QRCODE_MODEL_1: number;
    SYMBOL_QRCODE_MODEL_2: number;
    SYMBOL_QRCODE_MICRO: number;
    SYMBOL_MAXICODE_MODE_2: number;
    SYMBOL_MAXICODE_MODE_3: number;
    SYMBOL_MAXICODE_MODE_4: number;
    SYMBOL_MAXICODE_MODE_5: number;
    SYMBOL_MAXICODE_MODE_6: number;
    SYMBOL_GS1_DATABAR_STACKED: number;
    SYMBOL_GS1_DATABAR_STACKED_OMNIDIRECTIONAL: number;
    SYMBOL_GS1_DATABAR_EXPANDED_STACKED: number;
    SYMBOL_AZTECCODE_FULLRANGE: number;
    SYMBOL_AZTECCODE_COMPACT: number;
    SYMBOL_DATAMATRIX_SQUARE: number;
    SYMBOL_DATAMATRIX_RECTANGLE_8: number;
    SYMBOL_DATAMATRIX_RECTANGLE_12: number;
    SYMBOL_DATAMATRIX_RECTANGLE_16: number;
    LEVEL_0: number;
    LEVEL_1: number;
    LEVEL_2: number;
    LEVEL_3: number;
    LEVEL_4: number;
    LEVEL_5: number;
    LEVEL_6: number;
    LEVEL_7: number;
    LEVEL_8: number;
    LEVEL_L: number;
    LEVEL_M: number;
    LEVEL_Q: number;
    LEVEL_H: number;
    DRAWER_2PIN: number;
    DRAWER_5PIN: number;
    PULSE_100: number;
    PULSE_200: number;
    PULSE_300: number;
    PULSE_400: number;
    PULSE_500: number;
    ALIGN_LEFT: number;
    ALIGN_CENTER: number;
    ALIGN_RIGHT: number;
    LANG_EN: number;
    LANG_JA: number;
    LANG_ZH_CN: number;
    LANG_ZH_TW: number;
    LANG_KO: number;
    LANG_TH: number;
    LANG_VI: number;
    LANG_MULTI: number;
  };

  initWithPrinterDeviceName(
    target: string,
    deviceName: string,
    lang: number
  ): Promise<void>;
  connect(target: string, timeout: number): Promise<void>;
  disconnect(target: string): Promise<void>;
  clearCommandBuffer(target: string): Promise<void>;
  addText(target: string, data: string): Promise<void>;
  addTextLang(target: string, lang: number): Promise<void>;
  addFeedLine(target: string, line: number): Promise<void>;
  addLineSpace(target: string, linespc: number): Promise<void>;
  addCut(target: string, type: number): Promise<void>;
  sendData(target: string, timeout: number): Promise<Object>;
  getPrinterSetting(
    target: string,
    timeout: number,
    type: number
  ): Promise<Object>;
  getStatus(target: string): Promise<Object>;
  addImage(
    target: string,
    source: Object,
    width: number,
    color: number,
    mode: number,
    halftone: number,
    brightness: number,
    compress: number
  ): Promise<void>;
  addBarcode(
    target: string,
    data: string,
    type: number,
    hri: number,
    font: number,
    width: number,
    height: number
  ): Promise<void>;
  addSymbol(
    target: string,
    data: string,
    type: number,
    level: number,
    width: number,
    height: number,
    size: number
  ): Promise<void>;
  addCommand(target: string, data: string): Promise<void>;
  addPulse(target: string, drawer: number, time: number): Promise<void>;
  addTextAlign(target: string, align: number): Promise<void>;
  addTextSize(target: string, width: number, height: number): Promise<void>;
  addTextSmooth(target: string, smooth: number): Promise<void>;
  addTextStyle(
    target: string,
    reverse: number,
    ul: number,
    em: number,
    color: number
  ): Promise<void>;
}

export default TurboModuleRegistry.getEnforcing<Spec>('EscPosPrinter');
