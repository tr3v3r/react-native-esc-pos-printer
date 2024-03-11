#import "EscPosPrinter.h"
#import "ErrorManager.h"
#import <React/RCTConvert.h>

#import "ThePrinterWrapper.h"
#import "ThePrinter.h"
#import "EposStringHelper.h"

@interface EscPosPrinter() <PrinterDelegate>

@end

@implementation EscPosPrinter

int EPOS2_ERR_INIT = -1;

RCT_EXPORT_MODULE()
- (id)init {
    self = [super init];
    if (self) {
         objManager_ = [ThePrinterManager sharedManager];
         [objManager_ removeAll];
    }

    return  self;
}

- (NSArray<NSString *> *)supportedEvents {
    return @[@"onPrintSuccess", @"onPrintFailure", @"onGetPaperWidthSuccess", @"onGetPaperWidthFailure", @"onMonitorStatusUpdate"];
}

- (NSDictionary *)constantsToExport
{
 return @{
    // init models lang
    @"MODEL_ANK": @(EPOS2_MODEL_ANK),
    @"MODEL_CHINESE": @(EPOS2_MODEL_CHINESE),
    @"MODEL_TAIWAN": @(EPOS2_MODEL_TAIWAN),
    @"MODEL_KOREAN": @(EPOS2_MODEL_KOREAN),
    @"MODEL_THAI": @(EPOS2_MODEL_THAI),
    @"MODEL_SOUTHASIA": @(EPOS2_MODEL_SOUTHASIA),


    // cut types
    @"CUT_FEED": @(EPOS2_CUT_FEED),
    @"CUT_NO_FEED": @(EPOS2_CUT_NO_FEED),
    @"CUT_RESERVE": @(EPOS2_CUT_RESERVE),
    @"FULL_CUT_FEED": @(EPOS2_FULL_CUT_FEED),
    @"FULL_CUT_NO_FEED": @(EPOS2_FULL_CUT_NO_FEED),
    @"FULL_CUT_RESERVE": @(EPOS2_FULL_CUT_RESERVE),
    @"PARAM_DEFAULT": @(EPOS2_PARAM_DEFAULT),
    @"PARAM_UNSPECIFIED": @(EPOS2_PARAM_UNSPECIFIED),

    // errors
    @"ERR_PARAM": @(EPOS2_ERR_PARAM),
    @"ERR_MEMORY": @(EPOS2_ERR_MEMORY),
    @"ERR_UNSUPPORTED": @(EPOS2_ERR_UNSUPPORTED),
    @"ERR_FAILURE": @(EPOS2_ERR_FAILURE),
    @"ERR_PROCESSING": @(EPOS2_ERR_PROCESSING),
    @"ERR_CONNECT": @(EPOS2_ERR_CONNECT),
    @"ERR_TIMEOUT": @(EPOS2_ERR_TIMEOUT),
    @"ERR_ILLEGAL": @(EPOS2_ERR_ILLEGAL),
    @"ERR_NOT_FOUND": @(EPOS2_ERR_NOT_FOUND),
    @"ERR_IN_USE": @(EPOS2_ERR_IN_USE),
    @"ERR_TYPE_INVALID": @(EPOS2_ERR_TYPE_INVALID),
    @"ERR_RECOVERY_FAILURE": @(EPOS2_ERR_RECOVERY_FAILURE),
    @"ERR_DISCONNECT": @(EPOS2_ERR_DISCONNECT),
    @"ERR_INIT": @(EPOS2_ERR_INIT),

    // code errors
    @"CODE_ERR_AUTORECOVER": @(EPOS2_CODE_ERR_AUTORECOVER),
    @"CODE_ERR_COVER_OPEN": @(EPOS2_CODE_ERR_COVER_OPEN),
    @"CODE_ERR_CUTTER": @(EPOS2_CODE_ERR_CUTTER),
    @"CODE_ERR_MECHANICAL": @(EPOS2_CODE_ERR_MECHANICAL),
    @"CODE_ERR_EMPTY": @(EPOS2_CODE_ERR_EMPTY),
    @"CODE_ERR_UNRECOVERABLE": @(EPOS2_CODE_ERR_UNRECOVERABLE),
    @"CODE_ERR_FAILURE": @(EPOS2_CODE_ERR_FAILURE),
    @"CODE_ERR_NOT_FOUND": @(EPOS2_CODE_ERR_NOT_FOUND),
    @"CODE_ERR_SYSTEM": @(EPOS2_CODE_ERR_SYSTEM),
    @"CODE_ERR_PORT": @(EPOS2_CODE_ERR_PORT),
    @"CODE_ERR_TIMEOUT": @(EPOS2_CODE_ERR_TIMEOUT),
    @"CODE_ERR_JOB_NOT_FOUND": @(EPOS2_CODE_ERR_JOB_NOT_FOUND),
    @"CODE_ERR_SPOOLER": @(EPOS2_CODE_ERR_SPOOLER),
    @"CODE_ERR_BATTERY_LOW": @(EPOS2_CODE_ERR_BATTERY_LOW),
    @"CODE_ERR_TOO_MANY_REQUESTS": @(EPOS2_CODE_ERR_TOO_MANY_REQUESTS),
    @"CODE_ERR_REQUEST_ENTITY_TOO_LARGE": @(EPOS2_CODE_ERR_REQUEST_ENTITY_TOO_LARGE),
    @"CODE_ERR_WAIT_REMOVAL": @(EPOS2_CODE_ERR_WAIT_REMOVAL),
    @"CODE_PRINTING": @(EPOS2_CODE_PRINTING),
    @"CODE_ERR_PARAM": @(EPOS2_CODE_ERR_PARAM),
    @"CODE_ERR_MEMORY": @(EPOS2_CODE_ERR_MEMORY),
    @"CODE_ERR_PROCESSING": @(EPOS2_CODE_ERR_PROCESSING),
    @"CODE_ERR_ILLEGAL": @(EPOS2_CODE_ERR_ILLEGAL),
    @"CODE_ERR_DEVICE_BUSY": @(EPOS2_CODE_ERR_DEVICE_BUSY),

    // get printer settings
    @"PRINTER_SETTING_PAPERWIDTH": @(EPOS2_PRINTER_SETTING_PAPERWIDTH),
    @"PRINTER_SETTING_PRINTDENSITY": @(EPOS2_PRINTER_SETTING_PRINTDENSITY),
    @"PRINTER_SETTING_PRINTSPEED": @(EPOS2_PRINTER_SETTING_PRINTSPEED),

    @"PRINTER_SETTING_PAPERWIDTH58_0": @(EPOS2_PRINTER_SETTING_PAPERWIDTH_58_0),
    @"PRINTER_SETTING_PAPERWIDTH60_0": @(EPOS2_PRINTER_SETTING_PAPERWIDTH_60_0),
    @"PRINTER_SETTING_PAPERWIDTH70_0": @(EPOS2_PRINTER_SETTING_PAPERWIDTH_70_0),
    @"PRINTER_SETTING_PAPERWIDTH76_0": @(EPOS2_PRINTER_SETTING_PAPERWIDTH_76_0),
    @"PRINTER_SETTING_PAPERWIDTH80_0": @(EPOS2_PRINTER_SETTING_PAPERWIDTH_80_0),
    @"PRINTER_SETTING_PRINTDENSITYDIP": @(EPOS2_PRINTER_SETTING_PRINTDENSITY_DIP),
    @"PRINTER_SETTING_PRINTDENSITY70": @(EPOS2_PRINTER_SETTING_PRINTDENSITY_70),
    @"PRINTER_SETTING_PRINTDENSITY75": @(EPOS2_PRINTER_SETTING_PRINTDENSITY_75),
    @"PRINTER_SETTING_PRINTDENSITY80": @(EPOS2_PRINTER_SETTING_PRINTDENSITY_80),
    @"PRINTER_SETTING_PRINTDENSITY85": @(EPOS2_PRINTER_SETTING_PRINTDENSITY_85),
    @"PRINTER_SETTING_PRINTDENSITY90": @(EPOS2_PRINTER_SETTING_PRINTDENSITY_90),
    @"PRINTER_SETTING_PRINTDENSITY95": @(EPOS2_PRINTER_SETTING_PRINTDENSITY_95),
    @"PRINTER_SETTING_PRINTDENSITY100": @(EPOS2_PRINTER_SETTING_PRINTDENSITY_100),
    @"PRINTER_SETTING_PRINTDENSITY105": @(EPOS2_PRINTER_SETTING_PRINTDENSITY_105),
    @"PRINTER_SETTING_PRINTDENSITY110": @(EPOS2_PRINTER_SETTING_PRINTDENSITY_110),
    @"PRINTER_SETTING_PRINTDENSITY115": @(EPOS2_PRINTER_SETTING_PRINTDENSITY_115),
    @"PRINTER_SETTING_PRINTDENSITY120": @(EPOS2_PRINTER_SETTING_PRINTDENSITY_120),
    @"PRINTER_SETTING_PRINTDENSITY125": @(EPOS2_PRINTER_SETTING_PRINTDENSITY_125),
    @"PRINTER_SETTING_PRINTDENSITY130": @(EPOS2_PRINTER_SETTING_PRINTDENSITY_130),
    @"PRINTER_SETTING_PRINTSPEED1": @(EPOS2_PRINTER_SETTING_PRINTSPEED_1),
    @"PRINTER_SETTING_PRINTSPEED2": @(EPOS2_PRINTER_SETTING_PRINTSPEED_2),
    @"PRINTER_SETTING_PRINTSPEED3": @(EPOS2_PRINTER_SETTING_PRINTSPEED_3),
    @"PRINTER_SETTING_PRINTSPEED4": @(EPOS2_PRINTER_SETTING_PRINTSPEED_4),
    @"PRINTER_SETTING_PRINTSPEED5": @(EPOS2_PRINTER_SETTING_PRINTSPEED_5),
    @"PRINTER_SETTING_PRINTSPEED6": @(EPOS2_PRINTER_SETTING_PRINTSPEED_6),
    @"PRINTER_SETTING_PRINTSPEED7": @(EPOS2_PRINTER_SETTING_PRINTSPEED_7),
    @"PRINTER_SETTING_PRINTSPEED8": @(EPOS2_PRINTER_SETTING_PRINTSPEED_8),
    @"PRINTER_SETTING_PRINTSPEED9": @(EPOS2_PRINTER_SETTING_PRINTSPEED_9),
    @"PRINTER_SETTING_PRINTSPEED10": @(EPOS2_PRINTER_SETTING_PRINTSPEED_10),
    @"PRINTER_SETTING_PRINTSPEED11": @(EPOS2_PRINTER_SETTING_PRINTSPEED_11),
    @"PRINTER_SETTING_PRINTSPEED12": @(EPOS2_PRINTER_SETTING_PRINTSPEED_12),
    @"PRINTER_SETTING_PRINTSPEED13": @(EPOS2_PRINTER_SETTING_PRINTSPEED_13),
    @"PRINTER_SETTING_PRINTSPEED14": @(EPOS2_PRINTER_SETTING_PRINTSPEED_14),
    @"PRINTER_SETTING_PRINTSPEED15": @(EPOS2_PRINTER_SETTING_PRINTSPEED_15),
    @"PRINTER_SETTING_PRINTSPEED16": @(EPOS2_PRINTER_SETTING_PRINTSPEED_16),
    @"PRINTER_SETTING_PRINTSPEED17": @(EPOS2_PRINTER_SETTING_PRINTSPEED_17),

    // printer status
    @"TRUE": @(EPOS2_TRUE),
    @"FALSE": @(EPOS2_FALSE),
    @"UNKNOWN": @(EPOS2_UNKNOWN),
    @"PAPER_OK": @(EPOS2_PAPER_OK),
    @"PAPER_NEAR_END": @(EPOS2_PAPER_NEAR_END),
    @"PAPER_EMPTY": @(EPOS2_PAPER_EMPTY),
    @"SWITCH_ON": @(EPOS2_SWITCH_ON),
    @"SWITCH_OFF": @(EPOS2_SWITCH_OFF),
    @"DRAWER_HIGH": @(EPOS2_DRAWER_HIGH),
    @"DRAWER_LOW": @(EPOS2_DRAWER_LOW),
    @"NO_ERR": @(EPOS2_NO_ERR),
    @"MECHANICAL_ERR": @(EPOS2_MECHANICAL_ERR),
    @"AUTOCUTTER_ERR": @(EPOS2_AUTOCUTTER_ERR),
    @"UNRECOVER_ERR": @(EPOS2_UNRECOVER_ERR),
    @"AUTORECOVER_ERR": @(EPOS2_AUTORECOVER_ERR),
    @"HEAD_OVERHEAT": @(EPOS2_HEAD_OVERHEAT),
    @"MOTOR_OVERHEAT": @(EPOS2_MOTOR_OVERHEAT),
    @"BATTERY_OVERHEAT": @(EPOS2_BATTERY_OVERHEAT),
    @"WRONG_PAPER": @(EPOS2_WRONG_PAPER),
    @"COVER_OPEN": @(EPOS2_COVER_OPEN),
    @"EPOS2_BATTERY_LEVEL_6": @(EPOS2_BATTERY_LEVEL_6),
    @"EPOS2_BATTERY_LEVEL_5": @(EPOS2_BATTERY_LEVEL_5),
    @"EPOS2_BATTERY_LEVEL_4": @(EPOS2_BATTERY_LEVEL_4),
    @"EPOS2_BATTERY_LEVEL_3": @(EPOS2_BATTERY_LEVEL_3),
    @"EPOS2_BATTERY_LEVEL_2": @(EPOS2_BATTERY_LEVEL_2),
    @"EPOS2_BATTERY_LEVEL_1": @(EPOS2_BATTERY_LEVEL_1),
    @"EPOS2_BATTERY_LEVEL_0": @(EPOS2_BATTERY_LEVEL_0),
    @"REMOVAL_WAIT_PAPER": @(EPOS2_REMOVAL_WAIT_PAPER),
    @"REMOVAL_WAIT_NONE": @(EPOS2_REMOVAL_WAIT_NONE),
    @"REMOVAL_DETECT_PAPER": @(EPOS2_REMOVAL_DETECT_PAPER),
    @"REMOVAL_DETECT_PAPER_NONE": @(EPOS2_REMOVAL_DETECT_PAPER_NONE),
    @"REMOVAL_DETECT_UNKNOWN": @(EPOS2_REMOVAL_DETECT_UNKNOWN),
    @"HIGH_VOLTAGE_ERR": @(EPOS2_HIGH_VOLTAGE_ERR),
    @"LOW_VOLTAGE_ERR": @(EPOS2_LOW_VOLTAGE_ERR),

    // image
    @"COLOR_NONE": @(EPOS2_COLOR_NONE),
    @"COLOR_1": @(EPOS2_COLOR_1),
    @"COLOR_2": @(EPOS2_COLOR_2),
    @"COLOR_3": @(EPOS2_COLOR_3),
    @"COLOR_4": @(EPOS2_COLOR_4),
    @"MODE_MONO": @(EPOS2_MODE_MONO),
    @"MODE_GRAY16": @(EPOS2_MODE_GRAY16),
    @"MODE_MONO_HIGH_DENSITY": @(EPOS2_MODE_MONO_HIGH_DENSITY),
    @"HALFTONE_DITHER": @(EPOS2_HALFTONE_DITHER),
    @"HALFTONE_ERROR_DIFFUSION": @(EPOS2_HALFTONE_ERROR_DIFFUSION),
    @"HALFTONE_THRESHOLD": @(EPOS2_HALFTONE_THRESHOLD),
    @"COMPRESS_DEFLATE": @(EPOS2_COMPRESS_DEFLATE),
    @"COMPRESS_NONE": @(EPOS2_COMPRESS_NONE),
    @"COMPRESS_AUTO": @(EPOS2_COMPRESS_AUTO),

    // barcode
    @"BARCODE_UPC_A": @(EPOS2_BARCODE_UPC_A),
    @"BARCODE_UPC_E": @(EPOS2_BARCODE_UPC_E),
    @"BARCODE_EAN13": @(EPOS2_BARCODE_EAN13),
    @"BARCODE_JAN13": @(EPOS2_BARCODE_JAN13),
    @"BARCODE_EAN8": @(EPOS2_BARCODE_EAN8),
    @"BARCODE_JAN8": @(EPOS2_BARCODE_JAN8),
    @"BARCODE_CODE39": @(EPOS2_BARCODE_CODE39),
    @"BARCODE_ITF": @(EPOS2_BARCODE_ITF),
    @"BARCODE_CODABAR": @(EPOS2_BARCODE_CODABAR),
    @"BARCODE_CODE93": @(EPOS2_BARCODE_CODE93),
    @"BARCODE_CODE128": @(EPOS2_BARCODE_CODE128),
    @"BARCODE_CODE128_AUTO": @(EPOS2_BARCODE_CODE128_AUTO),
    @"BARCODE_GS1_128": @(EPOS2_BARCODE_GS1_128),
    @"BARCODE_GS1_DATABAR_OMNIDIRECTIONAL": @(EPOS2_BARCODE_GS1_DATABAR_OMNIDIRECTIONAL),
    @"BARCODE_GS1_DATABAR_TRUNCATED": @(EPOS2_BARCODE_GS1_DATABAR_TRUNCATED),
    @"BARCODE_GS1_DATABAR_LIMITED": @(EPOS2_BARCODE_GS1_DATABAR_LIMITED),
    @"BARCODE_GS1_DATABAR_EXPANDED": @(EPOS2_BARCODE_GS1_DATABAR_EXPANDED),
    @"HRI_NONE": @(EPOS2_HRI_NONE),
    @"HRI_ABOVE": @(EPOS2_HRI_ABOVE),
    @"HRI_BELOW": @(EPOS2_HRI_BELOW),
    @"HRI_BOTH": @(EPOS2_HRI_BOTH),

    // font
    @"FONT_A": @(EPOS2_FONT_A),
    @"FONT_B": @(EPOS2_FONT_B),
    @"FONT_C": @(EPOS2_FONT_C),
    @"FONT_D": @(EPOS2_FONT_D),
    @"FONT_E": @(EPOS2_FONT_E),

    // symbol

    @"SYMBOL_PDF417_STANDARD": @(EPOS2_SYMBOL_PDF417_STANDARD),
    @"SYMBOL_PDF417_TRUNCATED": @(EPOS2_SYMBOL_PDF417_TRUNCATED),
    @"SYMBOL_QRCODE_MODEL_1": @(EPOS2_SYMBOL_QRCODE_MODEL_1),
    @"SYMBOL_QRCODE_MODEL_2": @(EPOS2_SYMBOL_QRCODE_MODEL_2),
    @"SYMBOL_QRCODE_MICRO": @(EPOS2_SYMBOL_QRCODE_MICRO),
    @"SYMBOL_MAXICODE_MODE_2": @(EPOS2_SYMBOL_MAXICODE_MODE_2),
    @"SYMBOL_MAXICODE_MODE_3": @(EPOS2_SYMBOL_MAXICODE_MODE_3),
    @"SYMBOL_MAXICODE_MODE_4": @(EPOS2_SYMBOL_MAXICODE_MODE_4),
    @"SYMBOL_MAXICODE_MODE_5": @(EPOS2_SYMBOL_MAXICODE_MODE_5),
    @"SYMBOL_MAXICODE_MODE_6": @(EPOS2_SYMBOL_MAXICODE_MODE_6),
    @"SYMBOL_GS1_DATABAR_STACKED": @(EPOS2_SYMBOL_GS1_DATABAR_STACKED),
    @"SYMBOL_GS1_DATABAR_STACKED_OMNIDIRECTIONAL": @(EPOS2_SYMBOL_GS1_DATABAR_STACKED_OMNIDIRECTIONAL),
    @"SYMBOL_GS1_DATABAR_EXPANDED_STACKED": @(EPOS2_SYMBOL_GS1_DATABAR_EXPANDED_STACKED),
    @"SYMBOL_AZTECCODE_FULLRANGE": @(EPOS2_SYMBOL_AZTECCODE_FULLRANGE),
    @"SYMBOL_AZTECCODE_COMPACT": @(EPOS2_SYMBOL_AZTECCODE_COMPACT),
    @"SYMBOL_DATAMATRIX_SQUARE": @(EPOS2_SYMBOL_DATAMATRIX_SQUARE),
    @"SYMBOL_DATAMATRIX_RECTANGLE_8": @(EPOS2_SYMBOL_DATAMATRIX_RECTANGLE_8),
    @"SYMBOL_DATAMATRIX_RECTANGLE_12": @(EPOS2_SYMBOL_DATAMATRIX_RECTANGLE_12),
    @"SYMBOL_DATAMATRIX_RECTANGLE_16": @(EPOS2_SYMBOL_DATAMATRIX_RECTANGLE_16),
    @"LEVEL_0": @(EPOS2_LEVEL_0),
    @"LEVEL_1": @(EPOS2_LEVEL_1),
    @"LEVEL_2": @(EPOS2_LEVEL_2),
    @"LEVEL_3": @(EPOS2_LEVEL_3),
    @"LEVEL_4": @(EPOS2_LEVEL_4),
    @"LEVEL_5": @(EPOS2_LEVEL_5),
    @"LEVEL_6": @(EPOS2_LEVEL_6),
    @"LEVEL_7": @(EPOS2_LEVEL_7),
    @"LEVEL_8": @(EPOS2_LEVEL_8),
    @"LEVEL_L": @(EPOS2_LEVEL_L),
    @"LEVEL_M": @(EPOS2_LEVEL_M),
    @"LEVEL_Q": @(EPOS2_LEVEL_Q),
    @"LEVEL_H": @(EPOS2_LEVEL_H),


    // add pulse

    @"DRAWER_2PIN": @(EPOS2_DRAWER_2PIN),
    @"DRAWER_5PIN": @(EPOS2_DRAWER_5PIN),
    @"PULSE_100": @(EPOS2_PULSE_100),
    @"PULSE_200": @(EPOS2_PULSE_200),
    @"PULSE_300": @(EPOS2_PULSE_300),
    @"PULSE_400": @(EPOS2_PULSE_400),
    @"PULSE_500": @(EPOS2_PULSE_500),

    // text align

    @"ALIGN_LEFT": @(EPOS2_ALIGN_LEFT),
    @"ALIGN_CENTER": @(EPOS2_ALIGN_CENTER),
    @"ALIGN_RIGHT": @(EPOS2_ALIGN_RIGHT),
   };
}

