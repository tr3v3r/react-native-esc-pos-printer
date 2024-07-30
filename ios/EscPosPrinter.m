#import "EscPosPrinter.h"
#import <React/RCTConvert.h>


#import "ThePrinter.h"
#import "ThePrinterManager.h"
#import "EposStringHelper.h"

@interface EscPosPrinter() <PrinterDelegate>

@end

@implementation EscPosPrinter

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
 return  [EposStringHelper getPrinterConstants];
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
            result = [EposStringHelper getInitErrorResultCode];
        } else {
            int result = [thePrinter connect:timeout];

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
            result = [EposStringHelper getInitErrorResultCode];
        } else {
            result = [thePrinter disconnect];
        }

        if(result == EPOS2_SUCCESS || result == EPOS2_ERR_ILLEGAL) {
            resolve(nil);
        } else {
            reject(@"event_failure", [@(result) stringValue], nil);
        }
    }
}

RCT_EXPORT_METHOD(clearCommandBuffer: (nonnull NSString*) target
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)
{
    int result = EPOS2_SUCCESS;
    @synchronized (self) {
        ThePrinter* thePrinter = [objManager_ getObject:target];
        if (thePrinter == nil) {
            result = [EposStringHelper getInitErrorResultCode];
        } else {
            result = [thePrinter clearCommandBuffer];
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
            result = [EposStringHelper getInitErrorResultCode];
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

RCT_EXPORT_METHOD(addTextLang: (nonnull NSString*) target
                  lang: (int) lang
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)
{
    int result = EPOS2_SUCCESS;
    @synchronized (self) {
        ThePrinter* thePrinter = [objManager_ getObject:target];
        if (thePrinter == nil) {
            result = [EposStringHelper getInitErrorResultCode];
        } else {
            result = [thePrinter addTextLang:lang];
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
            result = [EposStringHelper getInitErrorResultCode];
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

RCT_EXPORT_METHOD(addLineSpace: (nonnull NSString*) target
                  linespc: (int) linespc
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)
{
    int result = EPOS2_SUCCESS;
    @synchronized (self) {
        ThePrinter* thePrinter = [objManager_ getObject:target];
        if (thePrinter == nil) {
            result = [EposStringHelper getInitErrorResultCode];
        } else {
            result = [thePrinter addLineSpace:linespc];
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
            result = [EposStringHelper getInitErrorResultCode];
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
            result = [EposStringHelper getInitErrorResultCode];
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
            result = [EposStringHelper getInitErrorResultCode];
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
            result = [EposStringHelper getInitErrorResultCode];
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
            result = [EposStringHelper getInitErrorResultCode];
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
            result = [EposStringHelper getInitErrorResultCode];
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
            result = [EposStringHelper getInitErrorResultCode];
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
            reject(@"event_failure", [@([EposStringHelper getInitErrorResultCode]) stringValue], nil);
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
            result = [EposStringHelper getInitErrorResultCode];
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
            result = [EposStringHelper getInitErrorResultCode];
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
            result = [EposStringHelper getInitErrorResultCode];
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
                    @"data": @([EposStringHelper getInitErrorResultCode]),
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
                    @"data": @([EposStringHelper getInitErrorResultCode]),
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
