#import "EscPosPrinter.h"
#import "ErrorManager.h"
#import <React/RCTConvert.h>

#import "ThePrinterWrapper.h"
#import "ThePrinter.h"

@interface EscPosPrinter() <PrinterDelegate>

@end

@implementation EscPosPrinter

#define DISCONNECT_INTERVAL                  0.5

RCT_EXPORT_MODULE()

- (id)init {
    self = [super init];
    if (self) {
         tasksQueue = [[NSOperationQueue alloc] init];
         tasksQueue.maxConcurrentOperationCount = 1;
        
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
      @"EPOS2_TM_M10": @(EPOS2_TM_M10),
      @"EPOS2_TM_M30": @(EPOS2_TM_M30),
      @"EPOS2_TM_P20": @(EPOS2_TM_P20),
      @"EPOS2_TM_P60": @(EPOS2_TM_P60),
      @"EPOS2_TM_P60II": @(EPOS2_TM_P60II),
      @"EPOS2_TM_P80": @(EPOS2_TM_P80),
      @"EPOS2_TM_T20": @(EPOS2_TM_T20),
      @"EPOS2_TM_T60": @(EPOS2_TM_T60),
      @"EPOS2_TM_T70": @(EPOS2_TM_T70),
      @"EPOS2_TM_T81": @(EPOS2_TM_T81),
      @"EPOS2_TM_T82": @(EPOS2_TM_T82),
      @"EPOS2_TM_T83": @(EPOS2_TM_T83),
      @"EPOS2_TM_T88": @(EPOS2_TM_T88),
      @"EPOS2_TM_T90": @(EPOS2_TM_T90),
      @"EPOS2_TM_T90KP": @(EPOS2_TM_T90KP),
      @"EPOS2_TM_U220": @(EPOS2_TM_U220),
      @"EPOS2_TM_U330": @(EPOS2_TM_U330),
      @"EPOS2_TM_L90": @(EPOS2_TM_L90),
      @"EPOS2_TM_H6000": @(EPOS2_TM_H6000),
      @"EPOS2_TM_T83III": @(EPOS2_TM_T83III),
      @"EPOS2_TM_T100": @(EPOS2_TM_T100),
      @"EPOS2_TM_M30II": @(EPOS2_TM_M30II),
      @"EPOS2_TS_100": @(EPOS2_TS_100),
      @"EPOS2_TM_M50": @(EPOS2_TM_M50),
      @"EPOS2_TM_T88VII": @(EPOS2_TM_T88VII),
      @"EPOS2_TM_L90LFC": @(EPOS2_TM_L90LFC),
      @"EPOS2_TM_L100": @(EPOS2_TM_L100),
      @"COMMAND_ADD_TEXT": @(COMMAND_ADD_TEXT),
      @"COMMAND_ADD_NEW_LINE": @(COMMAND_ADD_NEW_LINE),
      @"COMMAND_ADD_TEXT_STYLE": @(COMMAND_ADD_TEXT_STYLE),
      @"COMMAND_ADD_TEXT_SIZE": @(COMMAND_ADD_TEXT_SIZE),
      @"COMMAND_ADD_TEXT_SMOOTH": @(COMMAND_ADD_TEXT_SMOOTH),
      @"COMMAND_ADD_ALIGN": @(COMMAND_ADD_ALIGN),
      @"COMMAND_ADD_IMAGE_BASE_64": @(COMMAND_ADD_IMAGE_BASE_64),
      @"COMMAND_ADD_IMAGE": @(COMMAND_ADD_IMAGE),
      @"COMMAND_ADD_IMAGE_ASSET": @(COMMAND_ADD_IMAGE_ASSET),
      @"COMMAND_ADD_BARCODE": @(COMMAND_ADD_BARCODE),
      @"COMMAND_ADD_QRCODE": @(COMMAND_ADD_QRCODE),
      @"COMMAND_ADD_CUT": @(COMMAND_ADD_CUT),
      @"COMMAND_ADD_DATA": @(COMMAND_ADD_DATA),
      @"COMMAND_ADD_PULSE": @(COMMAND_ADD_PULSE),
      @"EPOS2_ALIGN_LEFT": @(EPOS2_ALIGN_LEFT),
      @"EPOS2_ALIGN_RIGHT": @(EPOS2_ALIGN_RIGHT),
      @"EPOS2_ALIGN_CENTER": @(EPOS2_ALIGN_CENTER),
      @"EPOS2_TRUE": @(EPOS2_TRUE),
      @"EPOS2_FALSE": @(EPOS2_FALSE),
      @"EPOS2_LANG_EN": @(EPOS2_LANG_EN),
      @"EPOS2_LANG_JA": @(EPOS2_LANG_JA),
      @"EPOS2_LANG_ZH_CN": @(EPOS2_LANG_ZH_CN),
      @"EPOS2_LANG_ZH_TW": @(EPOS2_LANG_ZH_TW),
      @"EPOS2_LANG_KO": @(EPOS2_LANG_KO),
      @"EPOS2_LANG_TH": @(EPOS2_LANG_TH),
      @"EPOS2_LANG_VI": @(EPOS2_LANG_VI),
      @"EPOS2_LANG_MULTI": @(EPOS2_LANG_MULTI),
      @"EPOS2_BARCODE_UPC_A": @(EPOS2_BARCODE_UPC_A),
      @"EPOS2_BARCODE_UPC_E": @(EPOS2_BARCODE_UPC_E),
      @"EPOS2_BARCODE_EAN13": @(EPOS2_BARCODE_EAN13),
      @"EPOS2_BARCODE_JAN13": @(EPOS2_BARCODE_JAN13),
      @"EPOS2_BARCODE_EAN8": @(EPOS2_BARCODE_EAN8),
      @"EPOS2_BARCODE_JAN8": @(EPOS2_BARCODE_JAN8),
      @"EPOS2_BARCODE_CODE39": @(EPOS2_BARCODE_CODE39),
      @"EPOS2_BARCODE_ITF": @(EPOS2_BARCODE_ITF),
      @"EPOS2_BARCODE_CODABAR": @(EPOS2_BARCODE_CODABAR),
      @"EPOS2_BARCODE_CODE93": @(EPOS2_BARCODE_CODE93),
      @"EPOS2_BARCODE_CODE128": @(EPOS2_BARCODE_CODE128),
      @"EPOS2_BARCODE_GS1_128": @(EPOS2_BARCODE_GS1_128),
      @"EPOS2_BARCODE_GS1_DATABAR_OMNIDIRECTIONAL": @(EPOS2_BARCODE_GS1_DATABAR_OMNIDIRECTIONAL),
      @"EPOS2_BARCODE_GS1_DATABAR_TRUNCATED": @(EPOS2_BARCODE_GS1_DATABAR_TRUNCATED),
      @"EPOS2_BARCODE_GS1_DATABAR_LIMITED": @(EPOS2_BARCODE_GS1_DATABAR_LIMITED),
      @"EPOS2_BARCODE_GS1_DATABAR_EXPANDED": @(EPOS2_BARCODE_GS1_DATABAR_EXPANDED),
      @"EPOS2_BARCODE_CODE128_AUTO": @(EPOS2_BARCODE_CODE128_AUTO),
      @"EPOS2_HRI_NONE": @(EPOS2_HRI_NONE),
      @"EPOS2_HRI_ABOVE": @(EPOS2_HRI_ABOVE),
      @"EPOS2_HRI_BELOW": @(EPOS2_HRI_BELOW),
      @"EPOS2_HRI_BOTH": @(EPOS2_HRI_BOTH),
      @"EPOS2_LEVEL_L": @(EPOS2_LEVEL_L),
      @"EPOS2_LEVEL_M": @(EPOS2_LEVEL_M),
      @"EPOS2_LEVEL_Q": @(EPOS2_LEVEL_Q),
      @"EPOS2_LEVEL_H": @(EPOS2_LEVEL_H),
      @"EPOS2_SYMBOL_QRCODE_MODEL_1": @(EPOS2_SYMBOL_QRCODE_MODEL_1),
      @"EPOS2_SYMBOL_QRCODE_MODEL_2": @(EPOS2_SYMBOL_QRCODE_MODEL_2),

       // Print image settings
      @"EPOS2_COLOR_1": @(EPOS2_COLOR_1),
      @"EPOS2_COLOR_2": @(EPOS2_COLOR_2),
      @"EPOS2_COLOR_3": @(EPOS2_COLOR_3),
      @"EPOS2_COLOR_4": @(EPOS2_COLOR_4),

      @"EPOS2_MODE_MONO": @(EPOS2_MODE_MONO),
      @"EPOS2_MODE_GRAY16": @(EPOS2_MODE_GRAY16),
      @"EPOS2_MODE_MONO_HIGH_DENSITY": @(EPOS2_MODE_MONO_HIGH_DENSITY),

      @"EPOS2_HALFTONE_DITHER": @(EPOS2_HALFTONE_DITHER),
      @"EPOS2_HALFTONE_ERROR_DIFFUSION": @(EPOS2_HALFTONE_ERROR_DIFFUSION),
      @"EPOS2_HALFTONE_THRESHOLD": @(EPOS2_HALFTONE_THRESHOLD),

      // Add pulse settings
      @"EPOS2_DRAWER_2PIN": @(EPOS2_DRAWER_2PIN),
      @"EPOS2_DRAWER_5PIN": @(EPOS2_DRAWER_5PIN),
   };
}