+ (BOOL)requiresMainQueueSetup
{
  return YES;
}

RCT_EXPORT_METHOD(initWithPrinterDeviceName:(NSString *)target
                  deviceName:(NSString *)deviceName
                  lang:(int)lang
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)
{
     @synchronized (self) {
        ThePrinter* thePrinter = [objManager_ getObject:target];

        if (thePrinter == nil) {
            int series = [EposStringHelper getPrinterSeries: deviceName];
            thePrinter = [[ThePrinter alloc] initWith:target series:series lang:lang delegate:self];
            [objManager_ add:thePrinter];
        }

        Epos2Printer* printer = [thePrinter getEpos2Printer];

        if (printer == nil) {
          reject(@"event_failure", [@(EPOS2_ERR_MEMORY) stringValue], nil);
        } else {
          resolve(nil);
        }
    }
}

RCT_EXPORT_METHOD(connect: (nonnull NSString*)target
                  timeout: (int)timeout
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)
{
    int result = EPOS2_SUCCESS;
    ThePrinter* thePrinter = nil;
    @synchronized (self) {
        thePrinter = [objManager_ getObject:target];
        if (thePrinter == nil) {
            result = EPOS2_ERR_INIT;
        } else {
            int result = [thePrinter connect:timeout startMonitor:false];

            if(result == EPOS2_SUCCESS) {
                resolve(nil);
            } else {
                reject(@"event_failure", [@(result) stringValue], nil);
            }
        }
    }
}

