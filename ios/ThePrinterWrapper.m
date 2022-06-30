//
//  ThePrinterWrapper.m
//
//

#import <Foundation/Foundation.h>
#import "ThePrinterWrapper.h"
#import "ThePrinter.h"
#import "NSlogHelper.h"
#import <objc/runtime.h>
#import <React/RCTConvert.h>
#import "ErrorManager.h"

@interface ThePrinterWrapper() <PrinterDelegate>
- (void) onPrinterStartStatusMonitorResult:(NSString* _Nonnull)objectid hasError:(bool)hasError error:(NSString* _Nullable)error;
- (void) onPrinterStopStatusMonitorResult:(NSString* _Nonnull)objectid hasError:(bool)hasError error:(NSString* _Nullable)error;
- (void) onPrinterFailedCreateObject:(NSString* _Nonnull)printerTarget;
- (void) onPrinterStatusChange:(NSString* _Nonnull)objectid status:(int)status;
- (void) onPtrReceive:(NSString* _Nonnull)objectid data:(NSDictionary* _Nonnull)data;
- (void) onGetPrinterSetting:(NSString* _Nonnull)objectid code:(int)code type:(int)type value:(int)value;
@end

@implementation ThePrinterWrapper

RCT_EXPORT_MODULE()

-(id)init
{
    self = [super init];
    if (self) {
        
        objManager_ = [ThePrinterManager sharedManager];
        [objManager_ removeAll];
        
        // setup memory notification
        memoryNotification_ = [[NSNotificationCenter defaultCenter] addObserverForName:
          UIApplicationDidReceiveMemoryWarningNotification
          object:[UIApplication sharedApplication] queue:nil
          usingBlock:^(NSNotification *notif) {
            [self didReceiveMemoryWarningNotification:notif];
        }];
        
        // setup background notification
        backgroundNotification_ = [[NSNotificationCenter defaultCenter] addObserverForName:
                                   UIApplicationDidEnterBackgroundNotification
          object:[UIApplication sharedApplication] queue:nil
          usingBlock:^(NSNotification *notif) {
            [self didEnterBackgroundNotification:notif];
        }];
        
        
    }
    return self;
}

- (NSArray<NSString *> *)supportedEvents {
    return @[@"onPrintSuccess", @"onPrintFailure", @"onGetPaperWidthSuccess", @"onGetPaperWidthFailure", @"onMonitorStatusUpdate"];
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


- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:memoryNotification_];
    [[NSNotificationCenter defaultCenter] removeObserver:backgroundNotification_];

    [objManager_ removeAll];
    objManager_ = nil;
    memoryNotification_ = nil;
    backgroundNotification_ = nil;
}


RCT_EXPORT_METHOD(init:(NSString *)target
                  series:(int)series
                  lang:(int)lang
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)
{
    [self initializeObject:target series:series lang:lang onSuccess:^(NSString *result) {
        resolve(result);
    } onError:^(NSString *error) {
       reject(@"event_failure",error, nil);
    }];
}

// please call from native react
-(void) initializeObject:(NSString* _Nonnull)printerTarget 
                                        series:(int)series 
                                        lang:(int)lang 
                                        onSuccess: (void(^)(NSString *))onSuccess
                                        onError: (void(^)(NSString *))onError
{
    @synchronized (self) {
        ThePrinter* thePrinter = [objManager_ getObject:printerTarget];
        
        if (thePrinter == nil) {
            ThePrinter* newPrinter = [[ThePrinter alloc] initWith:printerTarget series:series lang:lang delegate:self];
            [objManager_ add:newPrinter];
        } else {
            NSLog(@"This printer is already initialized");
        }
                
        [self connectPrinter:printerTarget onSuccess:^(NSString *result) {
            onSuccess(result);
        } onError:^(NSString *error) {
            onError(error);
        }];
    }
}

