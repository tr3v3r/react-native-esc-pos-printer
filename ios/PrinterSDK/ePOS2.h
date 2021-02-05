//
//  Copyright (C) Seiko Epson Corporation 2016 - 2021. All rights reserved.
//
//  ePOS SDK Ver.2.17.1

#ifdef __OBJC__
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#endif  /*__OBJC__*/

#define EPOS2_FALSE (0)
#define EPOS2_TRUE (1)
#define EPOS2_PARAM_UNSPECIFIED (-1)
#define EPOS2_PARAM_DEFAULT (-2)
#define EPOS2_UNKNOWN (-3)
#define EPOS2_PARAM_UNUSE (-4)

// virtual keycode
#define EPOS2_VK_BACK         (0x08)
#define EPOS2_VK_TAB          (0x09)
#define EPOS2_VK_RETURN       (0x0D)
#define EPOS2_VK_SHIFT        (0x10)
#define EPOS2_VK_CONTROL      (0x11)
#define EPOS2_VK_MENU         (0x12)
#define EPOS2_VK_CAPITAL      (0x14)
#define EPOS2_VK_ESCAPE       (0x1B)
#define EPOS2_VK_CONVERT      (0x1C)
#define EPOS2_VK_NONCONVERT   (0x1D)
#define EPOS2_VK_SPACE        (0x20)
#define EPOS2_VK_PRIOR        (0x21)
#define EPOS2_VK_NEXT         (0x22)
#define EPOS2_VK_END          (0x23)
#define EPOS2_VK_HOME         (0x24)
#define EPOS2_VK_LEFT         (0x25)
#define EPOS2_VK_UP           (0x26)
#define EPOS2_VK_RIGHT        (0x27)
#define EPOS2_VK_DOWN         (0x28)
#define EPOS2_VK_INSERT       (0x2D)
#define EPOS2_VK_DELETE       (0x2E)
#define EPOS2_VK_0            (0x30)
#define EPOS2_VK_1            (0x31)
#define EPOS2_VK_2            (0x32)
#define EPOS2_VK_3            (0x33)
#define EPOS2_VK_4            (0x34)
#define EPOS2_VK_5            (0x35)
#define EPOS2_VK_6            (0x36)
#define EPOS2_VK_7            (0x37)
#define EPOS2_VK_8            (0x38)
#define EPOS2_VK_9            (0x39)
#define EPOS2_VK_A            (0x41)
#define EPOS2_VK_B            (0x42)
#define EPOS2_VK_C            (0x43)
#define EPOS2_VK_D            (0x44)
#define EPOS2_VK_E            (0x45)
#define EPOS2_VK_F            (0x46)
#define EPOS2_VK_G            (0x47)
#define EPOS2_VK_H            (0x48)
#define EPOS2_VK_I            (0x49)
#define EPOS2_VK_J            (0x4A)
#define EPOS2_VK_K            (0x4B)
#define EPOS2_VK_L            (0x4C)
#define EPOS2_VK_M            (0x4D)
#define EPOS2_VK_N            (0x4E)
#define EPOS2_VK_O            (0x4F)
#define EPOS2_VK_P            (0x50)
#define EPOS2_VK_Q            (0x51)
#define EPOS2_VK_R            (0x52)
#define EPOS2_VK_S            (0x53)
#define EPOS2_VK_T            (0x54)
#define EPOS2_VK_U            (0x55)
#define EPOS2_VK_V            (0x56)
#define EPOS2_VK_W            (0x57)
#define EPOS2_VK_X            (0x58)
#define EPOS2_VK_Y            (0x59)
#define EPOS2_VK_Z            (0x5A)
#define EPOS2_VK_MULTIPLY     (0x6A)
#define EPOS2_VK_ADD          (0x6B)
#define EPOS2_VK_SUBTRACT     (0x6D)
#define EPOS2_VK_F1           (0x70)
#define EPOS2_VK_F2           (0x71)
#define EPOS2_VK_F3           (0x72)
#define EPOS2_VK_F4           (0x73)
#define EPOS2_VK_F5           (0x74)
#define EPOS2_VK_F6           (0x75)
#define EPOS2_VK_F7           (0x76)
#define EPOS2_VK_F8           (0x77)
#define EPOS2_VK_F9           (0x78)
#define EPOS2_VK_F10          (0x79)
#define EPOS2_VK_F11          (0x7A)
#define EPOS2_VK_F12          (0x7B)
#define EPOS2_VK_OEM_1        (0xBA)
#define EPOS2_VK_OEM_PLUS     (0xBB)
#define EPOS2_VK_OEM_COMMA    (0xBC)
#define EPOS2_VK_OEM_MINUS    (0xBD)
#define EPOS2_VK_OEM_PERIOD   (0xBE)
#define EPOS2_VK_OEM_2        (0xBF)
#define EPOS2_VK_OEM_3        (0xC0)
#define EPOS2_VK_OEM_4        (0xDB)
#define EPOS2_VK_OEM_5        (0xDC)
#define EPOS2_VK_OEM_6        (0xDD)
#define EPOS2_VK_OEM_7        (0xDE)
#define EPOS2_VK_OEM_ATTN     (0xF0)

/* getCommand option */
//#define EPOS2_GET_COMMAND_BODY   (0x00000000) /* only body command */

enum Epos2ErrorStatus : int {
    EPOS2_SUCCESS = 0,
    EPOS2_ERR_PARAM,
    EPOS2_ERR_CONNECT,
    EPOS2_ERR_TIMEOUT,
    EPOS2_ERR_MEMORY,
    EPOS2_ERR_ILLEGAL,
    EPOS2_ERR_PROCESSING,
    EPOS2_ERR_NOT_FOUND,
    EPOS2_ERR_IN_USE,
    EPOS2_ERR_TYPE_INVALID,
    EPOS2_ERR_DISCONNECT,
    EPOS2_ERR_ALREADY_OPENED,
    EPOS2_ERR_ALREADY_USED,
    EPOS2_ERR_BOX_COUNT_OVER,
    EPOS2_ERR_BOX_CLIENT_OVER,
    EPOS2_ERR_UNSUPPORTED,
    EPOS2_ERR_DEVICE_BUSY,
    EPOS2_ERR_RECOVERY_FAILURE,
    EPOS2_ERR_FAILURE = 255
};

enum Epos2CallbackCode : int {
    EPOS2_CODE_SUCCESS = 0,
    EPOS2_CODE_ERR_TIMEOUT,
    EPOS2_CODE_ERR_NOT_FOUND,
    EPOS2_CODE_ERR_AUTORECOVER,
    EPOS2_CODE_ERR_COVER_OPEN,
    EPOS2_CODE_ERR_CUTTER,
    EPOS2_CODE_ERR_MECHANICAL,
    EPOS2_CODE_ERR_EMPTY,
    EPOS2_CODE_ERR_UNRECOVERABLE,
    EPOS2_CODE_ERR_SYSTEM,
    EPOS2_CODE_ERR_PORT,
    EPOS2_CODE_ERR_INVALID_WINDOW,
    EPOS2_CODE_ERR_JOB_NOT_FOUND,
    EPOS2_CODE_PRINTING,
    EPOS2_CODE_ERR_SPOOLER,
    EPOS2_CODE_ERR_BATTERY_LOW,
    EPOS2_CODE_ERR_TOO_MANY_REQUESTS,
    EPOS2_CODE_ERR_REQUEST_ENTITY_TOO_LARGE,
    EPOS2_CODE_CANCELED,
    EPOS2_CODE_ERR_NO_MICR_DATA,
    EPOS2_CODE_ERR_ILLEGAL_LENGTH,
    EPOS2_CODE_ERR_NO_MAGNETIC_DATA,
    EPOS2_CODE_ERR_RECOGNITION,
    EPOS2_CODE_ERR_READ,
    EPOS2_CODE_ERR_NOISE_DETECTED,
    EPOS2_CODE_ERR_PAPER_JAM,
    EPOS2_CODE_ERR_PAPER_PULLED_OUT,
    EPOS2_CODE_ERR_CANCEL_FAILED,
    EPOS2_CODE_ERR_PAPER_TYPE,
    EPOS2_CODE_ERR_WAIT_INSERTION,
    EPOS2_CODE_ERR_ILLEGAL,
    EPOS2_CODE_ERR_INSERTED,
    EPOS2_CODE_ERR_WAIT_REMOVAL,
    EPOS2_CODE_ERR_DEVICE_BUSY,
    EPOS2_CODE_ERR_GET_JSON_SIZE,
    EPOS2_CODE_ERR_IN_USE,
    EPOS2_CODE_ERR_CONNECT,
    EPOS2_CODE_ERR_DISCONNECT,
    EPOS2_CODE_ERR_DIFFERENT_MODEL,
    EPOS2_CODE_ERR_DIFFERENT_VERSION,
    EPOS2_CODE_ERR_MEMORY,
    EPOS2_CODE_ERR_PROCESSING,
    EPOS2_CODE_ERR_DATA_CORRUPTED,
    EPOS2_CODE_ERR_PARAM,
    EPOS2_CODE_RETRY,
    EPOS2_CODE_ERR_FAILURE = 255
};

