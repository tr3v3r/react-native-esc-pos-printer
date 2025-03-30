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

#if RCT_NEW_ARCH_ENABLED
- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params
{
    return std::make_shared<facebook::react::NativeEscPosPrinterSpecJSI>(params);
}
#endif


- (NSDictionary *)constantsToExport
{
 return  [EposStringHelper getPrinterConstants];
}

- (NSDictionary *)getConstants {
    return [self constantsToExport];
}

+ (BOOL)requiresMainQueueSetup
{
  return YES;
}

RCT_EXPORT_METHOD(initWithPrinterDeviceName:(NSString *)target
                  deviceName:(NSString *)deviceName
                  lang:(double)lang
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
{
     @synchronized (self) {
        ThePrinter* thePrinter = [objManager_ getObject:target];

        if (thePrinter == nil) {
            int series = [EposStringHelper getPrinterSeries: deviceName];
             NSLog(@"deviceName: %@", deviceName);

            NSLog(@"series: %d", series);
            thePrinter = [[ThePrinter alloc] initWith:target series:series lang:lang delegate:self];
            NSLog(@"thePrinter: %@", thePrinter);
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
                  timeout: (double)timeout
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
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
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
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
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
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
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
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
                  lang: (double) lang
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
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
                  line: (double) line
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
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
                  linespc: (double) linespc
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
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
                  type: (double)type
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
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
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
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
                  drawer: (double)drawer
                  time: (double)time
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
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
                  align: (double)align
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
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
                  width: (double)width
                  height:(double)height
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
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
                  reverse:(double)reverse
                  ul:(double)ul
                  em:(double)em
                  color:(double)color
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
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
                  smooth: (double)smooth
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
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
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
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
                  width:(double)width
                  color:(double)color
                  mode:(double)mode
                  halftone:(double)halftone
                  brightness:(double)brightness
                  compress:(double)compress
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
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
                  type:(double)type
                  hri:(double)hri
                  font:(double)font
                  width:(double)width
                  height:(double)height
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
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
                  type:(double)type
                  level:(double)level
                  width:(double)width
                  height:(double)height
                  size:(double)size
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
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
                  timeout: (double)timeout
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
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
                  timeout: (double)timeout
                  type: (double)type
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
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
