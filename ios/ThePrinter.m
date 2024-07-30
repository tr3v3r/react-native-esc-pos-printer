#import <Foundation/Foundation.h>
#import "ThePrinter.h"
#import "EposStringHelper.h"
#import "EposStringHelper.h"
#import "ImageManager.h"


@interface ThePrinter() <Epos2PtrReceiveDelegate, Epos2PrinterSettingDelegate>
{
    void (^onPtrRecieveSuccessHandler_)(NSDictionary* data);
    void (^onPtrRecieveErrorHandler_)(NSString* data);

    void (^onGetPrinterSettingSuccessHandler_)(NSDictionary* data);
    void (^onGetPrinterSettingErrorHandler_)(NSString* data);
}
@end


@implementation ThePrinter

-(id)init {
    self = [super init];
    if (self)
    {
        printerTarget_ = nil;
        epos2Printer_ = nil;
        isConnected_ = false;
        didBeginTransaction_ = false;

        onPtrRecieveSuccessHandler_ = nil;
        onPtrRecieveErrorHandler_ = nil;

        onGetPrinterSettingSuccessHandler_ = nil;
        onGetPrinterSettingErrorHandler_ = nil;

    }
    return self;
}

- (id _Nonnull) initWith:(nonnull NSString*)printerTarget series:(int)series lang:(int)lang delegate:(id<PrinterDelegate >_Nullable)delegate
{

    @synchronized (self) {
        self = [self init];

        // store printer target
        printerTarget_ = printerTarget;

        // create printer object
        epos2Printer_ = [[Epos2Printer alloc] initWithPrinterSeries:series lang:lang];
        [epos2Printer_ setReceiveEventDelegate:self];

        _Delegate = delegate;

        // give cpu some time
        [NSThread sleepForTimeInterval:0.01];

        return self;
    }
}

- (Epos2Printer*) getEpos2Printer
{
    @synchronized (self) {
        return epos2Printer_;
    }
}

- (bool)isConnected
{
    // check to see if we are actually connected
    @synchronized (self) {
        bool isConnected = true;
        Epos2PrinterStatusInfo* info = [epos2Printer_ getStatus];
        if (info.connection) {
            isConnected = true;
        } else {
            isConnected = false;
        }

        return isConnected;
    }
}

- (nonnull NSString*) getPrinterTarget
{
    return printerTarget_;
}

#pragma mark - Epos2Printer objc API
- (int) connect:(long)timeout {
    @synchronized (self) {
        if (epos2Printer_ == nil) {
            return false;
        }

        int connectResult = EPOS2_SUCCESS;

        if (isConnected_) {
            return connectResult;
        }

        // set printer to connecting
        connectResult = [epos2Printer_ connect:printerTarget_ timeout:timeout];
        if (connectResult != EPOS2_SUCCESS)
        {
            // seet printer to idle
            isConnected_ = false;
            return connectResult;
        }

        // connection success
        isConnected_ = true;

        [NSThread sleepForTimeInterval:0.01];

        return connectResult;
    }
}

- (int) disconnect
{
    @synchronized (self) {

        if (epos2Printer_ == nil) {
            return EPOS2_ERR_MEMORY;
        }


        if (!isConnected_) {
            return EPOS2_SUCCESS;
        }

        [self endTransaction];



        int result = 1;
        bool exit_loop = false;
        int nWaitSeconds = 10;

        // try and disconnect from printer
        while(result || exit_loop)
        {
            if(epos2Printer_ == nil)
            {
                break;
            }

            [self endTransaction];
            result = [epos2Printer_ disconnect];

            switch(result)
            {
                case EPOS2_SUCCESS:
                    exit_loop = true;
                    break;
                case EPOS2_ERR_ILLEGAL:
                    exit_loop = true;
                    break;
                case EPOS2_ERR_MEMORY:
                    exit_loop = true;
                    break;
                case EPOS2_ERR_FAILURE:
                    exit_loop = true;
                    break;
                case EPOS2_ERR_PROCESSING:
                    exit_loop = false;
                    break;
                case EPOS2_ERR_DISCONNECT:
                    exit_loop = true;
                    break;
            }

            if (exit_loop) {
                break;
            }

            [NSThread sleepForTimeInterval:1];

            if (--nWaitSeconds == 0) {
                // timeout 20aeconds.
                break;
            }
        }

        [epos2Printer_ clearCommandBuffer];
        isConnected_ = false;

        return result;
    }
}


- (int) clearCommandBuffer
{
    @synchronized (self) {
        if (epos2Printer_ == nil) {
            return EPOS2_ERR_MEMORY;
        }

        [epos2Printer_ clearCommandBuffer];
        return EPOS2_SUCCESS;
    }
}