RCT_EXPORT_METHOD(connect:(NSString *)target
                withResolver:(RCTPromiseResolveBlock)resolve
                withRejecter:(RCTPromiseRejectBlock)reject)
{
    [self connectPrinter:target onSuccess:^(NSString *result) {
        resolve(result);
    } onError:^(NSString *error) {
       reject(@"event_failure",error, nil);
    }];
}
// please call from native react
-(void) connectPrinter:(nonnull NSString*)objid
                                        onSuccess: (void(^)(NSString *))onSuccess
                                        onError: (void(^)(NSString *))onError
{
    ThePrinter* thePrinter = nil;
    @synchronized (self) {
        thePrinter = [objManager_ getObject:objid];
        if (thePrinter == nil) {
            NSLog(@"Error fail to get object, The printer is not initialised");
            onError(@"The printer is not initialised");
        } else {
            [thePrinter setBusy:PRINTER_CONNECTING];
             NSLog(@"connecting to printer %@", objid);
            const connectResult = [thePrinter connect:EPOS2_PARAM_DEFAULT startMonitor:true];
            if (connectResult == EPOS2_SUCCESS) {
                onSuccess([NSString stringWithFormat:@"%d", connectResult]);
            } else {
                onError([NSString stringWithFormat:@"%d", connectResult]);
            }
            
        }
    }
   
    
}

// please call from native react
// please make sure that you call after you have finished connecting/printing
-(int) disconnectPrinter:(nonnull NSString*)objid
{
    ThePrinter* thePrinter = nil;
    
    @synchronized (self) {
        
        thePrinter = [objManager_ getObject:objid];
        if (thePrinter == nil) {
            NSLog(@"Error  Fail to get object.");
            return EPOS2_ERR_MEMORY;
        }
        if ([thePrinter isPrinterBusy]) {
            return EPOS2_ERR_DEVICE_BUSY;
        }
        
        [thePrinter setBusy:PRINTER_DISCONNECTING];

    }
    
    return [thePrinter disconnect];
}

// please call from native react
// please make sure that you call after you have finished connecting/printing
-(int) deallocPrinter:(nonnull NSString*)objid
{

    ThePrinter* thePrinter = nil;
    
    @synchronized (self) {
        
        thePrinter = [objManager_ getObject:objid];
        
        if (thePrinter == nil) {
            return EPOS2_ERR_MEMORY;
        }
        
        if ([thePrinter isPrinterBusy]) {
            return EPOS2_ERR_DEVICE_BUSY;
        }
        
        [thePrinter setBusy:PRINTER_REMOVING];
        [thePrinter removeDelegates];
        thePrinter.Delegate = nil;
        [objManager_ remove:objid];

    }

    [thePrinter shutdown:true];

    [NSThread sleepForTimeInterval:1.0]; // give time for any callbacks to finish
    NSLog(@"release thePrinter deallocPrinter %@", objid);
    thePrinter = nil;
    
    return EPOS2_SUCCESS;
    
}

-(bool) isPrinterBusy:(nonnull NSString*)objid
{
    @synchronized (self) {
        
        NSLog(@"getPrinterTarget %@", objid);
        
        ThePrinter* thePrinter = [objManager_ getObject:objid];
        
        if (thePrinter == nil) {
            return false;
        }
        
        return [thePrinter isPrinterBusy];
    }
}

-(NSString*  _Nonnull) getPrinterTarget:(nonnull NSString*)objid
{
    ThePrinter* thePrinter = [objManager_ getObject:objid];
    
    if (thePrinter == nil) {
        return @"";
    }
    
    return [thePrinter getPrinterTarget];
}

-(void) shutdown:(nonnull NSString*)objid {
    
    @synchronized (self) {
        ThePrinter* thePrinter = [objManager_ getObject:objid];
        
        if (thePrinter == nil) {
            NSLog(@"Error  Fail to get object.");
            return;
        }
        
        return [thePrinter shutdown:true];
    }
}

-(void) setBusy:(nonnull NSString*)objectid state:(ThePrinterState)state
{
    @synchronized (self) {
        ThePrinter* thePrinter = [objManager_ getObject:objectid];
        
        if (thePrinter == nil) {
            NSLog(@"Error  Fail to get object.");
        }
        
        [thePrinter setBusy:state];
    }
}

#pragma mark - Epos2Printer objc API -- please call from native react
//  Please refer to the ePOS_SDK_iOS pdf manual
// you should call theses api from native react
// not all API's have been added please add more as you use them
// never free the Epos2Printer pointer that you get from getEpos2Printer as it will be freed when deallocPrinter is called