RCT_EXPORT_METHOD(disconnect: (nonnull NSString*) target
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)
{
    int result = EPOS2_SUCCESS;
    @synchronized (self) {
        ThePrinter* thePrinter = [objManager_ getObject:target];
        if (thePrinter == nil) {
            result = EPOS2_ERR_INIT;
        } else {
            result = [thePrinter disconnect];
        }

        if(result == EPOS2_SUCCESS) {
            resolve(nil);
        } else {
            reject(@"event_failure", [@(result) stringValue], nil);
        }
    }
}

RCT_EXPORT_METHOD(addText: (nonnull NSString*) target
                  data: (NSString*) data
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)
{
    int result = EPOS2_SUCCESS;
    @synchronized (self) {
        ThePrinter* thePrinter = [objManager_ getObject:target];
        if (thePrinter == nil) {
            result = EPOS2_ERR_INIT;
        } else {
            result = [thePrinter addText:data];
        }

        if(result == EPOS2_SUCCESS) {
            resolve(nil);
        } else {
            reject(@"event_failure", [@(result) stringValue], nil);
        }
    }
}

RCT_EXPORT_METHOD(addFeedLine: (nonnull NSString*) target
                  line: (int) line
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)
{
    int result = EPOS2_SUCCESS;
    @synchronized (self) {
        ThePrinter* thePrinter = [objManager_ getObject:target];
        if (thePrinter == nil) {
            result = EPOS2_ERR_INIT;
        } else {
            result = [thePrinter addFeedLine:line];
        }

        if(result == EPOS2_SUCCESS) {
            resolve(nil);
        } else {
            reject(@"event_failure", [@(result) stringValue], nil);
        }
    }
}