- (void) sendData:(long)timeout
         successHandler: (void(^)(NSDictionary* data)) successHandler
         errorHandler: (void(^)(NSString* data)) errorHandler
{
    @synchronized (self) {
        if (epos2Printer_ == nil) {
            errorHandler([EposStringHelper convertDictionatyToJsonString:@{
                @"data": @(EPOS2_ERR_MEMORY),
                @"type": @"result"
            }]);

              return;
        };
        [self beginTransaction];
        int result =  [epos2Printer_ sendData:timeout];

        if(result == EPOS2_SUCCESS) {
            onPtrRecieveSuccessHandler_ = [successHandler copy];
            onPtrRecieveErrorHandler_ = [errorHandler copy];
        } else {
            [self endTransaction];
            errorHandler([EposStringHelper convertDictionatyToJsonString:@{
                @"data": @(result),
                @"type": @"result"
            }]);
        }

    }
}


-(int) addText: (NSString*)data;
{
    @synchronized (self) {
        if (epos2Printer_ == nil) {
            return EPOS2_ERR_MEMORY;
        }
        int result = [epos2Printer_ addText: data];
        return result;
    }
}

-(int) addTextLang:(int)lang;
{
    @synchronized (self) {
        if (epos2Printer_ == nil) {
            return EPOS2_ERR_MEMORY;
        }

        int result = [epos2Printer_ addTextLang: lang];
        return result;
    }
}

-(int) addFeedLine: (int)line;
{
    @synchronized (self) {
        if (epos2Printer_ == nil) {
            return EPOS2_ERR_MEMORY;
        }

        int result = [epos2Printer_ addFeedLine: line];
        return result;
    }
}

-(int) addLineSpace: (int)linespc;
{
    @synchronized (self) {
        if (epos2Printer_ == nil) {
            return EPOS2_ERR_MEMORY;
        }

        int result = [epos2Printer_ addLineSpace: linespc];
        return result;
    }
}

-(int) addCommand: (NSString* )base64string;
{
    @synchronized (self) {
        if (epos2Printer_ == nil) {
            return EPOS2_ERR_MEMORY;
        }

        NSData *data = [[NSData alloc] initWithBase64EncodedString: base64string options:0];

        int result = [epos2Printer_ addCommand: data];
        return result;
    }
}

-(int) addPulse: (int)drawer time:(int)time;
{
    @synchronized (self) {
        if (epos2Printer_ == nil) {
            return EPOS2_ERR_MEMORY;
        }

        int result = [epos2Printer_ addPulse: drawer time:time];
        return result;
    }
}

-(int)addTextAlign:(int)align;

{
    @synchronized (self) {
        if (epos2Printer_ == nil) {
            return EPOS2_ERR_MEMORY;
        }

        int result = [epos2Printer_ addTextAlign: align];
        return result;
    }
}


-(int)addTextSize:(long)width height:(long)height;

{
    @synchronized (self) {
        if (epos2Printer_ == nil) {
            return EPOS2_ERR_MEMORY;
        }

        int result = [epos2Printer_ addTextSize: width height:height];
        return result;
    }
}

-(int)addTextSmooth:(int)smooth;

{
    @synchronized (self) {
        if (epos2Printer_ == nil) {
            return EPOS2_ERR_MEMORY;
        }

        int result = [epos2Printer_ addTextSmooth: smooth];
        return result;
    }
}

-(int) addTextStyle:(int)reverse ul:(int)ul em:(int)em color:(int)color;

{
    @synchronized (self) {
        if (epos2Printer_ == nil) {
            return EPOS2_ERR_MEMORY;
        }

        int result = [epos2Printer_ addTextStyle: reverse ul:ul em:em color:color];
        return result;
    }
}

-(int) addCut: (int)type;
{
    @synchronized (self) {
        if (epos2Printer_ == nil) {
            return EPOS2_ERR_MEMORY;
        }

        int result = [epos2Printer_ addCut: type];
        return result;
    }
}


-(int) addImage: (NSDictionary *)source
      width:(long)width
      color:(int)color
      mode:(int)mode
      halftone:(int)halftone
      brightness:(double)brightness
      compress:(int)compress;
{
    @synchronized (self) {
        if (epos2Printer_ == nil) {
            return EPOS2_ERR_MEMORY;
        }
        UIImage *data = [ImageManager getImageFromDictionarySource:source];
        CGSize size = [ImageManager getImageCGSize:data width:width];
        UIImage *scaledImage = [ImageManager scaleImage:data size:size];

        int result = [epos2Printer_ addImage: scaledImage x:0 y:0 width:size.width height:size.height color:color mode:mode halftone:halftone brightness:brightness compress:compress];
        return result;
    }
}

-(int) addBarcode: (NSString *)data type:(int)type hri:(int)hri font:(int)font width:(long)width height:(long)height;
{
    @synchronized (self) {
        if (epos2Printer_ == nil) {
            return EPOS2_ERR_MEMORY;
        }

        int result = [epos2Printer_ addBarcode: data type:type hri:hri font:font width:width height:height];
        return result;
    }
}