enum PrintingCommands : int {
    COMMAND_ADD_TEXT = 0,
    COMMAND_ADD_NEW_LINE,
    COMMAND_ADD_TEXT_STYLE,
    COMMAND_ADD_TEXT_SIZE,
    COMMAND_ADD_ALIGN,
    COMMAND_ADD_IMAGE_BASE_64,
    COMMAND_ADD_IMAGE_ASSET,
    COMMAND_ADD_CUT,
    COMMAND_ADD_DATA,
    COMMAND_ADD_IMAGE,
    COMMAND_ADD_TEXT_SMOOTH,
    COMMAND_ADD_BARCODE,
    COMMAND_ADD_QRCODE,
    COMMAND_ADD_PULSE
};

+ (BOOL)requiresMainQueueSetup
{
  return YES;
}

RCT_EXPORT_METHOD(init:(NSString *)target
                  series:(int)series
                  lang:(int)lang
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)
{
    [self initializeObject: target series:series lang:lang onSuccess:^(NSString *result) {
        resolve(result);
    } onError:^(NSString *error) {
       reject(@"event_failure",error, nil);

    }];
}

RCT_EXPORT_METHOD(getPaperWidth: (NSString *)target
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)
{
  [tasksQueue addOperationWithBlock: ^{
      [self getPrinterSettings:EPOS2_PRINTER_SETTING_PAPERWIDTH objid:target  onSuccess:^(NSString *result) {
            resolve(result);
        } onError:^(NSString *error) {
            reject(@"event_failure",error, nil);
    }];
  }];
}