RCT_EXPORT_METHOD(addCut: (nonnull NSString*) target
                  type: (int)type
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)
{
    int result = EPOS2_SUCCESS;
    @synchronized (self) {
        ThePrinter* thePrinter = [objManager_ getObject:target];
        if (thePrinter == nil) {
            result = EPOS2_ERR_INIT;
        } else {
            result = [thePrinter addCut: type];
        }

        if(result == EPOS2_SUCCESS) {
            resolve(nil);
        } else {
            reject(@"event_failure", [@(result) stringValue], nil);
        }
    }
}

RCT_EXPORT_METHOD(addCommand: (nonnull NSString*) target
                  base64string: (NSString*)base64string
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)
{
    int result = EPOS2_SUCCESS;
    @synchronized (self) {
        ThePrinter* thePrinter = [objManager_ getObject:target];
        if (thePrinter == nil) {
            result = EPOS2_ERR_INIT;
        } else {
            result = [thePrinter addCommand:base64string];
        }

        if(result == EPOS2_SUCCESS) {
            resolve(nil);
        } else {
            reject(@"event_failure", [@(result) stringValue], nil);
        }
    }
}

RCT_EXPORT_METHOD(addPulse: (nonnull NSString*) target
                  drawer: (int)drawer
                  time: (int)time
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)
{
    int result = EPOS2_SUCCESS;
    @synchronized (self) {
        ThePrinter* thePrinter = [objManager_ getObject:target];
        if (thePrinter == nil) {
            result = EPOS2_ERR_INIT;
        } else {
            result = [thePrinter addPulse:drawer time:time];
        }

        if(result == EPOS2_SUCCESS) {
            resolve(nil);
        } else {
            reject(@"event_failure", [@(result) stringValue], nil);
        }
    }
}