-(int) addSymbol:(NSString *)data type:(int)type level:(int)level width:(long)width height:(long)height size:(long)size;
{
    @synchronized (self) {
        if (epos2Printer_ == nil) {
            return EPOS2_ERR_MEMORY;
        }

        int result = [epos2Printer_ addSymbol: data type:type level:level width:width height:height size:size];
        return result;
    }
}

-(NSDictionary*) getStatus
{
    @synchronized (self) {
        Epos2PrinterStatusInfo* status = [epos2Printer_ getStatus];

        if(status) {
            NSDictionary* statusDict = [EposStringHelper convertStatusInfoToDictionary:status];
            return statusDict;
        } else {
            return nil;
        }
    }
}

-(void) getPrinterSetting: (long)timeout
        type:(int)type
        successHandler: (void(^)(NSDictionary* data)) successHandler
        errorHandler: (void(^)(NSString* data)) errorHandler
{
    @synchronized (self) {
        if (epos2Printer_ == nil) {
            errorHandler([EposStringHelper convertDictionatyToJsonString:@{
                @"data": @(EPOS2_ERR_MEMORY),
                @"type": @"result"
            }]);
            return;
        }

        [self beginTransaction];
        int result = [epos2Printer_ getPrinterSetting:timeout type:type delegate:self];

        if(result == EPOS2_SUCCESS) {
            onGetPrinterSettingSuccessHandler_ = [successHandler copy];
            onGetPrinterSettingErrorHandler_ = [errorHandler copy];
        } else {
            [self endTransaction];
            errorHandler(
             [EposStringHelper convertDictionatyToJsonString:@{
                @"data": @(result),
                @"type": @"result"
             }]);
        }
    }
}

-(int) beginTransaction;
{
    @synchronized (self) {

        if (epos2Printer_ == nil) {
            return EPOS2_ERR_MEMORY;
        }

        if (!isConnected_) {
            return EPOS2_ERR_DISCONNECT;
        }

        int result = [epos2Printer_ beginTransaction];
        if (result != EPOS2_SUCCESS) {
            didBeginTransaction_ = false;
        } else {
            didBeginTransaction_ = true;
        }

        return result;

    }
}

-(int) endTransaction;
{
    @synchronized (self) {

        if (epos2Printer_ == nil) {
            return EPOS2_ERR_MEMORY;
        }

        if (!isConnected_) {
            return EPOS2_ERR_DISCONNECT;
        }

        if (!didBeginTransaction_) return EPOS2_SUCCESS;

        int result = [epos2Printer_ endTransaction];
        if (result != EPOS2_SUCCESS) {
            NSLog(@"Transaction end error!");
        } else {
            didBeginTransaction_ = false;
        }
        return result;

    }
}

#pragma mark - Epos2PtrReceiveDelegate
- (void) onPtrReceive:(Epos2Printer *)printerObj code:(int)code status:(Epos2PrinterStatusInfo *)status printJobId:(NSString *)printJobId
{
    @synchronized (self) {
        NSDictionary* returnData = [EposStringHelper convertStatusInfoToDictionary:status];
        [self endTransaction];

        if(onPtrRecieveSuccessHandler_ && onPtrRecieveErrorHandler_) {
            if(code == EPOS2_CODE_SUCCESS) {
                onPtrRecieveSuccessHandler_(returnData);
            } else {
                NSDictionary* errorDataDic = @{
                    @"data": @(code),
                    @"type": @"code"
                };
                onPtrRecieveErrorHandler_([EposStringHelper convertDictionatyToJsonString:errorDataDic]);
            }
        }

        onPtrRecieveSuccessHandler_ = nil;
        onPtrRecieveErrorHandler_ = nil;
    }
}


#pragma mark - Epos2PrinterSettingDelegate
- (void) onGetPrinterSetting:(int)code type:(int)type value:(int)value
{

    @synchronized (self) {
      NSDictionary* returnData = @{
            @"type": [NSNumber numberWithInt:type],
            @"value": [NSNumber numberWithInt:value],
          };
        [self endTransaction];

        if(onGetPrinterSettingSuccessHandler_ && onGetPrinterSettingErrorHandler_) {
            if(code == EPOS2_CODE_SUCCESS) {
                onGetPrinterSettingSuccessHandler_(returnData);
            } else {
                NSDictionary* errorDataDic = @{
                    @"data": @(code),
                    @"type": @"code"
                };
                onGetPrinterSettingErrorHandler_([EposStringHelper convertDictionatyToJsonString:errorDataDic]);
            }
        }

        onGetPrinterSettingSuccessHandler_ = nil;
        onGetPrinterSettingErrorHandler_ = nil;
    }
}

- (void) onSetPrinterSetting:(int)code
{

}
@end