-(int) beginTransaction:(nonnull NSString*)objectid
{
    @synchronized (self) {
        ThePrinter* thePrinter = [objManager_ getObject:objectid];
        
        if (thePrinter == nil) {
            NSLog(@"Error  Fail to get object.");
            return EPOS2_ERR_MEMORY;
        }
        return [thePrinter beginTransaction];
    }
}

-(int) endTransaction:(nonnull NSString*)objectid
{
    @synchronized (self) {
        ThePrinter* thePrinter = [objManager_ getObject:objectid];
        
        if (thePrinter == nil) {
            NSLog(@"Error  Fail to get object.");
            return EPOS2_ERR_MEMORY;
        }
        return [thePrinter endTransaction];
    }
}

-(int) clearCommandBuffer:(nonnull NSString*)objid {
    
    @synchronized (self) {
        ThePrinter* thePrinter = [objManager_ getObject:objid];
        
        if (thePrinter == nil) {
            NSLog(@"Error  Fail to get object.");
            return EPOS2_ERR_MEMORY;
        }
        
        return [[thePrinter getEpos2Printer] clearCommandBuffer];
    }

    
}

-(int) getPrinterSettings:(nonnull NSString*)objid timeout:(long)timeout type:(int)type
{
    @synchronized (self) {
        
        ThePrinter* thePrinter = [objManager_ getObject:objid];
        
        if (thePrinter == nil) {
            NSLog(@"Error  Fail to get object.");
            return EPOS2_ERR_MEMORY;
        }
        
        return [thePrinter getPrinterSettings:timeout type:type];
    }
}

-(Epos2PrinterStatusInfo* _Nullable) getStatus:(nonnull NSString*)objid
{
    ThePrinter* thePrinter = nil;
    
    @synchronized (self) {
        thePrinter = [objManager_ getObject:objid];
        
        if (thePrinter == nil) {
            NSLog(@"Error  Fail to get object.");
            return [[Epos2PrinterStatusInfo alloc] init];
        }
    }
    
    return [[thePrinter getEpos2Printer] getStatus];
}

-(int) addText:(nonnull NSString*)objid text:(NSString* _Nonnull)text {
    
    @synchronized (self) {
        
        ThePrinter* thePrinter = [objManager_ getObject:objid];
        
        if (thePrinter == nil) {
            NSLog(@"Error  Fail to get object.");
            return EPOS2_ERR_MEMORY;
        }
        
        return [[thePrinter getEpos2Printer] addText:text];
    }
    
}

-(int) addFeedLine:(nonnull NSString*)objid lines:(long)lines {
    
    @synchronized (self) {
        
        ThePrinter* thePrinter = [objManager_ getObject:objid];
        
        if (thePrinter == nil) {
            NSLog(@"Error  Fail to get object.");
            return EPOS2_ERR_MEMORY;
        }
        
        return [[thePrinter getEpos2Printer] addFeedLine:lines];
    }
    
}

-(int) addPulse:(nonnull NSString*)objid pulse:(int)pulse time:(int)time {

    @synchronized (self) {
        ThePrinter* thePrinter = [objManager_ getObject:objid];
        
        if (thePrinter == nil) {
            NSLog(@"Error  Fail to get object.");
            return EPOS2_ERR_MEMORY;
        }
        
        return [[thePrinter getEpos2Printer] addPulse:pulse time:time];
    }
}

-(int) addTextStyle:(nonnull NSString*)objid style:(int)style ul:(int)ul em:(int)em color:(int)color {
    ThePrinter* thePrinter = [objManager_ getObject:objid];
    
    @synchronized (self) {
        
        if (thePrinter == nil) {
            NSLog(@"Error  Fail to get object.");
            return EPOS2_ERR_MEMORY;
        }
        
        return [[thePrinter getEpos2Printer] addTextStyle:style ul:ul em:em color:color];
    }
}