RCT_EXPORT_METHOD(addTextAlign: (nonnull NSString*) target
                  align: (int)align
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)
{
    int result = EPOS2_SUCCESS;
    @synchronized (self) {
        ThePrinter* thePrinter = [objManager_ getObject:target];
        if (thePrinter == nil) {
            result = EPOS2_ERR_INIT;
        } else {
            result = [thePrinter addTextAlign:align];
        }

        if(result == EPOS2_SUCCESS) {
            resolve(nil);
        } else {
            reject(@"event_failure", [@(result) stringValue], nil);
        }
    }
}


RCT_EXPORT_METHOD(addTextSize: (nonnull NSString*) target
                  width: (int)width
                  height:(int)height
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)
{
    int result = EPOS2_SUCCESS;
    @synchronized (self) {
        ThePrinter* thePrinter = [objManager_ getObject:target];
        if (thePrinter == nil) {
            result = EPOS2_ERR_INIT;
        } else {
            result = [thePrinter addTextSize:width height:height];
        }

        if(result == EPOS2_SUCCESS) {
            resolve(nil);
        } else {
            reject(@"event_failure", [@(result) stringValue], nil);
        }
    }
}

RCT_EXPORT_METHOD(addTextStyle: (nonnull NSString*) target
                  reverse:(int)reverse
                  ul:(int)ul
                  em:(int)em
                  color:(int)color
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)
{
    int result = EPOS2_SUCCESS;
    @synchronized (self) {
        ThePrinter* thePrinter = [objManager_ getObject:target];
        if (thePrinter == nil) {
            result = EPOS2_ERR_INIT;
        } else {
            result = [thePrinter addTextStyle:reverse ul:ul em:em color:color];
        }

        if(result == EPOS2_SUCCESS) {
            resolve(nil);
        } else {
            reject(@"event_failure", [@(result) stringValue], nil);
        }
    }
}