RCT_EXPORT_METHOD(pairingBluetoothPrinter:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)
{
    [self pairingBluetoothPrinter:^(NSString *result) {
            resolve(result);
        } onError:^(NSString *error) {
            reject(@"event_failure",error, nil);
    }];
}

RCT_EXPORT_METHOD(disconnect: (nonnull NSString*) target)
{
    [self disconnectPrinter: target];
}

RCT_EXPORT_METHOD(startMonitorPrinter:(int) interval
                  withResolver: (RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)
{

//    [self startMonitorPrinter:interval onSuccess:^(NSString *result) {
//            resolve(result);
//        } onError:^(NSString *error) {
//            reject(@"event_failure",error, nil);
//    }];
}

RCT_EXPORT_METHOD(stopMonitorPrinter:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)
{
//    [self stopMonitorPrinter:^(NSString *result) {
//            resolve(result);
//        } onError:^(NSString *error) {
//            reject(@"event_failure",error, nil);
//    }];
}


RCT_EXPORT_METHOD(printBuffer: (NSArray *)printBuffer
                  params:(NSDictionary *)params
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)
{
    [tasksQueue addOperationWithBlock: ^{
        [self printFromBuffer:printBuffer params:params onSuccess:^(NSString *result) {
                resolve(result);
            } onError:^(NSString *error) {
                reject(@"event_failure",error, nil);
        }];
    }];
}



- (void) onPtrReceive:(NSString* _Nonnull)objectid data:(NSDictionary* _Nonnull)data
{
    NSString *result = [data[@"ResultCode"] stringValue];
    int code = [data[@"ResultRawCode"] integerValue];
    
    if (code == EPOS2_CODE_SUCCESS) {
      NSDictionary *msg = data[@"ResultStatus"];
      [self sendEventWithName:@"onPrintSuccess" body: msg];
    }
    else {
      [self sendEventWithName:@"onPrintFailure" body: result];
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self disconnectPrinter: objectid];
    });

}