-(int) addTextSize:(nonnull NSString*)objid width:(long)width height:(long)height {
    
    @synchronized (self) {
        ThePrinter* thePrinter = [objManager_ getObject:objid];
        
        if (thePrinter == nil) {
            NSLog(@"Error  Fail to get object.");
            return EPOS2_ERR_MEMORY;
        }
        
        return [[thePrinter getEpos2Printer] addTextSize:width height:height];
    }
    
}

-(int) addTextAlign:(nonnull NSString*)objid align:(int)align {
    
    @synchronized (self) {

        ThePrinter* thePrinter = [objManager_ getObject:objid];
        
        if (thePrinter == nil) {
            NSLog(@"Error  Fail to get object.");
            return EPOS2_ERR_MEMORY;
        }
        
        return [[thePrinter getEpos2Printer] addTextAlign:align];
    }
    
}

-(int) addImage:(nonnull NSString*)objid image:(UIImage* _Nonnull)image x:(long)x y:(long)y width:(long)width height:(long)height color:(int)color mode:(int)mode halftone:(int)halftone brightness:(double)brightness compress:(int)compress {
    
    @synchronized (self) {
        
        ThePrinter* thePrinter = [objManager_ getObject:objid];
        
        if (thePrinter == nil) {
            NSLog(@"Error  Fail to get object.");
            return EPOS2_ERR_MEMORY;
        }
        
        return [[thePrinter getEpos2Printer] addImage:image x:x y:y width:width height:height color:color mode:mode halftone:halftone brightness:brightness compress:compress];
    }
    
}

-(int) addCommand:(nonnull NSString*)objid data:(NSData* _Nonnull)data
{
    @synchronized (self) {
        
        ThePrinter* thePrinter = [objManager_ getObject:objid];
        
        if (thePrinter == nil) {
            NSLog(@"Error  Fail to get object.");
            return EPOS2_ERR_MEMORY;
        }
        
        return [[thePrinter getEpos2Printer] addCommand:data];
    }
}

-(int) addCut:(nonnull NSString*)objid feed:(int)feed
{
    @synchronized (self) {
        ThePrinter* thePrinter = [objManager_ getObject:objid];
        
        if (thePrinter == nil) {
            NSLog(@"Error  Fail to get object.");
            return EPOS2_ERR_MEMORY;
        }
        
        return [[thePrinter getEpos2Printer] addCut:feed];
    }
}

-(int) addTextSmooth:(nonnull NSString*)objid smooth:(int)smooth
{
    @synchronized (self) {
        ThePrinter* thePrinter = [objManager_ getObject:objid];
        
        if (thePrinter == nil) {
            NSLog(@"Error  Fail to get object.");
            return EPOS2_ERR_MEMORY;
        }
        
        return [[thePrinter getEpos2Printer] addTextSmooth:smooth];
    }
}

-(int) addBarcode:(nonnull NSString*)objid code:(NSString* _Nonnull)code type:(int)type hri:(int)hri font:(int)font width:(long)width height:(long)height
{
    @synchronized (self) {
        
        ThePrinter* thePrinter = [objManager_ getObject:objid];
        
        if (thePrinter == nil) {
            NSLog(@"Error  Fail to get object.");
            return EPOS2_ERR_MEMORY;
        }
        
        return [[thePrinter getEpos2Printer] addBarcode:code type:type hri:hri font:font width:width height:height];
    }
}

-(int) addSymbol:(nonnull NSString*)objid symbol:(NSString* _Nonnull)symbol type:(int)type level:(int)level width:(long)width height:(long)height size:(long)size
{
    
    @synchronized (self) {

        ThePrinter* thePrinter = [objManager_ getObject:objid];
        if (thePrinter == nil) {
            NSLog(@"Error  Fail to get object.");
            return EPOS2_ERR_MEMORY;
        }
        
        return [[thePrinter getEpos2Printer] addSymbol:symbol type:type level:level width:width height:width size:size];
    }
}

-(int) sendData:(nonnull NSString*)objid timeout:(long)timeout
{
    
    @synchronized (self) {

        ThePrinter* thePrinter = [objManager_ getObject:objid];
        
        if (thePrinter == nil) {
            NSLog(@"Error  Fail to get object.");
            return EPOS2_ERR_MEMORY;
        }
        [thePrinter setBusy:PRINTER_PRINTING];
        
        return [thePrinter sendData:timeout];
    }
}