RCT_EXPORT_METHOD(addTextSmooth: (nonnull NSString*) target
                  smooth: (int)smooth
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)
{
    int result = EPOS2_SUCCESS;
    @synchronized (self) {
        ThePrinter* thePrinter = [objManager_ getObject:target];
        if (thePrinter == nil) {
            result = EPOS2_ERR_INIT;
        } else {
            result = [thePrinter addTextSmooth:smooth];
        }

        if(result == EPOS2_SUCCESS) {
            resolve(nil);
        } else {
            reject(@"event_failure", [@(result) stringValue], nil);
        }
    }
}

RCT_EXPORT_METHOD(getStatus: (nonnull NSString*) target
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)
{
    @synchronized (self) {
        ThePrinter* thePrinter = [objManager_ getObject:target];
        if (thePrinter == nil) {
            reject(@"event_failure", [@(EPOS2_ERR_INIT) stringValue], nil);
        } else {
            NSDictionary* status = [thePrinter getStatus];

            if(status) {
              resolve(status);
            } else {
              reject(@"event_failure", [@(EPOS2_ERR_FAILURE) stringValue], nil);
            }

        }
    }
}


RCT_EXPORT_METHOD(addImage: (nonnull NSString*) target
                  source:(NSDictionary *)source
                  width:(int)width
                  color:(int)color
                  mode:(int)mode
                  halftone:(int)halftone
                  brightness:(float)brightness
                  compress:(int)compress
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)
{
    int result = EPOS2_SUCCESS;
    @synchronized (self) {
        ThePrinter* thePrinter = [objManager_ getObject:target];
        if (thePrinter == nil) {
            result = EPOS2_ERR_INIT;
        } else {
            result = [thePrinter addImage: source width:width color:color mode:mode halftone:halftone brightness:brightness compress:compress];
        }

        if(result == EPOS2_SUCCESS) {
            resolve(nil);
        } else {
            reject(@"event_failure", [@(result) stringValue], nil);
        }
    }
}