- (void) onGetPrinterSetting:(NSString* _Nonnull)objectid code:(int)code type:(int)type value:(int)value
{
   
//    NSString *result = [ErrorManager getEposResultText: code];
//
//   if(code == EPOS2_CODE_SUCCESS) {
//     if(type == EPOS2_PRINTER_SETTING_PAPERWIDTH) {
//        int paperWidth = [ErrorManager getEposGetWidthResult: value];
//        [self sendEventWithName:@"onGetPaperWidthSuccess" body: @(paperWidth)];
//     }
//   } else {
//     if(type == EPOS2_PRINTER_SETTING_PAPERWIDTH) {
//        [self sendEventWithName:@"onGetPaperWidthFailure" body: result];
//     }
//   }
//
//   [self performSelectorInBackground:@selector(disconnectPrinter) withObject:nil];

}


// Methods

- (int)printData:(NSDictionary *)params
{
    
    @synchronized (self) {
        NSString* objId = [params[@"printerId"] stringValue];
        int result = [self connectPrinter: objId];
        
        if (result != EPOS2_SUCCESS) {
            return result;
        }
        
        int timeout = (int)[params[@"timeout"] integerValue] ?: EPOS2_PARAM_DEFAULT;
        Epos2Printer* printer = [[objManager_ getObject: objId] getEpos2Printer];
        
        result = [printer sendData:timeout];
        if (result != EPOS2_SUCCESS) {
            [printer clearCommandBuffer];
            [printer disconnect];
            return result;
        }
        
        return result;
    }
}


- (void)initializeObject: (NSString *)target
                          series:(int)series
                          lang:(int)lang
                          onSuccess: (void(^)(NSString *))onSuccess
                          onError: (void(^)(NSString *))onError
{
    @synchronized (self) {
        ThePrinter* thePrinter = [objManager_ getObject:target];
        
        if (thePrinter == nil) {
            thePrinter = [[ThePrinter alloc] initWith:target series:series lang:lang delegate:self];
            [objManager_ add:thePrinter];
        } else {
            NSLog(@"This printer is already initialized");
        }
        Epos2Printer* printer = [thePrinter getEpos2Printer];
       
        if (printer == nil) {
            NSString *errorString = [ErrorManager getEposErrorText: EPOS2_ERR_PARAM];
            onError(errorString);
            return;
        }

        [printer addTextLang:lang];
        NSString *successString = [ErrorManager getEposErrorText: EPOS2_SUCCESS];
        onSuccess(successString);
    }
}


- (int)connectPrinter: (nonnull NSString*)objid {
    ThePrinter* thePrinter = nil;
    @synchronized (self) {
        thePrinter = [objManager_ getObject:objid];
        if (thePrinter == nil) {
            return EPOS2_ERR_PARAM;
        } else {
            int connectResult = [thePrinter connect:EPOS2_PARAM_DEFAULT startMonitor:false];
            if (connectResult != EPOS2_SUCCESS) {
                return connectResult;
            }
            [thePrinter beginTransaction];
            return connectResult;
            
        }
    }
}

- (void)disconnectPrinter: (nonnull NSString*)objid
{
    
    ThePrinter* thePrinter = nil;
    int result = EPOS2_SUCCESS;
    
    @synchronized (self) {
        thePrinter = [objManager_ getObject:objid];
        if (thePrinter == nil) {
            return;
        } else {
            [thePrinter disconnect];            
        }
    }
}