#pragma mark - error handling
/**
 Returns void
 Function handleError deals with objects that failed to get created - App demo will show an alert only
 please handle in your app
 @param String objectid the object hash key
 @param String method the method that called function
 @param String error the error message
 @return void
 */
-(void)handleError:(NSString*)error method:(NSString*)method objid:(NSString*)objid
{
    @synchronized (self) {
                
        if ([method hasPrefix:@"onPrinterFailedCreateObject"]) {
            NSLog(@"onPrinterFailedCreateObject");
            if (_Delegate != nil && [self.Delegate respondsToSelector:@selector(onMemoryError:error:)]) {
                dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [self.Delegate onMemoryError:@"NULL" error:error];
                });
            }
            return;
        }
    }
}

/**
 Returns void
 Function handleStatusMonitorResult is used to inform the UI that the Status real time monitor has started/stop success/failed - App demo will only show in cell logger
 please handle in your app
 @param String objectid the object hash key
 @param String method the method that called function
 @param bool hasError if failer has happened will be true
 @param String error the error message
 @return void
 */
-(void) handleStatusMonitorResult:(NSString* _Nonnull)objectid method:(NSString* _Nonnull)method hasError:(bool)hasError error:(NSString* _Nullable)error
{
    
    if ([method hasPrefix:@"onPrinterStartStatusMonitorResult"]) { // Status Monitor Start success/failer
        if (_Delegate != nil && [self.Delegate respondsToSelector:@selector(onPrinterStartStatusMonitorResult:hasError:error:)]) {
            dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ // create new thread inform the UI
                [self.Delegate onPrinterStartStatusMonitorResult:objectid hasError:hasError error:error];
            });
        }
        return;
    }
    
    if ([method hasPrefix:@"onPrinterStopStatusMonitorResult"]) { // Status Monitor Stop success/failer
        if (_Delegate != nil && [self.Delegate respondsToSelector:@selector(onPrinterStopStatusMonitorResult:hasError:error:)]) {
            dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ // create new thread inform UI
                [self.Delegate onPrinterStopStatusMonitorResult:objectid hasError:hasError error:error];
            });
        }
        return;
    }
    
}

#pragma mark - PrinterDelegate callbacks
/**
 Returns void
 Function onPrinterFailedCreateObject informs that failed to create Epos2Printer object.
 @param printerTarget the target set when create was called
 @return void
 */
-(void) onPrinterFailedCreateObject:(NSString* _Nonnull)printerTarget {
    NSLog(@"Error  Fail to create object: %@", printerTarget);
    [self handleError:@"ERR_MEMORY" method:NSStringFromSelector(_cmd) objid:@"NULL"];
}

// Start Status monitor callback
/**
 Returns void
 Function onPrinterStartStatusMonitorResult informs that Start Status monitor has been successfull/failed.
 @param String objectid the object hash key
 @param Bool hasError if the status has failed will be false
 @param String error contains why start failed
 @return void
 */
- (void) onPrinterStartStatusMonitorResult:(NSString* _Nonnull)objectid hasError:(bool)hasError error:(NSString* _Nullable)error
{
    [self handleStatusMonitorResult:objectid method:NSStringFromSelector(_cmd) hasError:hasError error:error];
}

/**
 Returns void
 Function onPrinterStopStatusMonitorResult informs that Stop Status monitor has been successfull/failed.
 @param String objectid the object hash key
 @param Bool hasError if the status has failed will be false
 @param String error contains why stop failed
 @return void
 */
- (void) onPrinterStopStatusMonitorResult:(NSString* _Nonnull)objectid hasError:(bool)hasError error:(NSString* _Nullable)error
{
    [self handleStatusMonitorResult:objectid method:NSStringFromSelector(_cmd) hasError:hasError error:error];
}

/**
 Returns void
 Function onPrinterStatusChange informs the UI that the printer status has changed -- App demo only displays in the Table Cell logger UI.
 @param String objectid the object hash key
 @param Bool hasError if the status has failed will be false
 @param String error contains why stop failed
 @return void
 */