enum Epos2PrinterSeries : int {
    EPOS2_TM_M10 = 0,
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
enum Epos2DisplayModel : int {
    EPOS2_DM_D30 = 0,
    EPOS2_DM_D110,
	EPOS2_DM_D210,
    EPOS2_DM_D70,
};

enum Epos2ModelLang : int {
    EPOS2_MODEL_ANK = 0,
    EPOS2_MODEL_JAPANESE,
    EPOS2_MODEL_CHINESE,
    EPOS2_MODEL_TAIWAN,
    EPOS2_MODEL_KOREAN,
    EPOS2_MODEL_THAI,
    EPOS2_MODEL_SOUTHASIA,
};

enum Epos2DeviceModel : int {
    EPOS2_MODEL_ALL = 0,
};

enum Epos2PortType : int {
    EPOS2_PORTTYPE_ALL = 0,
    EPOS2_PORTTYPE_TCP,
    EPOS2_PORTTYPE_BLUETOOTH,
    EPOS2_PORTTYPE_USB,
};
enum Epos2StatusPaper : int {
    EPOS2_PAPER_OK = 0,
    EPOS2_PAPER_NEAR_END,
    EPOS2_PAPER_EMPTY,
};

enum Epos2PanelSwitch : int {
    EPOS2_SWITCH_OFF = 0,
    EPOS2_SWITCH_ON,
};

enum Epos2StatusDrawer : int {
    EPOS2_DRAWER_HIGH = 0,
    EPOS2_DRAWER_LOW,
};

enum Epos2PrinterError : int {
    EPOS2_NO_ERR = 0,
    EPOS2_MECHANICAL_ERR,
    EPOS2_AUTOCUTTER_ERR,
    EPOS2_UNRECOVER_ERR,
    EPOS2_AUTORECOVER_ERR,
};

enum Epos2AutoRecoverError : int {
    EPOS2_HEAD_OVERHEAT = 0,
    EPOS2_MOTOR_OVERHEAT,
    EPOS2_BATTERY_OVERHEAT,
    EPOS2_WRONG_PAPER,
    EPOS2_COVER_OPEN,
};

enum Epos2BatteryLevel : int {
    EPOS2_BATTERY_LEVEL_0 = 0,
    EPOS2_BATTERY_LEVEL_1,
    EPOS2_BATTERY_LEVEL_2,
    EPOS2_BATTERY_LEVEL_3,
    EPOS2_BATTERY_LEVEL_4,
    EPOS2_BATTERY_LEVEL_5,
    EPOS2_BATTERY_LEVEL_6,
};

enum Epos2InsertionWaiting : int {
    EPOS2_INSERTION_WAIT_SLIP = 0,
    EPOS2_INSERTION_WAIT_VALIDATION,
    EPOS2_INSERTION_WAIT_MICR,
    EPOS2_INSERTION_WAIT_NONE,
};

enum Epos2RemovalWaiting : int {
    EPOS2_REMOVAL_WAIT_PAPER = 0,
    EPOS2_REMOVAL_WAIT_NONE,
};

enum Epos2StatusSlipPaper : int {
    EPOS2_SLIP_PAPER_OK = 0,
    EPOS2_SLIP_PAPER_EMPTY,
};

enum Epos2StatusEvent : int {
    EPOS2_EVENT_ONLINE = 0,
    EPOS2_EVENT_OFFLINE,
    EPOS2_EVENT_POWER_OFF,
    EPOS2_EVENT_COVER_CLOSE,
    EPOS2_EVENT_COVER_OPEN,
    EPOS2_EVENT_PAPER_OK,
    EPOS2_EVENT_PAPER_NEAR_END,
    EPOS2_EVENT_PAPER_EMPTY,
    EPOS2_EVENT_DRAWER_HIGH,
    EPOS2_EVENT_DRAWER_LOW,
    EPOS2_EVENT_BATTERY_ENOUGH,
    EPOS2_EVENT_BATTERY_EMPTY,
    EPOS2_EVENT_INSERTION_WAIT_SLIP,
    EPOS2_EVENT_INSERTION_WAIT_VALIDATION,
    EPOS2_EVENT_INSERTION_WAIT_MICR,
    EPOS2_EVENT_INSERTION_WAIT_NONE,
    EPOS2_EVENT_REMOVAL_WAIT_PAPER,
    EPOS2_EVENT_REMOVAL_WAIT_NONE,
    EPOS2_EVENT_SLIP_PAPER_OK,
    EPOS2_EVENT_SLIP_PAPER_EMPTY,
};

enum Epos2ConnectionEvent : int {
    EPOS2_EVENT_RECONNECTING = 0,
    EPOS2_EVENT_RECONNECT,
    EPOS2_EVENT_DISCONNECT,
};

enum Epos2DeviceType : int {
    EPOS2_TYPE_ALL = 0,
    EPOS2_TYPE_PRINTER,
    EPOS2_TYPE_HYBRID_PRINTER,
    EPOS2_TYPE_DISPLAY,
    EPOS2_TYPE_KEYBOARD,
    EPOS2_TYPE_SCANNER,
    EPOS2_TYPE_SERIAL,
    EPOS2_TYPE_CCHANGER,
    EPOS2_TYPE_POS_KEYBOARD,
    EPOS2_TYPE_CAT,
    EPOS2_TYPE_MSR,
    EPOS2_TYPE_OTHER_PERIPHERAL,
    EPOS2_TYPE_GFE
};

enum Epos2Align : int {
    EPOS2_ALIGN_LEFT = 0,
    EPOS2_ALIGN_CENTER,
    EPOS2_ALIGN_RIGHT
};

enum Epos2Lang : int {
    EPOS2_LANG_EN = 0,
    EPOS2_LANG_JA,
    EPOS2_LANG_ZH_CN,
    EPOS2_LANG_ZH_TW,
    EPOS2_LANG_KO,
    EPOS2_LANG_TH,
    EPOS2_LANG_VI,
    EPOS2_LANG_MULTI
};

enum Epos2Font : int {
    EPOS2_FONT_A = 0,
    EPOS2_FONT_B,
    EPOS2_FONT_C,
    EPOS2_FONT_D,
    EPOS2_FONT_E
};

enum Epos2Color : int {
    EPOS2_COLOR_NONE = 0,
    EPOS2_COLOR_1,
    EPOS2_COLOR_2,
    EPOS2_COLOR_3,
    EPOS2_COLOR_4
};

enum Epos2Mode : int {
    EPOS2_MODE_MONO = 0,
    EPOS2_MODE_GRAY16,
    EPOS2_MODE_MONO_HIGH_DENSITY
};

enum Epos2Halftone : int {
    EPOS2_HALFTONE_DITHER = 0,
    EPOS2_HALFTONE_ERROR_DIFFUSION,
    EPOS2_HALFTONE_THRESHOLD
};

enum Epos2Compress : int {
    EPOS2_COMPRESS_DEFLATE = 0,
    EPOS2_COMPRESS_NONE,
    EPOS2_COMPRESS_AUTO
};

enum Epos2Barcode : int {
    EPOS2_BARCODE_UPC_A = 0,
    EPOS2_BARCODE_UPC_E,
    EPOS2_BARCODE_EAN13,
    EPOS2_BARCODE_JAN13,
    EPOS2_BARCODE_EAN8,
    EPOS2_BARCODE_JAN8,
    EPOS2_BARCODE_CODE39,
    EPOS2_BARCODE_ITF,
    EPOS2_BARCODE_CODABAR,
    EPOS2_BARCODE_CODE93,
    EPOS2_BARCODE_CODE128,
    EPOS2_BARCODE_GS1_128,
    EPOS2_BARCODE_GS1_DATABAR_OMNIDIRECTIONAL,
    EPOS2_BARCODE_GS1_DATABAR_TRUNCATED,
    EPOS2_BARCODE_GS1_DATABAR_LIMITED,
    EPOS2_BARCODE_GS1_DATABAR_EXPANDED,
    EPOS2_BARCODE_CODE128_AUTO
};

enum Epos2Hri : int {
    EPOS2_HRI_NONE = 0,
    EPOS2_HRI_ABOVE,
    EPOS2_HRI_BELOW,
    EPOS2_HRI_BOTH
};

enum Epos2Symbol : int {
    EPOS2_SYMBOL_PDF417_STANDARD = 0,
    EPOS2_SYMBOL_PDF417_TRUNCATED,
    EPOS2_SYMBOL_QRCODE_MODEL_1,
    EPOS2_SYMBOL_QRCODE_MODEL_2,
    EPOS2_SYMBOL_QRCODE_MICRO,
    EPOS2_SYMBOL_MAXICODE_MODE_2,
    EPOS2_SYMBOL_MAXICODE_MODE_3,
    EPOS2_SYMBOL_MAXICODE_MODE_4,
    EPOS2_SYMBOL_MAXICODE_MODE_5,
    EPOS2_SYMBOL_MAXICODE_MODE_6,
    EPOS2_SYMBOL_GS1_DATABAR_STACKED,
    EPOS2_SYMBOL_GS1_DATABAR_STACKED_OMNIDIRECTIONAL,
    EPOS2_SYMBOL_GS1_DATABAR_EXPANDED_STACKED,
    EPOS2_SYMBOL_AZTECCODE_FULLRANGE,
    EPOS2_SYMBOL_AZTECCODE_COMPACT,
    EPOS2_SYMBOL_DATAMATRIX_SQUARE,
    EPOS2_SYMBOL_DATAMATRIX_RECTANGLE_8,
    EPOS2_SYMBOL_DATAMATRIX_RECTANGLE_12,
    EPOS2_SYMBOL_DATAMATRIX_RECTANGLE_16
};

enum Epos2Level : int {
    EPOS2_LEVEL_0 = 0,
    EPOS2_LEVEL_1,
    EPOS2_LEVEL_2,
    EPOS2_LEVEL_3,
    EPOS2_LEVEL_4,
    EPOS2_LEVEL_5,
    EPOS2_LEVEL_6,
    EPOS2_LEVEL_7,
    EPOS2_LEVEL_8,
    EPOS2_LEVEL_L,
    EPOS2_LEVEL_M,
    EPOS2_LEVEL_Q,
    EPOS2_LEVEL_H
};

enum Epos2Line : int {
    EPOS2_LINE_THIN = 0,
    EPOS2_LINE_MEDIUM,
    EPOS2_LINE_THICK,
    EPOS2_LINE_THIN_DOUBLE,
    EPOS2_LINE_MEDIUM_DOUBLE,
    EPOS2_LINE_THICK_DOUBLE
};

enum Epos2Direction : int {
    EPOS2_DIRECTION_LEFT_TO_RIGHT = 0,
    EPOS2_DIRECTION_BOTTOM_TO_TOP,
    EPOS2_DIRECTION_RIGHT_TO_LEFT,
    EPOS2_DIRECTION_TOP_TO_BOTTOM
};

enum Epos2Cut : int {
    EPOS2_CUT_FEED = 0,
    EPOS2_CUT_NO_FEED,
    EPOS2_CUT_RESERVE
};

enum Epos2Drawer : int {
    EPOS2_DRAWER_2PIN = 0,
    EPOS2_DRAWER_5PIN
};

enum Epos2Pulse  : int {
    EPOS2_PULSE_100 = 0,
    EPOS2_PULSE_200,
    EPOS2_PULSE_300,
    EPOS2_PULSE_400,
    EPOS2_PULSE_500
};

enum Epos2Pattern : int {
    EPOS2_PATTERN_NONE = 0,
    EPOS2_PATTERN_A,
    EPOS2_PATTERN_B,
    EPOS2_PATTERN_C,
    EPOS2_PATTERN_D,
    EPOS2_PATTERN_E,
    EPOS2_PATTERN_ERROR,
    EPOS2_PATTERN_PAPER_EMPTY,
    EPOS2_PATTERN_1,
    EPOS2_PATTERN_2,
    EPOS2_PATTERN_3,
    EPOS2_PATTERN_4,
    EPOS2_PATTERN_5,
    EPOS2_PATTERN_6,
    EPOS2_PATTERN_7,
    EPOS2_PATTERN_8,
    EPOS2_PATTERN_9,
    EPOS2_PATTERN_10
};

enum Epos2FeedPosition : int {
    EPOS2_FEED_PEELING = 0,
    EPOS2_FEED_CUTTING,
    EPOS2_FEED_CURRENT_TOF,
    EPOS2_FEED_NEXT_TOF
};

enum Epos2Layout : int {
    EPOS2_LAYOUT_RECEIPT = 0,
    EPOS2_LAYOUT_RECEIPT_BM,
    EPOS2_LAYOUT_LABEL,
    EPOS2_LAYOUT_LABEL_BM
};

enum Epos2Papertype : int {
    EPOS2_PAPER_TYPE_RECEIPT = 0,
    EPOS2_PAPER_TYPE_SLIP,
    EPOS2_PAPER_TYPE_ENDORSE,
    EPOS2_PAPER_TYPE_VALIDATION
};

enum Epos2MicrFont : int {
    EPOS2_MICR_FONT_E13B = 0,
    EPOS2_MICR_FONT_CMC7
};

enum Epos2HybridPrinterMethod : int {
    EPOS2_METHOD_WAITINSERTION = 0,
    EPOS2_METHOD_SENDDATA,
    EPOS2_METHOD_CANCELINSERTION,
    EPOS2_METHOD_EJECTPAPER,
    EPOS2_METHOD_READMICRDATA,
    EPOS2_METHOD_CLEANMICRREADER
};

enum Epos2Scroll : int {
    EPOS2_SCROLL_OVERWRITE = 0,
    EPOS2_SCROLL_VERTICAL,
    EPOS2_SCROLL_HORIZONTAL
};

enum Epos2Format : int {
    EPOS2_MARQUEE_WALK = 0,
    EPOS2_MARQUEE_PLACE
};

enum Epos2Brightness : int {
    EPOS2_BRIGHTNESS_20 = 0,
    EPOS2_BRIGHTNESS_40,
    EPOS2_BRIGHTNESS_60,
    EPOS2_BRIGHTNESS_100
};

enum Epos2CursorPosition : int {
    EPOS2_MOVE_TOP_LEFT = 0,
    EPOS2_MOVE_TOP_RIGHT,
    EPOS2_MOVE_BOTTOM_LEFT,
    EPOS2_MOVE_BOTTOM_RIGHT
};

enum Epos2CursorType : int {
    EPOS2_CURSOR_NONE = 0,
    EPOS2_CURSOR_UNDERLINE
};

enum Epos2LayoutMode : int {
    EPOS2_LAYOUT_MODE_1 = 0,
    EPOS2_LAYOUT_MODE_2,
    EPOS2_LAYOUT_MODE_3,
    EPOS2_LAYOUT_MODE_4,
    EPOS2_LAYOUT_MODE_5,
    EPOS2_LAYOUT_MODE_6,
    EPOS2_LAYOUT_MODE_7,
    EPOS2_LAYOUT_MODE_8,
    EPOS2_LAYOUT_MODE_9,
    EPOS2_LAYOUT_MODE_10,
    EPOS2_LAYOUT_MODE_11,
    EPOS2_LAYOUT_MODE_12,
    EPOS2_LAYOUT_MODE_13,
    EPOS2_LAYOUT_MODE_14,
    EPOS2_LAYOUT_MODE_15,
    EPOS2_LANDSCAPE_LAYOUT_MODE_1,
    EPOS2_LANDSCAPE_LAYOUT_MODE_2,
    EPOS2_LANDSCAPE_LAYOUT_MODE_3,
    EPOS2_LANDSCAPE_LAYOUT_MODE_4,
    EPOS2_LANDSCAPE_LAYOUT_MODE_5,
    EPOS2_PORTRAIT_LAYOUT_MODE_1,
    EPOS2_PORTRAIT_LAYOUT_MODE_2,
    EPOS2_PORTRAIT_LAYOUT_MODE_3,
    EPOS2_PORTRAIT_LAYOUT_MODE_4,
    EPOS2_PORTRAIT_LAYOUT_MODE_5,
    EPOS2_PORTRAIT_LAYOUT_MODE_6,
    EPOS2_PORTRAIT_LAYOUT_MODE_7
};

enum Epos2RowType : int {
    EPOS2_EVEN_ROWS = -10,
    EPOS2_ODD_ROWS = -11,
    EPOS2_ALL_ROWS = -12
};

enum Epos2CountMode : int {
    EPOS2_COUNT_MODE_MANUAL_INPUT = 0,
    EPOS2_COUNT_MODE_AUTO_COUNT
};

enum Epos2Deposit : int {
    EPOS2_DEPOSIT_CHANGE = 0,
    EPOS2_DEPOSIT_NOCHANGE,
    EPOS2_DEPOSIT_REPAY
};

enum Epos2Collect : int {
    EPOS2_COLLECT_ALL_CASH = 0,
    EPOS2_COLLECT_PART_OF_CASH
};

enum Epos2CChangerStatus : int {
    EPOS2_CCHANGER_STATUS_BUSY = 0,
    EPOS2_CCHANGER_STATUS_PAUSE,
    EPOS2_CCHANGER_STATUS_END,
    EPOS2_CCHANGER_STATUS_ERR
};

enum Epos2CashStatus : int {
    EPOS2_ST_EMPTY = 0,
    EPOS2_ST_NEAR_EMPTY,
    EPOS2_ST_OK,
    EPOS2_ST_NEAR_FULL,
    EPOS2_ST_FULL
};

enum Epos2CChangerCallbackCode : int {
    EPOS2_CCHANGER_CODE_SUCCESS = 0,
    EPOS2_CCHANGER_CODE_BUSY,
    EPOS2_CCHANGER_CODE_DISCREPANCY,
    EPOS2_CCHANGER_CODE_ERR_CASH_IN_TRAY,
    EPOS2_CCHANGER_CODE_ERR_SHORTAGE,
    EPOS2_CCHANGER_CODE_ERR_REJECT_UNIT,
    EPOS2_CCHANGER_CODE_ERR_OPOSCODE,
    EPOS2_CCHANGER_CODE_ERR_UNSUPPORTED,
    EPOS2_CCHANGER_CODE_ERR_PARAM,
    EPOS2_CCHANGER_CODE_ERR_COMMAND,
    EPOS2_CCHANGER_CODE_ERR_DEVICE,
    EPOS2_CCHANGER_CODE_ERR_SYSTEM,
    EPOS2_CCHANGER_CODE_ERR_FAILURE
};

enum Epos2CChangerStatusUpdateEvent : int {
    EPOS2_CCHANGER_SUE_POWER_ONLINE = 2001,
    EPOS2_CCHANGER_SUE_POWER_OFF = 2002,
    EPOS2_CCHANGER_SUE_POWER_OFFLINE = 2003,
    EPOS2_CCHANGER_SUE_POWER_OFF_OFFLINE = 2004,
    EPOS2_CCHANGER_SUE_STATUS_EMPTY = 11,
    EPOS2_CCHANGER_SUE_STATUS_NEAREMPTY = 12,
    EPOS2_CCHANGER_SUE_STATUS_EMPTYOK = 13,
    EPOS2_CCHANGER_SUE_STATUS_FULL = 21,
    EPOS2_CCHANGER_SUE_STATUS_NEARFULL = 22,
    EPOS2_CCHANGER_SUE_STATUS_FULLOK = 23,
    EPOS2_CCHANGER_SUE_STATUS_JAM = 31,
    EPOS2_CCHANGER_SUE_STATUS_JAMOK = 32
};

enum Epos2CATCallbackCode : int {
    EPOS2_CAT_CODE_SUCCESS = 0,
    EPOS2_CAT_CODE_BUSY,
    EPOS2_CAT_CODE_EXCEEDING_LIMIT,
    EPOS2_CAT_CODE_DISAGREEMENT,
    EPOS2_CAT_CODE_INVALID_CARD,
    EPOS2_CAT_CODE_RESET,
    EPOS2_CAT_CODE_ERR_CENTER,
    EPOS2_CAT_CODE_ERR_OPOSCODE,
    EPOS2_CAT_CODE_ERR_PARAM,
    EPOS2_CAT_CODE_ERR_DEVICE,
    EPOS2_CAT_CODE_ERR_SYSTEM,
    EPOS2_CAT_CODE_ERR_TIMEOUT,
    EPOS2_CAT_CODE_ERR_FAILURE,
    EPOS2_CAT_CODE_ERR_COMMAND,
    EPOS2_CAT_CODE_ABORT_FAILURE
};

enum Epos2CATService : int {
    EPOS2_SERVICE_CREDIT = 0,
    EPOS2_SERVICE_DEBIT,
    EPOS2_SERVICE_UNIONPAY,
    EPOS2_SERVICE_EDY,
    EPOS2_SERVICE_ID,
    EPOS2_SERVICE_NANACO,
    EPOS2_SERVICE_QUICPAY,
    EPOS2_SERVICE_SUICA,
    EPOS2_SERVICE_WAON,
    EPOS2_SERVICE_POINT,
    EPOS2_SERVICE_COMMON,
    EPOS2_SERVICE_NFCPAYMENT,
    EPOS2_SERVICE_PITAPA,
    EPOS2_SERVICE_FISC
};

enum Epos2CATPaymentCondition : int {
    EPOS2_PAYMENT_CONDITION_LUMP_SUM = 0,
    EPOS2_PAYMENT_CONDITION_BONUS_1,
    EPOS2_PAYMENT_CONDITION_BONUS_2,
    EPOS2_PAYMENT_CONDITION_BONUS_3,
    EPOS2_PAYMENT_CONDITION_INSTALLMENT_1,
    EPOS2_PAYMENT_CONDITION_INSTALLMENT_2,
    EPOS2_PAYMENT_CONDITION_REVOLVING,
    EPOS2_PAYMENT_CONDITION_COMBINATION_1,
    EPOS2_PAYMENT_CONDITION_COMBINATION_2,
    EPOS2_PAYMENT_CONDITION_DEBIT,
    EPOS2_PAYMENT_CONDITION_ELECTRONIC_MONEY,
    EPOS2_PAYMENT_CONDITION_OTHER,
    EPOS2_PAYMENT_CONDITION_BONUS_4,
    EPOS2_PAYMENT_CONDITION_BONUS_5,
    EPOS2_PAYMENT_CONDITION_INSTALLMENT_3,
    EPOS2_PAYMENT_CONDITION_COMBINATION_3,
    EPOS2_PAYMENT_CONDITION_COMBINATION_4,
};

enum Epos2CATStatusUpdateEvent : int {
    EPOS2_CAT_SUE_POWER_ONLINE = 2001,
    EPOS2_CAT_SUE_POWER_OFF_OFFLINE = 2004,
    EPOS2_CAT_SUE_LOGSTATUS_OK = 0,
    EPOS2_CAT_SUE_LOGSTATUS_NEARFULL = 1,
    EPOS2_CAT_SUE_LOGSTATUS_FULL = 2
};

enum Epos2LogPeriod : int {
    EPOS2_PERIOD_TEMPORARY = 0,
    EPOS2_PERIOD_PERMANENT
};

enum Epos2LogOutput : int {
    EPOS2_OUTPUT_DISABLE = 0,
    EPOS2_OUTPUT_STORAGE,
    EPOS2_OUTPUT_TCP
};

enum Epos2LogLevel : int {
    EPOS2_LOGLEVEL_LOW = 0
};

enum Epos2MaintenanceCounterType : int {
    EPOS2_MAINTENANCE_COUNTER_PAPERFEED = 0,
    EPOS2_MAINTENANCE_COUNTER_AUTOCUTTER
};

enum Epos2PrinterSettingType : int {
    EPOS2_PRINTER_SETTING_PAPERWIDTH = 0,
    EPOS2_PRINTER_SETTING_PRINTDENSITY,
    EPOS2_PRINTER_SETTING_PRINTSPEED
};

enum Epos2PrinterSettingPaperWidth : int {
    EPOS2_PRINTER_SETTING_PAPERWIDTH_58_0 = 2,
    EPOS2_PRINTER_SETTING_PAPERWIDTH_60_0 = 3,
    EPOS2_PRINTER_SETTING_PAPERWIDTH_80_0 = 6
};

enum Epos2PrinterSettingPrintDensity : int {
    EPOS2_PRINTER_SETTING_PRINTDENSITY_DIP = 100,
    EPOS2_PRINTER_SETTING_PRINTDENSITY_70 = 65530,
    EPOS2_PRINTER_SETTING_PRINTDENSITY_75 = 65531,
    EPOS2_PRINTER_SETTING_PRINTDENSITY_80 = 65532,
    EPOS2_PRINTER_SETTING_PRINTDENSITY_85 = 65533,
    EPOS2_PRINTER_SETTING_PRINTDENSITY_90 = 65534,
    EPOS2_PRINTER_SETTING_PRINTDENSITY_95 = 65535,
    EPOS2_PRINTER_SETTING_PRINTDENSITY_100 = 0,
    EPOS2_PRINTER_SETTING_PRINTDENSITY_105 = 1,
    EPOS2_PRINTER_SETTING_PRINTDENSITY_110 = 2,
    EPOS2_PRINTER_SETTING_PRINTDENSITY_115 = 3,
    EPOS2_PRINTER_SETTING_PRINTDENSITY_120 = 4,
    EPOS2_PRINTER_SETTING_PRINTDENSITY_125 = 5,
    EPOS2_PRINTER_SETTING_PRINTDENSITY_130 = 6
};

enum Epos2PrinterSettingPrintSpeed : int {
    EPOS2_PRINTER_SETTING_PRINTSPEED_1 = 1,
    EPOS2_PRINTER_SETTING_PRINTSPEED_2 = 2,
    EPOS2_PRINTER_SETTING_PRINTSPEED_3 = 3,
    EPOS2_PRINTER_SETTING_PRINTSPEED_4 = 4,
    EPOS2_PRINTER_SETTING_PRINTSPEED_5 = 5,
    EPOS2_PRINTER_SETTING_PRINTSPEED_6 = 6,
    EPOS2_PRINTER_SETTING_PRINTSPEED_7 = 7,
    EPOS2_PRINTER_SETTING_PRINTSPEED_8 = 8,
    EPOS2_PRINTER_SETTING_PRINTSPEED_9 = 9,
    EPOS2_PRINTER_SETTING_PRINTSPEED_10 = 10,
    EPOS2_PRINTER_SETTING_PRINTSPEED_11 = 11,
    EPOS2_PRINTER_SETTING_PRINTSPEED_12 = 12,
    EPOS2_PRINTER_SETTING_PRINTSPEED_13 = 13,
    EPOS2_PRINTER_SETTING_PRINTSPEED_14 = 14
};


#ifdef __OBJC__

@class Epos2CommonPrinter;
@class Epos2Printer;
@class Epos2HybridPrinter;
@class Epos2LineDisplay;
@class Epos2Keyboard;
@class Epos2BarcodeScanner;
@class Epos2SimpleSerial;
@class Epos2CommBox;
@class Epos2CashChanger;
@class Epos2POSKeyboard;
@class Epos2CAT;
@class Epos2MSR;
@class Epos2OtherPeripheral;
@class Epos2GermanyFiscalElement;

@class Epos2PrinterStatusInfo;
@class Epos2HybridPrinterStatusInfo;
@class Epos2CATAuthorizeResult;
@class Epos2CATDirectIOResult;
@class Epos2MSRData;
@class Epos2DeviceInfo;
@class Epos2FirmwareInfo;

@protocol Epos2ConnectionDelegate <NSObject>
@required
- (void) onConnection:(id)deviceObj eventType:(int)eventType;
@end

@protocol Epos2PtrStatusChangeDelegate <NSObject>
@required
- (void) onPtrStatusChange:(Epos2Printer *)printerObj eventType:(int)eventType;
@end

@protocol Epos2PtrReceiveDelegate <NSObject>
@required
- (void) onPtrReceive:(Epos2Printer *)printerObj code:(int)code status:(Epos2PrinterStatusInfo *)status printJobId:(NSString *)printJobId;
@end

@protocol Epos2HybdStatusChangeDelegate <NSObject>
@required
- (void) onHybdStatusChange:(Epos2HybridPrinter *)hybridPrinterObj eventType:(int)eventType;
@end

@protocol Epos2HybdReceiveDelegate <NSObject>
@required
- (void) onHybdReceive:(Epos2HybridPrinter *)hybridPrinterObj method:(int)method code:(int)code micrData:(NSString *)micrData status:(Epos2HybridPrinterStatusInfo *)status;
@end

@protocol Epos2DispReceiveDelegate <NSObject>
@required
- (void) onDispReceive:(Epos2LineDisplay *)displayObj code:(int)code;
@end

@protocol Epos2KbdKeyPressDelegate <NSObject>
@required
- (void) onKbdKeyPress:(Epos2Keyboard *)keyboardObj keyCode:(int)keyCode ascii:(NSString *)ascii;
@end

@protocol Epos2KbdReadStringDelegate <NSObject>
@required
- (void) onKbdReadString:(Epos2Keyboard *)keyboardObj readString:(NSString *)readString prefix:(int)prefix;
@end

@protocol Epos2ScanDelegate <NSObject>
@required
- (void) onScanData:(Epos2BarcodeScanner *)scannerObj scanData:(NSString *)scanData;
@end

@protocol Epos2SimpleSerialReceiveDelegate <NSObject>
@required
- (void) onSimpleSerialReceive:(Epos2SimpleSerial *)serialObj data:(NSData *)data;
@end

@protocol Epos2GetCommHistoryDelegate <NSObject>
@required
- (void) onGetCommHistory:(Epos2CommBox *)commBoxObj code:(int)code historyList:(NSArray *)historyList;
@end

@protocol Epos2CommBoxSendMessageDelegate <NSObject>
@required
- (void) onCommBoxSendMessage:(Epos2CommBox *)commBoxObj code:(int)code count:(long)count;
@end

@protocol Epos2CommBoxReceiveDelegate <NSObject>
@required
- (void) onCommBoxReceive:(Epos2CommBox *)commBoxObj senderId:(NSString *)senderId receiverId:(NSString *)receiverId message:(NSString *)message;
@end

@protocol Epos2POSKbdKeyPressDelegate <NSObject>
@required
- (void) onPOSKbdKeyPress:(Epos2POSKeyboard *)poskeyboardObj posKeyCode:(int)posKeyCode;
@end

@protocol Epos2CChangerConfigChangeDelegate <NSObject>
@required
- (void) onCChangerConfigChange:(Epos2CashChanger *)cchangerObj code:(int)code;
@end

@protocol Epos2CChangerCashCountDelegate <NSObject>
@required
- (void) onCChangerCashCount:(Epos2CashChanger *)cchangerObj code:(int)code data:(NSDictionary *)data;
@end

@protocol Epos2CChangerDepositDelegate <NSObject>
@required
- (void) onCChangerDeposit:(Epos2CashChanger *)cchangerObj code:(int)code status:(int)status amount:(long)amount data:(NSDictionary *)data;
@end

@protocol Epos2CChangerDispenseDelegate <NSObject>
@required
- (void) onCChangerDispense:(Epos2CashChanger *)cchangerObj code:(int)code;
@end

@protocol Epos2CChangerCollectDelegate <NSObject>
@required
- (void) onCChangerCollect:(Epos2CashChanger *)cchangerObj code:(int)code;
@end

@protocol Epos2CChangerCommandReplyDelegate <NSObject>
@required
- (void) onCChangerCommandReply:(Epos2CashChanger *)cchangerObj code:(int)code data:(NSData *)data;
@end

@protocol Epos2CChangerDirectIOCommandReplyDelegate <NSObject>
@required
- (void) onCChangerDirectIOCommandReply:(Epos2CashChanger *)cchangerObj code:(int)code command:(long)command data:(long)data string:(NSString *)string;
@end

@protocol Epos2CChangerStatusChangeDelegate <NSObject>
@required
- (void) onCChangerStatusChange:(Epos2CashChanger *)cchangerObj code:(int)code status:(NSDictionary *)status;
@end

@protocol Epos2CChangerDirectIODelegate <NSObject>
@required
- (void) onCChangerDirectIO:(Epos2CashChanger *)cchangerObj eventnumber:(long)eventnumber data:(long)data string:(NSString *)string;
@end

@protocol Epos2CChangerStatusUpdateDelegate <NSObject>
@required
- (void) onCChangerStatusUpdate:(Epos2CashChanger *)cchangerObj status:(long)status;
@end

@protocol Epos2CATAuthorizeSalesDelegate <NSObject>
@required
- (void) onCATAuthorizeSales:(Epos2CAT *)catObj code:(int)code sequence:(long)sequence service:(int)service result:(Epos2CATAuthorizeResult *)result;
@end;

@protocol Epos2CATAuthorizeVoidDelegate <NSObject>
@required
- (void) onCATAuthorizeVoid:(Epos2CAT *)catObj code:(int)code sequence:(long)sequence service:(int)service result:(Epos2CATAuthorizeResult *)result;
@end;

@protocol Epos2CATAuthorizeRefundDelegate <NSObject>
@required
- (void) onCATAuthorizeRefund:(Epos2CAT *)catObj code:(int)code sequence:(long)sequence service:(int)service result:(Epos2CATAuthorizeResult *)result;
@end;

@protocol Epos2CATAuthorizeCompletionDelegate <NSObject>
@required
- (void) onCATAuthorizeCompletion:(Epos2CAT *)catObj code:(int)code sequence:(long)sequence service:(int)service result:(Epos2CATAuthorizeResult *)result;
@end;

@protocol Epos2CATAccessDailyLogDelegate <NSObject>
@required
- (void) onCATAccessDailyLog:(Epos2CAT *)catObj code:(int)code sequence:(long)sequence service:(int)service dailyLog:(NSArray *)dailyLog;
@end;

@protocol Epos2CATDirectIOCommandReplyDelegate <NSObject>
@required
- (void) onCATDirectIOCommandReply:(Epos2CAT *)catObj code:(int)code command:(long)command data:(long)data string:(NSString *)string sequence:(long)sequence service:(int)service result:(Epos2CATDirectIOResult *)result;
@end

@protocol Epos2CATStatusUpdateDelegate <NSObject>
@required
- (void) onCATStatusUpdate:(Epos2CAT *)catObj status:(long)status;
@end

@protocol Epos2CATDirectIODelegate <NSObject>
@required
- (void) onCATDirectIO:(Epos2CAT *)catObj eventNumber:(long)eventNumber data:(long)data string:(NSString *)string;
@end

@protocol Epos2CATCheckConnectionDelegate <NSObject>
@required
- (void) onCATCheckConnection:(Epos2CAT *)catObj code:(int)code additionalSecurityInformation:(NSString *)asi;
@end

@protocol Epos2CATClearOutputDelegate <NSObject>
@required
- (void) onCATClearOutput:(Epos2CAT *)catObj code:(int)code  abortCode:(long)abortCode;
@end

@protocol Epos2MSRDataDelegate <NSObject>
@required
- (void) onMSRData:(Epos2MSR *)msrObj data:(Epos2MSRData *)data;
@end;

@protocol Epos2OtherReceiveDelegate <NSObject>
@required
- (void) onOtherReceive:(Epos2OtherPeripheral *)otherObj eventName:(NSString *)eventName data:(NSString *)data;
@end

@protocol Epos2GermanyFiscalElementReceiveDelegate <NSObject>
@required
- (void) onGfeReceive:(Epos2GermanyFiscalElement *)germanyFiscalObj code:(int)code data:(NSString *)data;
@end

@protocol Epos2DiscoveryDelegate <NSObject>
@required
- (void) onDiscovery:(Epos2DeviceInfo *)deviceInfo;
@end

@protocol Epos2FirmwareListDownloadDelegate <NSObject>
@required
- (void) onFirmwareListDownload:(int)code firmwareList:(NSMutableArray<Epos2FirmwareInfo *> *)firmwareList;
@end

@protocol Epos2FirmwareInformationDelegate <NSObject>
@required
- (void) onFirmwareInformationReceive:(int)code firmwareInfo:(Epos2FirmwareInfo *)firmwareInfo;
@end

@protocol Epos2FirmwareUpdateDelegate <NSObject>
@required
- (void) onFirmwareUpdateProgress:(NSString *)task progress:(float)progress;
- (void) onFirmwareUpdate:(int)code maxWaitTime:(int)maxWaitTime;
@end

@protocol Epos2VerifyeUpdateDelegate <NSObject>
@required
- (void) onUpdateVerify:(int)code;
@end
@protocol Epos2MaintenanceCounterDelegate <NSObject>
@required
- (void) onGetMaintenanceCounter:(int)code type:(int)type value:(int)value;
- (void) onResetMaintenanceCounter:(int)code type:(int)type;
@end

@protocol Epos2PrinterSettingDelegate <NSObject>
@required
- (void) onGetPrinterSetting:(int)code type:(int)type value:(int)value;
- (void) onSetPrinterSetting:(int)code;
@end

@protocol Epos2PrinterInformationDelegate <NSObject>
@required
- (void) onGetPrinterInformation:(int)code jsonString:(NSString *)jsonString;
@end

@interface Epos2CommonPrinter : NSObject
- (int) startMonitor;
- (int) stopMonitor;
- (int) beginTransaction;
- (int) endTransaction;
- (int) clearCommandBuffer;
- (int) addTextAlign:(int)align;
- (int) addLineSpace:(long)linespc;
- (int) addTextRotate:(int)rotate;
- (int) addText:(NSString *)data;
- (int) addTextLang:(int)lang;
- (int) addTextFont:(int)font;
- (int) addTextSmooth:(int)smooth;
- (int) addTextSize:(long)width height:(long)height;
- (int) addTextStyle:(int)reverse ul:(int)ul em:(int)em color:(int)color;
- (int) addHPosition:(long)x;
- (int) addFeedUnit:(long)unit;
- (int) addFeedLine:(long)line;
- (int) addImage:(UIImage *)data x:(long)x y:(long)y width:(long)width height:(long)height color:(int)color mode:(int)mode halftone:(int)halftone brightness:(double)brightness compress:(int)compress;
- (int) addLogo:(long)key1 key2:(long)key2;
- (int) addBarcode:(NSString *)data type:(int)type hri:(int)hri font:(int)font width:(long)width height:(long)height;
- (int) addSymbol:(NSString *)data type:(int)type level:(int)level width:(long)width height:(long)height size:(long)size;
- (int) addPageBegin;
- (int) addPageEnd;
- (int) addPageArea:(long)x y:(long)y width:(long)width height:(long)height;
- (int) addPageDirection:(int)direction;
- (int) addPagePosition:(long)x y:(long)y;
- (int) addPageLine:(long)x1 y1:(long)y1 x2:(long)x2 y2:(long)y2 style:(int)style;
- (int) addPageRectangle:(long)x1 y1:(long)y1 x2:(long)x2 y2:(long)y2 style:(int)style;
- (int) addCut:(int)type;
- (int) addPulse:(int)drawer time:(int)time;
- (int) addCommand:(NSData *)data;

- (int) forceRecover:(long)timeout;
- (int) forcePulse:(int)drawer pulseTime:(int)time timeout:(long)timeout;
- (int) forceReset:(long)timeout;
//- (int) getCommandBuffer:(NSMutableData *)commandData Flag:(unsigned long)flag;
@end

@interface Epos2PrinterStatusInfo : NSObject
@property(readonly, getter=getConnection) int connection;
@property(readonly, getter=getOnline) int online;
@property(readonly, getter=getCoverOpen) int coverOpen;
@property(readonly, getter=getPaper) int paper;
@property(readonly, getter=getPaperFeed) int paperFeed;
@property(readonly, getter=getPanelSwitch) int panelSwitch;
@property(readonly, getter=getWaitOnline) int waitOnline;
@property(readonly, getter=getDrawer) int drawer;
@property(readonly, getter=getErrorStatus) int errorStatus;
@property(readonly, getter=getAutoRecoverError) int autoRecoverError;
@property(readonly, getter=getBuzzer) int buzzer;
@property(readonly, getter=getAdapter) int adapter;
@property(readonly, getter=getBatteryLevel) int batteryLevel;
@end

@interface Epos2Printer : Epos2CommonPrinter
- (id) initWithPrinterSeries:(int)printerSeries lang:(int)lang;
- (void) dealloc;

- (int) connect:(NSString *) target timeout:(long)timeout;
- (int) disconnect;
- (Epos2PrinterStatusInfo *) getStatus;
- (int) sendData:(long)timeout;
- (int) requestPrintJobStatus:(NSString *)printJobId;
- (int) addHLine:(long)x1 x2:(long)x2 style:(int)style;
- (int) addVLineBegin:(long)x style:(int)style lineId:(int *)lineId;
- (int) addVLineEnd:(int)lineId;
- (int) addSound:(int)pattern repeat:(long)repeat cycle:(long)cycle;
- (int) addFeedPosition:(int)position;
- (int) addLayout:(int)type width:(long)width height:(long)height marginTop:(long)marginTop marginBottom:(long)marginBottom offsetCut:(long)offsetCut offsetLabel:(long)offsetLabel;
- (int) addRotateBegin;
- (int) addRotateEnd;
- (int) forceStopSound:(long)timeout;
- (int) forceCommand:(NSData *)data timeout:(long)timeout;

- (void) setStatusChangeEventDelegate:(id<Epos2PtrStatusChangeDelegate>)delegate;
- (void) setReceiveEventDelegate:(id<Epos2PtrReceiveDelegate>)delegate;

- (int) setInterval:(long)interval;
- (long) getInterval;

- (void) setConnectionEventDelegate:(id<Epos2ConnectionDelegate>)delegate;
- (NSString *) getAdmin;
- (NSString *) getLocation;

- (int) downloadFirmwareList:(NSString *)printerModel delegate:(id<Epos2FirmwareListDownloadDelegate>)delegate;
- (int) downloadFirmwareList:(NSString *)printerModel option:(NSString *)option delegate:(id<Epos2FirmwareListDownloadDelegate>)delegate;
- (int) getPrinterFirmwareInfo:(long)timeout delegate:(id<Epos2FirmwareInformationDelegate>)delegate;
- (int) updateFirmware:(Epos2FirmwareInfo *)targetFirmwareInfo delegate:(id<Epos2FirmwareUpdateDelegate>)delegate;
- (int) verifyUpdate:(Epos2FirmwareInfo *)targetFirmwareInfo delegate:(id<Epos2VerifyeUpdateDelegate>)delegate;

- (int) getMaintenanceCounter:(long)timeout type:(int)Type delegate:(id<Epos2MaintenanceCounterDelegate>)delegate;
- (int) resetMaintenanceCounter:(long)timeout type:(int)Type delegate:(id<Epos2MaintenanceCounterDelegate>)delegate;
- (int) getPrinterSetting:(long)timeout type:(int)Type delegate:(id<Epos2PrinterSettingDelegate>)delegate;
- (int) setPrinterSetting:(long)timeout setttingList:(NSDictionary *)list delegate:(id<Epos2PrinterSettingDelegate>)delegate;
- (int) getPrinterInformation:(long)timeout delegate:(id<Epos2PrinterInformationDelegate>)delegate;
@end

@interface Epos2HybridPrinterStatusInfo : NSObject
@property(readonly, getter=getConnection) int connection;
@property(readonly, getter=getOnline) int online;
@property(readonly, getter=getCoverOpen) int coverOpen;
@property(readonly, getter=getPaper) int paper;
@property(readonly, getter=getPaperFeed) int paperFeed;
@property(readonly, getter=getPanelSwitch) int panelSwitch;
@property(readonly, getter=getWaitOnline) int waitOnline;
@property(readonly, getter=getDrawer) int drawer;
@property(readonly, getter=getErrorStatus) int errorStatus;
@property(readonly, getter=getAutoRecoverError) int autoRecoverError;
@property(readonly, getter=getInsertionWaiting) int insertionWaiting;
@property(readonly, getter=getRemovalWaiting) int removalWaiting;
@property(readonly, getter=getSlipPaper) int slipPaper;
@end

@interface Epos2HybridPrinter : Epos2CommonPrinter
- (id) initWithLang:(int)lang;
- (void) dealloc;

- (int) connect:(NSString *)target timeout:(long)timeout;
- (int) disconnect;
- (Epos2HybridPrinterStatusInfo *) getStatus;
- (int) selectPaperType:(int)paperType;
- (int) waitInsertion:(long)timeout;
- (int) sendData:(long)timeout;
- (int) cancelInsertion;
- (int) ejectPaper;
- (int) readMicrData:(int)micrFont timeout:(long)timeout;
- (int) cleanMicrReader:(long)timeout;
- (int) forceCommand:(NSData *)data timeout:(long)timeout;

- (void) setStatusChangeEventDelegate:(id<Epos2HybdStatusChangeDelegate>)delegate;
- (void) setReceiveEventDelegate:(id<Epos2HybdReceiveDelegate>)delegate;

- (int) getPaperType;
- (int) setInterval:(long)interval;
- (long) getInterval;
- (int) setWaitTime:(long)waitTime;
- (long) getWaitTime;
- (int) setMode40Cpl:(int)mode40Cpl;
- (int) getMode40Cpl;

- (void) setConnectionEventDelegate:(id<Epos2ConnectionDelegate>)delegate;
- (NSString *) getAdmin;
- (NSString *) getLocation;
@end

@interface Epos2DisplayStatusInfo : NSObject
@property(readonly, getter=getConnection) int connection;
@end

@interface Epos2LineDisplay : NSObject
- (id) initWithDisplayModel:(int)displayModel;
- (void) dealloc;

- (int) connect:(NSString *) target timeout:(long)timeout;
- (int) disconnect;

- (Epos2DisplayStatusInfo *) getStatus;
- (int) sendData;
- (int) clearCommandBuffer;
- (int) addInitialize;
- (int)	addCreateWindow:(long)number x:(long)x y:(long)y width:(long)width height:(long)height scrollMode:(int)scrollMode;
- (int) addDestroyWindow:(long)number;
- (int) addSetCurrentWindow:(long)number;
- (int) addClearCurrentWindow;
- (int) addSetCursorPosition:(long)x y:(long)y;
- (int)	addMoveCursorPosition:(int)position;
- (int) addSetCursorType:(int)type;
- (int) addText:(NSString *)data;
- (int) addText:(NSString *)data lang:(int)lang;
- (int) addText:(NSString *)data x:(long)x y:(long)y;
- (int) addText:(NSString *)data x:(long)x y:(long)y lang:(int)lang;
- (int) addText:(NSString *)data x:(long)x y:(long)y lang:(int)lang r:(long)r g:(long)g b:(long)b;
- (int) addReverseText:(NSString *)data;
- (int) addReverseText:(NSString *)data lang:(int)lang;
- (int) addReverseText:(NSString *)data x:(long)x y:(long)y;
- (int) addReverseText:(NSString *)data x:(long)x y:(long)y lang:(int)lang;
- (int) addMarqueeText:(NSString *)data format:(int)format unitWait:(long)unitWait repeatWait:(long)repeatWait repeatCount:(long)repeatCount lang:(int)lang;
- (int) addSetBlink:(long)interval;
- (int) addSetBrightness:(int)brightness;
- (int) addShowClock;
- (int) addCommand:(NSData *)data;
- (int) addCreateScreen:(int)mode;
- (int) addCreateScreenCustom:(int)mode column:(long)column row:(long)row;
- (int) addBackgroundColor:(int)row r:(long)r g:(long)g b:(long)b;
- (int) addStartSlideShow:(long)interval;
- (int) addStopSlideShow;
- (int) addSymbol:(NSString *)data type:(int)type level:(int)level width:(long)width height:(long)height dotX:(long)dotX dotY:(long)dotY quietZone:(int)quietZone;
- (int) addDownloadImage:(long)key1 key2:(long)key2 dotX:(long)dotX dotY:(long)dotY width:(long)width height:(long)height;
- (int) addRegisterDownloadImage:(NSData*) data key1:(long)key1 key2:(long)key2;
- (int) addNVImage:(long)key1 key2:(long)key2 dotX:(long)dotX dotY:(long)dotY width:(long)width height:(long)height;
- (int) addClearImage;
- (int) addClearSymbol;
- (int) addCreateTextArea:(long)number x:(long)x y:(long)y width:(long)width height:(long)height scrollMode:(int)scrollMode;
- (int) addDestroyTextArea:(long)number;
- (int) addSetCurrentTextArea:(long)number;
- (int) addClearCurrentTextArea;

- (void) setReceiveEventDelegate:(id<Epos2DispReceiveDelegate>)delegate;

- (void) setConnectionEventDelegate:(id<Epos2ConnectionDelegate>)delegate;
- (NSString *) getAdmin;
- (NSString *) getLocation;
@end

@interface Epos2KeyboardStatusInfo : NSObject
@property(readonly, getter=getConnection) int connection;
@end

@interface Epos2Keyboard : NSObject
- (id) init;
- (void) dealloc;

- (int) connect:(NSString *) target timeout:(long)timeout;
- (int) disconnect;
- (Epos2KeyboardStatusInfo *) getStatus;

- (int) setPrefix:(NSData *)data;
- (NSData *) getPrefix;
- (void) setKeyPressEventDelegate:(id<Epos2KbdKeyPressDelegate>)delegate;
- (void) setReadStringEventDelegate:(id<Epos2KbdReadStringDelegate>)delegate;

- (void) setConnectionEventDelegate:(id<Epos2ConnectionDelegate>)delegate;
- (NSString *) getAdmin;
- (NSString *) getLocation;
@end

@interface Epos2ScannerStatusInfo : NSObject
@property(readonly, getter=getConnection) int connection;
@end

@interface Epos2BarcodeScanner : NSObject
- (id) init;
- (void) dealloc;

- (int) connect:(NSString *) target timeout:(long)timeout;
- (int) disconnect;
- (Epos2ScannerStatusInfo *) getStatus;

- (void) setScanEventDelegate:(id<Epos2ScanDelegate>)delegate;

- (void) setConnectionEventDelegate:(id<Epos2ConnectionDelegate>)delegate;
- (NSString *) getAdmin;
- (NSString *) getLocation;
@end

@interface Epos2SimpleSerialStatusInfo : NSObject
@property(readonly, getter=getConnection) int connection;
@end

@interface Epos2SimpleSerial : NSObject
- (id) init;
- (void) dealloc;
- (int) connect:(NSString *) target timeout:(long)timeout;
- (int) disconnect;
- (Epos2SimpleSerialStatusInfo *) getStatus;

- (int) sendCommand:(NSData *)data;
- (void) setReceiveEventDelegate:(id<Epos2SimpleSerialReceiveDelegate>)delegate;

- (void) setConnectionEventDelegate:(id<Epos2ConnectionDelegate>)delegate;
- (NSString *) getAdmin;
- (NSString *) getLocation;
@end

@interface Epos2CommBoxStatusInfo : NSObject
@property(readonly, getter=getConnection) int connection;
@end

@interface Epos2CommBox : NSObject
- (id) init;
- (void) dealloc;
- (int) connect:(NSString *)target timeout:(long)timeout myId:(NSString *)myId;
- (int) disconnect;
- (Epos2CommBoxStatusInfo *) getStatus;

- (int) getCommHistory:(id<Epos2GetCommHistoryDelegate>)delegate;
- (int) sendMessage:(NSString *)message targetId:(NSString *)targetId delegate:(id<Epos2CommBoxSendMessageDelegate>)delegate;
- (void) setReceiveEventDelegate:(id<Epos2CommBoxReceiveDelegate>)delegate;

- (void) setConnectionEventDelegate:(id<Epos2ConnectionDelegate>)delegate;
- (NSString *) getAdmin;
- (NSString *) getLocation;
@end

@interface Epos2CashChangerStatusInfo : NSObject
@property(readonly, getter=getConnection) int connection;
@end

@interface Epos2CashChanger : NSObject
- (id) init;
- (void) dealloc;

- (int) connect:(NSString *) target timeout:(long)timeout;
- (int) disconnect;
- (Epos2CashChangerStatusInfo *) getStatus;

- (int) getOposErrorCode;
- (int) setConfigCountMode:(int)countMode;
- (int) setConfigLeftCash:(long)coins bills:(long)bills;
- (int) readCashCount;
- (int) beginDeposit;
- (int) pauseDeposit;
- (int) restartDeposit;
- (int) endDeposit:(int)config;
- (int) dispenseChange:(long)cash;
- (int) dispenseCash:(NSDictionary *)data;
- (int) collectCash:(int)type;
- (int) openDrawer;
- (int) sendCommand:(NSData *)data;
- (int) sendDirectIOCommand:(long)command data:(long)data string:(NSString *)string;

- (void) setConfigChangeEventDelegate:(id<Epos2CChangerConfigChangeDelegate>)delegate;
- (void) setCashCountEventDelegate:(id<Epos2CChangerCashCountDelegate>)delegate;
- (void) setDepositEventDelegate:(id<Epos2CChangerDepositDelegate>)delegate;
- (void) setDispenseEventDelegate:(id<Epos2CChangerDispenseDelegate>)delegate;
- (void) setCollectEventDelegate:(id<Epos2CChangerCollectDelegate>)delegate;
- (void) setCommandReplyEventDelegate:(id<Epos2CChangerCommandReplyDelegate>)delegate;
- (void) setDirectIOCommandReplyEventDelegate:(id<Epos2CChangerDirectIOCommandReplyDelegate>)delegate;
- (void) setStatusChangeEventDelegate:(id<Epos2CChangerStatusChangeDelegate>)delegate;
- (void) setDirectIOEventDelegate:(id<Epos2CChangerDirectIODelegate>)delegate;
- (void) setStatusUpdateEventDelegate:(id<Epos2CChangerStatusUpdateDelegate>)delegate;

- (void) setConnectionEventDelegate:(id<Epos2ConnectionDelegate>)delegate;
- (NSString *) getAdmin;
- (NSString *) getLocation;
@end

@interface Epos2POSKeyboardStatusInfo : NSObject
@property(readonly, getter=getConnection) int connection;
@end

@interface Epos2POSKeyboard : NSObject
- (id) init;
- (void) dealloc;

- (int) connect:(NSString *) target timeout:(long)timeout;
- (int) disconnect;
- (Epos2POSKeyboardStatusInfo *) getStatus;

- (void) setKeyPressEventDelegate:(id<Epos2POSKbdKeyPressDelegate>)delegate;

- (void) setConnectionEventDelegate:(id<Epos2ConnectionDelegate>)delegate;
- (NSString *) getAdmin;
- (NSString *) getLocation;
@end

@interface Epos2CATStatusInfo : NSObject
@property(readonly, getter=getConnection) int connection;
@end

@interface Epos2CATAuthorizeResult : NSObject
@property(nonatomic, readonly, copy, getter=getAccountNumber) NSString * accountNumber;
@property(nonatomic, readonly, getter=getSettledAmount) long settledAmount;
@property(nonatomic, readonly, copy, getter=getSlipNumber) NSString * slipNumber;
@property(nonatomic, readonly, copy, getter=getKid) NSString * kid;
@property(nonatomic, readonly, copy, getter=getApprovalCode) NSString * approvalCode;
@property(nonatomic, readonly, copy, getter=getTransactionNumber) NSString * transactionNumber;
@property(nonatomic, readonly, getter=getPaymentCondition) int paymentCondition;
@property(nonatomic, readonly, copy, getter=getVoidSlipNumber) NSString * voidSlipNumber;
@property(nonatomic, readonly, getter=getBalance) long balance;
@property(nonatomic, readonly, getter=getAdditionalSecurityInformation) NSString * additionalSecurityInformation;
@property(nonatomic, readonly, getter=getTransactionType) NSString * transactionType;
@end

@interface Epos2CATDailyLog : NSObject
@property(nonatomic, readonly, copy, getter=getKid) NSString * kid;
@property(nonatomic, readonly, getter=getSalesCount) long long salesCount;
@property(nonatomic, readonly, getter=getSalesAmount) long long salesAmount;
@property(nonatomic, readonly, getter=getVoidCount) long long voidCount;
@property(nonatomic, readonly, getter=getVoidAmount) long long voidAmount;
@end

@interface Epos2CATDirectIOResult : NSObject
@property(nonatomic, readonly, copy, getter=getAccountNumber) NSString * accountNumber;
@property(nonatomic, readonly, getter=getSettledAmount) long settledAmount;
@property(nonatomic, readonly, copy, getter=getSlipNumber) NSString * slipNumber;
@property(nonatomic, readonly, copy, getter=getTransactionNumber) NSString * transactionNumber;
@property(nonatomic, readonly, getter=getPaymentCondition) int paymentCondition;
@property(nonatomic, readonly, getter=getBalance) long balance;
@property(nonatomic, readonly, copy, getter=getAdditionalSecurityInformation) NSString * additionalSecurityInformation;
@end

@interface Epos2CAT : NSObject
- (id) init;
- (void) dealloc;

- (int) setTimeout:(long)timeout;
- (long) getTimeout;
- (int) setTrainingMode:(int)mode;
- (int) getTrainingMode;

- (int) connect:(NSString *) target timeout:(long)timeout;
- (int) disconnect;
- (Epos2CATStatusInfo *) getStatus;

- (int) getOposErrorCode;
- (int) authorizeSales:(int)service totalAmount:(long)totalAmount sequence:(long)sequence;
- (int) authorizeSales:(int)service totalAmount:(long)totalAmount amount:(long)amount tax:(long)tax sequence:(long)sequence additionalSecurityInformation:(NSString*) asi;
- (int) authorizeVoid:(int)service totalAmount:(long)totalAmount sequence:(long)sequence;
- (int) authorizeVoid:(int)service totalAmount:(long)totalAmount amount:(long)amount tax:(long)tax sequence:(long)sequence additionalSecurityInformation:(NSString*) asi;
- (int) authorizeRefund:(int)service totalAmount:(long)totalAmount sequence:(long)sequence;
- (int) authorizeCompletion:(int)service totalAmount:(long)totalAmount sequence:(long)sequence;
- (int) authorizeCompletion:(int)service totalAmount:(long)totalAmount amount:(long)amount tax:(long)tax sequence:(long)sequence additionalSecurityInformation:(NSString*) asi;
- (int) accessDailyLog:(int)service sequence:(long)sequence;
- (int) accessDailyLog:(int)service sequence:(long)sequence dailyLogType:(NSString *)dailyLogType additionalSecurityInformation:(NSString*) asi;
- (int) sendDirectIOCommand:(long)command data:(long)data string:(NSString *)string service:(int)service;
- (int) sendDirectIOCommand:(long)command data:(long)data string:(NSString *)string service:(int)service additionalSecurityInformation:(NSString*) asi;
- (int) checkConnection:(NSString*) asi;
- (int) clearOutput;

- (void) setAuthorizeSalesEventDelegate:(id<Epos2CATAuthorizeSalesDelegate>)delegate;
- (void) setAuthorizeVoidEventDelegate:(id<Epos2CATAuthorizeVoidDelegate>)delegate;
- (void) setAuthorizeRefundEventDelegate:(id<Epos2CATAuthorizeRefundDelegate>)delegate;
- (void) setAuthorizeCompletionEventDelegate:(id<Epos2CATAuthorizeCompletionDelegate>)delegate;
- (void) setAccessDailyLogEventDelegate:(id<Epos2CATAccessDailyLogDelegate>)delegate;
- (void) setDirectIOCommandReplyEventDelegate:(id<Epos2CATDirectIOCommandReplyDelegate>)delegate;
- (void) setStatusUpdateEventDelegate:(id<Epos2CATStatusUpdateDelegate>)delegate;
- (void) setDirectIOEventDelegate:(id<Epos2CATDirectIODelegate>)delegate;
- (void) setCheckConnectionEventDelegate:(id<Epos2CATCheckConnectionDelegate>)delegate;
- (void) setClearOutputEventDelegate:(id<Epos2CATClearOutputDelegate>)delegate;
- (void) setConnectionEventDelegate:(id<Epos2ConnectionDelegate>)delegate;
- (NSString *) getAdmin;
- (NSString *) getLocation;
@end

@interface Epos2MSRStatusInfo : NSObject
@property(readonly, getter=getConnection) int connection;
@end

@interface Epos2MSRData : NSObject
@property(nonatomic, readonly, copy, getter=getTrack1) NSString *track1;
@property(nonatomic, readonly, copy, getter=getTrack2) NSString *track2;
@property(nonatomic, readonly, copy, getter=getTrack4) NSString *track4;
@property(nonatomic, readonly, copy, getter=getAccountNumber) NSString *accountNumber;
@property(nonatomic, readonly, copy, getter=getExpirationData) NSString *expirationData;
@property(nonatomic, readonly, copy, getter=getSurname) NSString *surname;
@property(nonatomic, readonly, copy, getter=getFirstName) NSString *firstName;
@property(nonatomic, readonly, copy, getter=getMiddleInitial) NSString *middleInitial;
@property(nonatomic, readonly, copy, getter=getTitle) NSString *title;
@property(nonatomic, readonly, copy, getter=getServiceCode) NSString *serviceCode;
@property(nonatomic, readonly, copy, getter=getTrack1_dd) NSString *track1_dd;
@property(nonatomic, readonly, copy, getter=getTrack2_dd) NSString *track2_dd;
@end

@interface Epos2MSR : NSObject
- (id) init;
- (void) dealloc;

- (int) connect:(NSString *) target timeout:(long)timeout;
- (int) disconnect;
- (Epos2MSRStatusInfo *) getStatus;

- (void) setDataEventDelegate:(id<Epos2MSRDataDelegate>)delegate;

- (void) setConnectionEventDelegate:(id<Epos2ConnectionDelegate>)delegate;
- (NSString *) getAdmin;
- (NSString *) getLocation;
@end

@interface Epos2OtherPeripheralStatusInfo : NSObject
@property(readonly, getter=getConnection) int connection;
@end

@interface Epos2OtherPeripheral : NSObject
- (id) init;
- (void) dealloc;

- (int) connect:(NSString *) target timeout:(long)timeout;
- (int) disconnect;
- (Epos2OtherPeripheralStatusInfo *) getStatus;

- (int)sendData:(NSString *)methodName data:(NSString *)data;
- (void) setReceiveEventDelegate:(id<Epos2OtherReceiveDelegate>)delegate;

- (void) setConnectionEventDelegate:(id<Epos2ConnectionDelegate>)delegate;
- (NSString *) getAdmin;
- (NSString *) getLocation;
@end

@interface Epos2GermanyFiscalElementStatusinfo : NSObject
@property(readonly, getter=getConnection) int connection;
@end

@interface Epos2GermanyFiscalElement : NSObject
- (id) init;
- (void) dealloc;

- (int) connect:(NSString *) target timeout:(long)timeout;
- (int) disconnect;
- (Epos2GermanyFiscalElementStatusinfo *) getStatus;
- (int) operate:(NSString *)jsonString timeout:(long)timeout;
- (void) setReceiveEventDelegate:(id<Epos2GermanyFiscalElementReceiveDelegate>)delegate;

- (void) setConnectionEventDelegate:(id<Epos2ConnectionDelegate>)delegate;
- (NSString *) getAdmin;
- (NSString *) getLocation;
@end

@interface Epos2FirmwareInfo : NSObject
@property(nonatomic, copy, readonly, getter=getVersion) NSString *version;
@end

@interface Epos2FilterOption : NSObject
@property(nonatomic, getter=getPortType, setter=setPortType:) int portType;
@property(nonatomic, copy, getter=getBroadcast, setter=setBroadcast:) NSString *broadcast;
@property(nonatomic, getter=getDeviceModel, setter=setDeviceModel:) int deviceModel;
@property(nonatomic, getter=getDeviceType, setter=setDeviceType:) int deviceType;
@end

@interface Epos2DeviceInfo : NSObject
@property(nonatomic, readonly, getter=getDeviceType) int deviceType;
@property(nonatomic, copy, readonly, getter=getTarget) NSString *target;
@property(nonatomic, copy, readonly, getter=getDeviceName) NSString *deviceName;
@property(nonatomic, copy, readonly, getter=getIpAddress) NSString *ipAddress;
@property(nonatomic, copy, readonly, getter=getMacAddress) NSString *macAddress;
@property(nonatomic, copy, readonly, getter=getBdAddress) NSString *bdAddress;
@end

@interface Epos2Discovery : NSObject
+ (int) start:(Epos2FilterOption *)filterOption delegate:(id<Epos2DiscoveryDelegate>)delegate;
+ (int) stop;
@end

@interface Epos2Log : NSObject
+ (int) setLogSettings:(int)period output:(int)output ipAddress:(NSString *)ipAddress port:(int)port logSize:(int)logSize logLevel:(int)logLevel;
+(NSString *) getSdkVersion;
@end


enum Epos2BtConnection : int {
    EPOS2_BT_SUCCESS = 0,
    EPOS2_BT_ERR_PARAM,
    EPOS2_BT_ERR_UNSUPPORTED,
    EPOS2_BT_ERR_CANCEL,
    EPOS2_BT_ERR_ALREADY_CONNECT,
    EPOS2_BT_ERR_ILLEGAL_DEVICE,
    EPOS2_BT_ERR_FAILURE = 255
};

@interface Epos2BluetoothConnection : NSObject
- (id) init;
- (void) dealloc;
- (int) connectDevice : (NSMutableString *)target;
- (int) disconnectDevice : (NSString *)target;
@end

#endif  /*__OBJC__*/