- (void)getPrinterSettings:(int)type
                           objid: (nonnull NSString*)objid
                           onSuccess: (void(^)(NSString *))onSuccess
                           onError: (void(^)(NSString *))onError {
    @synchronized (self) {
        int result = [self connectPrinter: objid];
        
        if (result != EPOS2_SUCCESS) {
            NSString *errorString = [ErrorManager getEposErrorText: result];
            onError(errorString);
            return;
        }
        
        ThePrinter *thePrinter = [objManager_ getObject:objid];
        
        result = [thePrinter getPrinterSettings:EPOS2_PARAM_DEFAULT type:type];
        
        if (result != EPOS2_SUCCESS) {
            NSString *errorString = [ErrorManager getEposErrorText: result];
            onError(errorString);
            [self disconnectPrinter: objid];
            return;
        }
        
        NSString *successString = [ErrorManager getEposErrorText: EPOS2_SUCCESS];
        onSuccess(successString);
    }
}

- (void)pairingBluetoothPrinter:(void(^)(NSString *))onSuccess
                               onError: (void(^)(NSString *))onError
{
    Epos2BluetoothConnection *pairingPrinter = [[Epos2BluetoothConnection alloc] init];
    NSMutableString *address = [[NSMutableString alloc] init];
    int result = [pairingPrinter connectDevice: address];

    if(result == EPOS2_BT_SUCCESS || result == EPOS2_BT_ERR_ALREADY_CONNECT) {
        NSString *successString = [ErrorManager getEposBTResultText: EPOS2_BT_SUCCESS];
        onSuccess(successString);
    } else {
        NSString *errorString = [ErrorManager getEposBTResultText: EPOS2_BT_SUCCESS];
        onError(errorString);
    }
}

- (void)onSetPrinterSetting:(int)code {
    // nothing to do
}

//- (void)performMonitoring: (NSTimer*)timer {
//    int interval = [timer.userInfo intValue];
//
//    __block Epos2PrinterStatusInfo *info;
//    __block int result = EPOS2_SUCCESS;
//
//    if(self->isMonitoring_) {
//        [self->tasksQueue addOperationWithBlock: ^{
//            result = [self connectPrinter];
//
//            if (result != EPOS2_SUCCESS) {
//                if(result != EPOS2_ERR_ILLEGAL && result != EPOS2_ERR_PROCESSING) {
//                    NSDictionary *msg = [ErrorManager getOfflineStatusMessage];
//                    @try {
//                      [self sendEventWithName:@"onMonitorStatusUpdate" body: msg];
//                    } @catch(NSException *e) {
//                    }
//
//                }
//            } else {
//                info = [self->printer getStatus];
//
//                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                    NSDictionary *msg = [ErrorManager makeStatusMessage: info];
//                    if(msg != nil){
//                      @try {
//                        [self sendEventWithName:@"onMonitorStatusUpdate" body: msg];
//                      } @catch(NSException *e) {
//                      }
//                    }
//                }];
//                [self disconnectPrinter];
//            }
//
//               [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                 [NSTimer scheduledTimerWithTimeInterval: (int)interval target:self selector: @selector(performMonitoring:) userInfo: @(interval) repeats:NO];
//               }];
//
//        }];
//    }
//}

//- (void)startMonitorPrinter:(int)interval onSuccess:(void(^)(NSString *))onSuccess
//                               onError: (void(^)(NSString *))onError {
//
//    if(isMonitoring_) {
//        onError(@"Already monitoring!");
//        return;
//    }
//
//    if (printer == nil) {
//        NSString *errorString = [ErrorManager getEposErrorText: EPOS2_ERR_PARAM];
//        onError(errorString);
//        return;
//    }
//
//    isMonitoring_ = true;
//
//    NSTimer* timer = [NSTimer timerWithTimeInterval: 0.0 target:self selector: @selector(performMonitoring:) userInfo: @(interval) repeats:NO];
//    [timer fire];
//
//    NSString *successString = [ErrorManager getEposErrorText: EPOS2_SUCCESS];
//    onSuccess(successString);
//}

