import { NativeModules } from 'react-native';
import type { PrinterSeriesName } from './types';

const { EscPosPrinter } = NativeModules;
const {
  EPOS2_TM_M10,
  EPOS2_TM_M30,
  EPOS2_TM_P20,
  EPOS2_TM_P60,
  EPOS2_TM_P60II,
  EPOS2_TM_P80,
  EPOS2_TM_T20,
  EPOS2_TM_T60,
  EPOS2_TM_T70,
  EPOS2_TM_T81,
  EPOS2_TM_T82,
  EPOS2_TM_T83,
  EPOS2_TM_T88,
  EPOS2_TM_T90,
  EPOS2_TM_T90KP,
  EPOS2_TM_U220,
  EPOS2_TM_U330,
  EPOS2_TM_L90,
  EPOS2_TM_H6000,
  EPOS2_TM_T83III,
  EPOS2_TM_T100,
  EPOS2_TM_M30II,
  EPOS2_TS_100,
  EPOS2_TM_M50,
  COMMAND_ADD_TEXT,
  COMMAND_ADD_NEW_LINE,
  COMMAND_ADD_TEXT_STYLE,
  COMMAND_ADD_TEXT_SIZE,
  COMMAND_ADD_ALIGN,
  COMMAND_ADD_IMAGE,
  COMMAND_ADD_REMOTE_IMAGE,
  COMMAND_ADD_IMAGE_BASE_64,
  COMMAND_ADD_IMAGE_ASSET,
  COMMAND_ADD_CUT,
  COMMAND_ADD_DATA,
  EPOS2_ALIGN_LEFT,
  EPOS2_ALIGN_RIGHT,
  EPOS2_ALIGN_CENTER,
  EPOS2_TRUE,
  EPOS2_FALSE,
} = EscPosPrinter.getConstants();

export const PRINTING_COMMANDS = {
  COMMAND_ADD_TEXT,
  COMMAND_ADD_NEW_LINE,
  COMMAND_ADD_TEXT_STYLE,
  COMMAND_ADD_TEXT_SIZE,
  COMMAND_ADD_ALIGN,
  COMMAND_ADD_IMAGE,
  COMMAND_ADD_REMOTE_IMAGE,
  COMMAND_ADD_IMAGE_BASE_64,
  COMMAND_ADD_IMAGE_ASSET,
  COMMAND_ADD_CUT,
  COMMAND_ADD_DATA,
};

export const EPOS_BOOLEANS = {
  EPOS2_TRUE,
  EPOS2_FALSE,
};

export const PRINTING_ALIGNMENT = {
  left: EPOS2_ALIGN_LEFT,
  right: EPOS2_ALIGN_RIGHT,
  center: EPOS2_ALIGN_CENTER,
};

export const PRINTER_SERIES: { [key in PrinterSeriesName]: number } = {
  EPOS2_TM_M10,
  EPOS2_TM_M30,
  EPOS2_TM_P20,
  EPOS2_TM_P60,
  EPOS2_TM_P60II,
  EPOS2_TM_P80,
  EPOS2_TM_T20,
  EPOS2_TM_T60,
  EPOS2_TM_T70,
  EPOS2_TM_T81,
  EPOS2_TM_T82,
  EPOS2_TM_T83,
  EPOS2_TM_T88,
  EPOS2_TM_T90,
  EPOS2_TM_T90KP,
  EPOS2_TM_U220,
  EPOS2_TM_U330,
  EPOS2_TM_L90,
  EPOS2_TM_H6000,
  EPOS2_TM_T83III,
  EPOS2_TM_T100,
  EPOS2_TM_M30II,
  EPOS2_TS_100,
  EPOS2_TM_M50,
};

export const FONT_A_CHARS_PER_LINE: Partial<
  {
    [key in PrinterSeriesName]: { 58?: number; 60?: number; 80?: number };
  }
> = {
  EPOS2_TM_M10: {
    58: 35,
    60: 35,
  },
  EPOS2_TM_M30: {
    80: 48,
    58: 35,
    60: 35,
  },
  EPOS2_TM_M30II: {
    80: 42,
    58: 32,
    60: 32,
  },
  EPOS2_TM_P20: {
    58: 32,
    60: 35,
  },
  EPOS2_TM_P60: {
    58: 35,
    60: 35,
  },
  EPOS2_TM_P60II: {
    58: 35,
    60: 36,
  },
  EPOS2_TM_P80: {
    80: 42,
  },
  EPOS2_TM_T20: {
    80: 48,
    58: 35,
    60: 35,
  },
  EPOS2_TM_T60: {
    80: 42,
  },
  EPOS2_TM_T70: {
    80: 42,
  },
  EPOS2_TM_T81: {
    80: 42,
  },
  EPOS2_TM_T82: {
    80: 48,
    58: 35,
    60: 35,
  },
  EPOS2_TM_T83: {
    80: 42,
  },
  EPOS2_TM_T83III: {
    80: 42,
  },
  EPOS2_TM_T88: {
    80: 42,
    58: 30,
    60: 30,
  },
  EPOS2_TM_T90: {
    80: 42,
    60: 30,
    58: 30,
  },
  EPOS2_TM_T100: {
    80: 42,
  },
  EPOS2_TM_U220: {
    80: 35,
    58: 27,
    60: 27,
  },
  EPOS2_TM_U330: {
    80: 33,
    58: 25,
    60: 25,
  },
  EPOS2_TM_L90: {
    80: 42,
    58: 30,
    60: 30,
  },
  EPOS2_TM_H6000: {
    80: 42,
    58: 30,
    60: 30,
  },
};

export const DEFAULT_FONT_A_CHARS_PER_LINE = {
  80: 42,
  58: 30,
  60: 30,
};

export const DEFAULT_PAPER_WIDTHT = 60;