RCT_EXPORT_METHOD(addBarcode: (nonnull NSString*) target
                  data:(NSString *)data
                  type:(int)type
                  hri:(int)hri
                  font:(int)font
                  width:(int)width
                  height:(int)height
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)
{
    int result = EPOS2_SUCCESS;
    @synchronized (self) {
        ThePrinter* thePrinter = [objManager_ getObject:target];
        if (thePrinter == nil) {
            result = EPOS2_ERR_INIT;
        } else {
            result = [thePrinter addBarcode: data type:type hri:hri font:font width:width height:height];
        }

        if(result == EPOS2_SUCCESS) {
            resolve(nil);
        } else {
            reject(@"event_failure", [@(result) stringValue], nil);
        }
    }
}

RCT_EXPORT_METHOD(addSymbol: (nonnull NSString*) target
                  data: (NSString *)data
                  type:(int)type
                  level:(int)level
                  width:(int)width
                  height:(int)height
                  size:(int)size
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)
{
    int result = EPOS2_SUCCESS;
    @synchronized (self) {
        ThePrinter* thePrinter = [objManager_ getObject:target];
        if (thePrinter == nil) {
            result = EPOS2_ERR_INIT;
        } else {
            result = [thePrinter addSymbol: data type:type level:level width:width height:height size:size];
        }

        if(result == EPOS2_SUCCESS) {
            resolve(nil);
        } else {
            reject(@"event_failure", [@(result) stringValue], nil);
        }
    }
}