- (void) onPrinterStatusChange:(NSString *)objectid status:(int)status {

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (_Delegate != nil && [self.Delegate respondsToSelector:@selector(onPrinterStatusChange:status:)]) {
            [self.Delegate onPrinterStatusChange:objectid status:status];
        }
        
    });

}

/**
 Returns void
 Function onPtrReceive informs the UI of the status of the print job that was received -- App demo only displays in Cell logger.
 @param String objectid the object hash key
 @param NSDictionary JSON storing the result
 @return void
 */
- (void) onPtrReceive:(NSString* _Nonnull)objectid data:(NSDictionary* _Nonnull)data
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (_Delegate != nil && [self.Delegate respondsToSelector:@selector(onPtrReceive:data:)]) {
            [self.Delegate onPtrReceive:objectid data:data];
        }
    });

}

/**
 Returns void
 Function onGetPrinterSetting informs the UI of the printer settings that where requested -- App demo only displays in Cell logger.
 @param String objectid the object hash key
 @param int code ePOS result
 @param int type ePOS Settings Type -- EPOS2_PRINTER_SETTING_PAPERWIDTH
 @param int value ePOS value -- EPOS2_PRINTER_SETTING_PAPERWIDTH_58_0
 @return void
 */
- (void) onGetPrinterSetting:(NSString* _Nonnull)objectid code:(int)code type:(int)type value:(int)value
{
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (_Delegate != nil && [self.Delegate respondsToSelector:@selector(onGetPrinterSetting:code:type:value:)]) {
            [self.Delegate onGetPrinterSetting:objectid code:code type:type value:value];
        }
    });

}

#pragma mark - didReceiveMemoryWarningNotification memory warning
// please handle any iOS memory issues here
-(void) didReceiveMemoryWarningNotification:(NSNotification*)notification
{
    NSLog(@">>>>>>>>>>>>>>  memory notification: %@  <<<<<<<<<<<", notification);
    if (_Delegate != nil && [self.Delegate respondsToSelector:@selector(onMemoryError:error:)]) {
        dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self.Delegate onMemoryError:@"didReceiveMemoryWarningNotification" error:@"out-of-memory"];
        });
    }
}

#pragma mark - didEnterBackgroundNotification background task
/**
 Returns void
 Function callback didEnterBackgroundNotification
 iOS give us time to handle our connection
 please modify to suite your needs
 App demo tries to diconnect all printers in time.
 */
-(void) didEnterBackgroundNotification:(NSNotification*)notification
{
    @synchronized (self) {
        
        NSLog(@">>>>>>>>>>>>>>  Background notification: %@  <<<<<<<<<<<", notification);
        if (_Delegate != nil && [self.Delegate respondsToSelector:@selector(onDidEnterBackgroundNotification:)]) {
            dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self.Delegate onDidEnterBackgroundNotification:notification];
            });
        }
    }
    
}


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
                  target:(NSString *)target

{
    int result = EPOS2_SUCCESS;

    NSInteger imgHeight = imageData.size.height;
    NSInteger imagWidth = imageData.size.width;

    CGSize size = CGSizeMake(width, imgHeight*width/imagWidth);
    UIImage *scaled = [self scaleImage:imageData scaledToFillSize:size];

    ThePrinter* thePrinter = [objManager_ getObject:target];

    result = [[thePrinter getEpos2Printer] addImage:scaled x:0 y:0
      width: size.width
      height: size.height
      color: color
      mode: mode
      halftone: halftone
      brightness: brightness
      compress:EPOS2_COMPRESS_AUTO];

    return result;
}