//-(void)stopMonitorPrinter:(void(^)(NSString *))onSuccess
//                  onError: (void(^)(NSString *))onError
//{
//    if(!isMonitoring_){
//        onError(@"Printer is not monitorring!");
//        return;
//    }
//    [tasksQueue waitUntilAllOperationsAreFinished];
//    isMonitoring_= false;
//
//    NSString *successString = [ErrorManager getEposErrorText: EPOS2_SUCCESS];
//    onSuccess(successString);
//}


- (UIImage *)scaleImage:(UIImage *)image scaledToFillSize:(CGSize)size
{
    CGFloat scale = MAX(size.width/image.size.width, size.height/image.size.height);
    CGFloat width = image.size.width * scale;
    CGFloat height = image.size.height * scale;
    CGRect imageRect = CGRectMake((size.width - width)/2.0f,
                                  (size.height - height)/2.0f,
                                  width,
                                  height);

    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [image drawInRect:imageRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (int)printImage:(UIImage *)imageData
                  width:(NSInteger)width
                  color:(int)color
                  mode:(int)mode
                  halftone:(int)halftone
                  brightness:(CGFloat)brightness
                  objid: (nonnull NSString*)objid

{
    @synchronized (self) {
        Epos2Printer* printer = [[objManager_ getObject:objid] getEpos2Printer];
        int result = EPOS2_SUCCESS;
        
        NSInteger imgHeight = imageData.size.height;
        NSInteger imagWidth = imageData.size.width;
        
        CGSize size = CGSizeMake(width, imgHeight*width/imagWidth);
        UIImage *scaled = [self scaleImage:imageData scaledToFillSize:size];
        
        result = [printer addImage:scaled x:0 y:0
                             width: size.width
                            height: size.height
                             color: color
                              mode: mode
                          halftone: halftone
                        brightness: brightness
                          compress:EPOS2_COMPRESS_AUTO];
        
        return result;
    }
}

- (enum Epos2ErrorStatus)handleCommand: (enum PrintingCommands)command params:(NSArray*)params objid:(nonnull NSString*)objid {
    @synchronized (self) {
        int result = EPOS2_SUCCESS;
        NSString* text = @"";
        NSError *error = nil;
        Epos2Printer* printer = [[objManager_ getObject:objid] getEpos2Printer ];
        switch(command) {
            case COMMAND_ADD_TEXT  :
                text = params[0];
                result = [printer addText:text];
                break;
            case COMMAND_ADD_NEW_LINE :
                result = [printer addFeedLine:[params[0] intValue]];
                break;
            case COMMAND_ADD_PULSE :
                result = [printer addPulse:[params[0] intValue] time:EPOS2_PARAM_DEFAULT];
                break;
            case COMMAND_ADD_TEXT_STYLE :
                result = [printer addTextStyle:EPOS2_FALSE ul:[params[0] intValue] em:[params[1] intValue] color:EPOS2_COLOR_1];
                break;
            case COMMAND_ADD_TEXT_SIZE :
                result = [printer addTextSize:[params[0] intValue] height:[params[1] intValue]];
                break;
            case COMMAND_ADD_ALIGN:
                result = [printer addTextAlign:[params[0] intValue]];
                break;
            case COMMAND_ADD_IMAGE_ASSET : {
                UIImage *imageData = [UIImage imageNamed: params[0]];
                
                
                NSInteger imgHeight = imageData.size.height;
                NSInteger imagWidth = imageData.size.width;
                
                NSInteger width = [params[1] intValue];
                
                CGSize size = CGSizeMake(width, imgHeight*width/imagWidth);
                UIImage *scaled = [self scaleImage:imageData scaledToFillSize:size];
                
                
                result = [printer addImage:scaled x:0 y:0
                                     width: size.width
                                    height: size.height
                                     color:EPOS2_COLOR_1
                                      mode:EPOS2_MODE_MONO
                                  halftone:EPOS2_HALFTONE_DITHER
                                brightness:EPOS2_PARAM_DEFAULT
                                  compress:EPOS2_COMPRESS_AUTO];
                break;
            }
            case COMMAND_ADD_IMAGE_BASE_64 : {
                NSString *urlString = params[0];
                NSURL *imageURL = [NSURL URLWithString:urlString];
                NSData *jpgData = [NSData dataWithContentsOfURL:imageURL options:NSDataReadingUncached error:&error];
                
                UIImage *imageData = [[UIImage alloc] initWithData:jpgData];
                
                NSInteger imgHeight = imageData.size.height;
                NSInteger imagWidth = imageData.size.width;
                
                NSInteger width = [params[1] intValue];
                
                CGSize size = CGSizeMake(width, imgHeight*width/imagWidth);
                UIImage *scaled = [self scaleImage:imageData scaledToFillSize:size];
                
                
                result = [printer addImage:scaled x:0 y:0
                                     width: size.width
                                    height: size.height
                                     color:EPOS2_COLOR_1
                                      mode:EPOS2_MODE_MONO
                                  halftone:EPOS2_HALFTONE_DITHER
                                brightness:EPOS2_PARAM_DEFAULT
                                  compress:EPOS2_COMPRESS_AUTO];
                break;
            }
            case COMMAND_ADD_IMAGE : {
                NSDictionary *imageObj = params[0];
                NSString * urlString = imageObj[@"uri"];
                UIImage * imageData;
                if([urlString hasPrefix: @"http"] || [urlString hasPrefix: @"https"]) {
                    NSURL *url = [NSURL URLWithString: urlString];
                    NSData *data = [NSData dataWithContentsOfURL:url];
                    imageData = [[UIImage alloc] initWithData:data];
                } else {
                    imageData = [RCTConvert UIImage:imageObj];
                }
                
                result = [self printImage:imageData
                                    width: [params[1] intValue]
                                    color: [params[2] intValue]
                                     mode: [params[3] intValue]
                                 halftone: [params[4] intValue]
                               brightness: [params[5] floatValue]
                                    objid: objid
                ];
                break;
            }
            case COMMAND_ADD_CUT :
                result = [printer addCut:EPOS2_CUT_FEED];
                break;
            case COMMAND_ADD_DATA: {
                NSData *data = [[NSData alloc] initWithBase64EncodedString: params[0] options:0];
                
                result = [printer addCommand:data];
                break;
            }
            case COMMAND_ADD_TEXT_SMOOTH :
                result = [printer addTextSmooth:[params[0] intValue]];
                break;
            case COMMAND_ADD_BARCODE :
                result = [printer addBarcode:params[0] type:[params[1] intValue] hri:[params[2] intValue] font:EPOS2_FONT_A width:[params[3] intValue] height:[params[4] intValue]];
                break;
            case COMMAND_ADD_QRCODE :
                result = [printer addSymbol:params[0] type:[params[1] intValue] level:[params[2] intValue] width:[params[3] intValue] height:[params[3] intValue] size:[params[3] intValue]];
                break;
        }
        
        return result;
    }
}

- (void)printFromBuffer:(NSArray*)buffer params:(NSDictionary *)params onSuccess: (void(^)(NSString *))onSuccess onError: (void(^)(NSString *))onError
{
    @synchronized (self) {
        int result = EPOS2_SUCCESS;
        NSString* objid = [params[@"printerId"] stringValue];
        
        NSUInteger length = [buffer count];
        for (int j = 0; j < length; j++ ) {
            result = [self handleCommand:[buffer[j][0] intValue] params:buffer[j][1] objid:objid];
            
            if (result != EPOS2_SUCCESS) {
                NSString *errorString = [ErrorManager getEposErrorText: result];
                onError(errorString);
                return;
            }
        }
        
        result = [self printData:params];
        if (result != EPOS2_SUCCESS) {
            NSString *errorString = [ErrorManager getEposErrorText: result];
            onError(errorString);
            return;
        }
        
        NSString *successString = [ErrorManager getEposErrorText: EPOS2_SUCCESS];
        onSuccess(successString);
    }
}


@end