RCT_EXPORT_METHOD(sendData: (nonnull NSString*) target
                  timeout: (int)timeout
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)
{

    @synchronized (self) {
        ThePrinter* thePrinter = [objManager_ getObject:target];
        if (thePrinter == nil) {
            reject(@"event_failure", [@{
                    @"data": @(EPOS2_ERR_INIT),
                    @"type": @"result"
            } description], nil);
        }

        [thePrinter sendData: timeout successHandler:^(NSDictionary *data){
            resolve(data);
        } errorHandler:^(NSString *data) {
            reject(@"event_failure", data, nil);
        }];
    }
}

RCT_EXPORT_METHOD(getPrinterSetting:(nonnull NSString*) target
                  timeout: (int)timeout
                  type: (int)type
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)
{

    @synchronized (self) {
        ThePrinter* thePrinter = [objManager_ getObject:target];
        if (thePrinter == nil) {
            reject(@"event_failure", [@{
                    @"data": @(EPOS2_ERR_INIT),
                    @"type": @"result"
            } description], nil);
        }

        [thePrinter getPrinterSetting: timeout type:type successHandler:^(NSDictionary *data){
            resolve(data);
        } errorHandler:^(NSString *data) {
            reject(@"event_failure", data, nil);
        }];
    }
}

@end