- (enum Epos2ErrorStatus)handleCommand: (enum PrintingCommands)command params:(NSArray*)params target:(NSString *)target {
    int result = EPOS2_SUCCESS;
    NSString* text = @"";
    NSError *error = nil;
    ThePrinter* thePrinter = [objManager_ getObject:target];
    switch(command) {
        case COMMAND_ADD_TEXT  :
            text = params[0];
            result = [[thePrinter getEpos2Printer] addText:text];
          break;
        case COMMAND_ADD_NEW_LINE :
            result = [[thePrinter getEpos2Printer] addFeedLine:[params[0] intValue]];
          break;
        case COMMAND_ADD_PULSE :
            result = [[thePrinter getEpos2Printer] addPulse:[params[0] intValue] time:EPOS2_PARAM_DEFAULT];
          break;
        case COMMAND_ADD_TEXT_STYLE :
            result = [[thePrinter getEpos2Printer] addTextStyle:EPOS2_FALSE ul:[params[0] intValue] em:[params[1] intValue] color:EPOS2_COLOR_1];
          break;
        case COMMAND_ADD_TEXT_SIZE :
            result = [[thePrinter getEpos2Printer] addTextSize:[params[0] intValue] height:[params[1] intValue]];
          break;
        case COMMAND_ADD_ALIGN:
            result = [[thePrinter getEpos2Printer] addTextAlign:[params[0] intValue]];
          break;
        case COMMAND_ADD_IMAGE_ASSET : {
            UIImage *imageData = [UIImage imageNamed: params[0]];


            NSInteger imgHeight = imageData.size.height;
            NSInteger imagWidth = imageData.size.width;

            NSInteger width = [params[1] intValue];

            CGSize size = CGSizeMake(width, imgHeight*width/imagWidth);
            UIImage *scaled = [self scaleImage:imageData scaledToFillSize:size];


            result = [[thePrinter getEpos2Printer] addImage:scaled x:0 y:0
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


            result = [[thePrinter getEpos2Printer] addImage:scaled x:0 y:0
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
                           target: target
                      ];
          break;
        }
        case COMMAND_ADD_CUT :
            result = [[thePrinter getEpos2Printer] addCut:EPOS2_CUT_FEED];
          break;
        case COMMAND_ADD_DATA: {
            NSData *data = [[NSData alloc] initWithBase64EncodedString: params[0] options:0];

           result = [[thePrinter getEpos2Printer] addCommand:data];
          break;
        }
        case COMMAND_ADD_TEXT_SMOOTH :
            result = [[thePrinter getEpos2Printer] addTextSmooth:[params[0] intValue]];
          break;
        case COMMAND_ADD_BARCODE :
            result = [[thePrinter getEpos2Printer] addBarcode:params[0] type:[params[1] intValue] hri:[params[2] intValue] font:EPOS2_FONT_A width:[params[3] intValue] height:[params[4] intValue]];
          break;
        case COMMAND_ADD_QRCODE :
            result = [[thePrinter getEpos2Printer] addSymbol:params[0] type:[params[1] intValue] level:[params[2] intValue] width:[params[3] intValue] height:[params[3] intValue] size:[params[3] intValue]];
          break;
    }

    return result;
}

RCT_EXPORT_METHOD(printBuffer: (NSArray *)printBuffer
                  target:(NSString *)target
                  params:(NSDictionary *)params
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)
{
    // [tasksQueue addOperationWithBlock: ^{
    [self printFromBuffer:printBuffer target:target params:params onSuccess:^(NSString *result) {
            resolve(result);
        } onError:^(NSString *error) {
            reject(@"event_failure",error, nil);
    }];
    // }];
}

- (void)printFromBuffer:(NSArray*)buffer target:(NSString *)target params:(NSDictionary *)params onSuccess: (void(^)(NSString *))onSuccess onError: (void(^)(NSString *))onError
{
    int result = EPOS2_SUCCESS;
    ThePrinter* thePrinter = [objManager_ getObject:target];

    if (thePrinter == nil) {
        NSString *errorString = [ErrorManager getEposErrorText: EPOS2_ERR_PARAM];
        onError(errorString);
        return;
    }

    NSUInteger length = [buffer count];
    for (int j = 0; j < length; j++ ) {
        result = [self handleCommand:[buffer[j][0] intValue] params:buffer[j][1] target:target];

        if (result != EPOS2_SUCCESS) {
            [[thePrinter getEpos2Printer] clearCommandBuffer];
            NSString *errorString = [ErrorManager getEposErrorText: result];
            onError(errorString);
            return;
        }
    }

    result = [self printData:params target:target];
    if (result != EPOS2_SUCCESS) {
        NSString *errorString = [ErrorManager getEposErrorText: result];
        onError(errorString);
        return;
    }

    [[thePrinter getEpos2Printer] clearCommandBuffer];
    NSString *successString = [ErrorManager getEposErrorText: EPOS2_SUCCESS];
    onSuccess(successString);
}

// - (BOOL)createReceiptData:(NSString*)objid
// {
//     int result = EPOS2_SUCCESS;
    
//     if (thePrinterWrapper_ == nil) {
//         return EPOS2_ERR_MEMORY;
//     }
    
//     CellManager* sharedManager = [CellManager sharedHelper];
    
//     if ([sharedManager checkCellForID:objid] == false) {
//         return EPOS2_ERR_MEMORY;
//     }
    
//     // begin Transaction
//     int beginTransaction = [thePrinterWrapper_ beginTransaction:objid];
//     if (beginTransaction != EPOS2_SUCCESS) {
//         // could cause issues if you are connected to the same printer but on a different interface ie tcp/bluetooth
//     }
//     [sharedManager updatePrintCmdResult:objid printResult:beginTransaction cmd:@"beginTransaction"];
    
//     const int barcodeWidth = 2;
//     const int barcodeHeight = 100;
    
//     NSMutableString *textData = [[NSMutableString alloc] init];
//     UIImage *logoData = [UIImage imageNamed:@"store.png"];
    
//     if (textData == nil || logoData == nil) {
//         return EPOS2_ERR_MEMORY;
//     }
    
//     result = [thePrinterWrapper_ addTextAlign:objid align:EPOS2_ALIGN_CENTER];
//     if (result != EPOS2_SUCCESS) {
//         [thePrinterWrapper_ clearCommandBuffer:objid];
//         [ShowMsg showErrorEpos:result method:@"addTextAlign"];
//         return result;
//     }
    
//     // add printer information
//     result = [thePrinterWrapper_ addFeedLine:objid lines:1];
//     if (result != EPOS2_SUCCESS) {
//         [thePrinterWrapper_ clearCommandBuffer:objid];
//         [ShowMsg showErrorEpos:result method:@"addFeedLine"];
//         return result;
//     }
    
//     Epos2DeviceInfo* info = [sharedManager getDeviceInfo:objid];
//     int numberOfCopies = [sharedManager getNumberOfCopies:objid];
//     int copyNo = [sharedManager getCurrentCopyNumber:objid];

//     [textData appendFormat:@"Printer ID %@\n", objid];
//     [textData appendFormat:@"Printer Name %@\n", info.deviceName];
//     [textData appendFormat:@"Printer Target %@\n", info.target];
//     [textData appendFormat:@"Copy %i out of  %i\n", copyNo, numberOfCopies];
//     [textData appendString:@"------------------------------\n"];
//     result = [thePrinterWrapper_ addText:objid text:textData];
//     if (result != EPOS2_SUCCESS) {
//         [thePrinterWrapper_ clearCommandBuffer:objid];
//         [ShowMsg showErrorEpos:result method:@"addText"];
//         return result;
//     }
//     [textData setString:@""];
    
//     result = [thePrinterWrapper_ addCut:objid feed:EPOS2_CUT_FEED];
//     if (result != EPOS2_SUCCESS) {
//         [thePrinterWrapper_ clearCommandBuffer:objid];
//         [ShowMsg showErrorEpos:result method:@"addCut"];
//         return result;
//     }
    
//     return result;
// }

- (int)printData:(NSDictionary *)params target:(NSString*)target
{
    int result = EPOS2_SUCCESS;
    
    if (self == nil) {
        return EPOS2_ERR_MEMORY;
    }
    int timeout = (int)[params[@"timeout"] integerValue] ?: EPOS2_PARAM_DEFAULT;
    // send data to printer
    result = [self sendData:target timeout:timeout];
    if (result != EPOS2_SUCCESS) {
        [self clearCommandBuffer:target];        
        int endTransaction = [self endTransaction:target];
        if (endTransaction != EPOS2_SUCCESS) {
            // could cause issue when printing and connected to same printer via different interfaces
        }
        return result;
    }
    
    int endTransaction = [self endTransaction:target];
    if (endTransaction != EPOS2_SUCCESS) {
        // could cause issue when printing and connected to same printer via different interfaces
    }
    return result;
}

@end
