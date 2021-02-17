#import "EscPosPrinter.h"
#import "ErrorManager.h"

@interface EscPosPrinter() <Epos2PtrReceiveDelegate, Epos2PrinterSettingDelegate>
 @property (strong, nonatomic) NSString* printerAddress;
@end

@implementation EscPosPrinter

#define DISCONNECT_INTERVAL                  0.5

RCT_EXPORT_MODULE()

- (NSArray<NSString *> *)supportedEvents {
    return @[@"onPrintSuccess", @"onPrintFailure", @"onGetPaperWidthSuccess", @"onGetPaperWidthFailure"];
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
      @"EPOS2_TM_M50": @(EPOS2_TM_M50)
   };
}

+ (BOOL)requiresMainQueueSetup
{
  return YES;
}

RCT_EXPORT_METHOD(initLANprinter: (NSString *)ip
                  series:(int)series
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)
{
    [self finalizeObject];
    [self initializeObject: series onSuccess:^(NSString *result) {
        resolve(result);
    } onError:^(NSString *error) {
       reject(@"event_failure",error, nil);

    }];

    self.printerAddress = [NSString stringWithFormat:@"TCP:%@", ip];
}

RCT_EXPORT_METHOD(initBTprinter: (NSString *)address
                  series:(int)series
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)
{
    [self finalizeObject];
    [self initializeObject: series onSuccess:^(NSString *result) {
        resolve(result);
    } onError:^(NSString *error) {
        reject(@"event_failure",error, nil);
    }];

   self.printerAddress = [NSString stringWithFormat:@"BT:%@", address];
}

RCT_EXPORT_METHOD(initUSBprinter: (NSString *)address
                  series:(int)series
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)
{
    [self finalizeObject];
    [self initializeObject: series onSuccess:^(NSString *result) {
        resolve(result);
    } onError:^(NSString *error) {
       reject(@"event_failure",error, nil);
    }];

    self.printerAddress = [NSString stringWithFormat:@"USB:%@", address];
}

RCT_EXPORT_METHOD(printBase64: (NSString *)base64string
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)
{
    [self printFromBase64:base64string onSuccess:^(NSString *result) {
            resolve(result);
        } onError:^(NSString *error) {
            reject(@"event_failure",error, nil);
    }];
}

RCT_EXPORT_METHOD(getPaperWidth:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)
{
    [self getPrinterSettings:EPOS2_PRINTER_SETTING_PAPERWIDTH onSuccess:^(NSString *result) {
            resolve(result);
        } onError:^(NSString *error) {
            reject(@"event_failure",error, nil);
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

RCT_EXPORT_METHOD(disconnect)
{
    [self disconnectPrinter];
}



- (void) onPtrReceive:(Epos2Printer *)printerObj code:(int)code status:(Epos2PrinterStatusInfo *)status printJobId:(NSString *)printJobId
{
    NSString *result = [ErrorManager getEposResultText: code];
    if (code == EPOS2_CODE_SUCCESS) {
      [self sendEventWithName:@"onPrintSuccess" body: result];
    }
    else {
      [self sendEventWithName:@"onPrintFailure" body: result];
    }

    [printer endTransaction];
    [self performSelectorInBackground:@selector(disconnectPrinter) withObject:nil];
}

- (void) onGetPrinterSetting: (int)code type:(int)type value:(int)value
{
   NSString *result = [ErrorManager getEposResultText: code];

  if(code == EPOS2_CODE_SUCCESS) {
    if(type == EPOS2_PRINTER_SETTING_PAPERWIDTH) {
       int paperWidth = [ErrorManager getEposGetWidthResult: value];
       [self sendEventWithName:@"onGetPaperWidthSuccess" body: @(paperWidth)];
    }
  } else {
    if(type == EPOS2_PRINTER_SETTING_PAPERWIDTH) {
       [self sendEventWithName:@"onGetPaperWidthFailure" body: result];
    }
  }

  [printer endTransaction];
  [self performSelectorInBackground:@selector(disconnectPrinter) withObject:nil];
}



// Methods

- (void)printData: (void(^)(NSString *))onSuccess onError: (void(^)(NSString *))onError
{
    int result = EPOS2_SUCCESS;

    if (printer == nil) {
        NSString *errorString = [ErrorManager getEposErrorText: EPOS2_ERR_PARAM];
        onError(errorString);
        return;
    }

    result = [printer connect: self.printerAddress timeout:EPOS2_PARAM_DEFAULT];

    if (result != EPOS2_SUCCESS) {
        [printer clearCommandBuffer];
        NSString *errorString = [ErrorManager getEposErrorText: result];
        onError(errorString);
        return;
    }


    [printer beginTransaction];
    result = [printer sendData:EPOS2_PARAM_DEFAULT];
    if (result != EPOS2_SUCCESS) {
        [printer clearCommandBuffer];
        NSString *errorString = [ErrorManager getEposErrorText: result];
        onError(errorString);
        [printer disconnect];
        return;
    }

    NSString *successString = [ErrorManager getEposErrorText: EPOS2_SUCCESS];
    onSuccess(successString);
}


- (void)initializeObject: (int)series
                          onSuccess: (void(^)(NSString *))onSuccess
                          onError: (void(^)(NSString *))onError
{
    printer = nil;
    PrinterInfo* printerInfo = [PrinterInfo sharedPrinterInfo];
    printerInfo.printerSeries = series;
    printerInfo.lang = EPOS2_MODEL_ANK;

    printer = [[Epos2Printer alloc] initWithPrinterSeries:printerInfo.printerSeries lang:printerInfo.lang];

    if (printer == nil) {
        NSString *errorString = [ErrorManager getEposErrorText: EPOS2_ERR_PARAM];
        onError(errorString);
        return;
    }

    [printer setReceiveEventDelegate:self];

    NSString *successString = [ErrorManager getEposErrorText: EPOS2_SUCCESS];
    onSuccess(successString);
}

- (void)finalizeObject
{
    if (printer == nil) {
        return;
    }

    [printer clearCommandBuffer];
    [printer setReceiveEventDelegate:nil];
     printer = nil;
}

- (void)disconnectPrinter
{
    int result = EPOS2_SUCCESS;

    if (printer == nil) {
        return;
    }

    result = [printer disconnect];
    int count = 0;
    //Note: Check if the process overlaps with another process in time.
    while(result == EPOS2_ERR_PROCESSING && count < 4) {
        [NSThread sleepForTimeInterval:DISCONNECT_INTERVAL];
        result = [printer disconnect];
        count++;
    }
    if (result != EPOS2_SUCCESS) {
//        [ShowMsg showErrorEpos:result method:@"disconnect"];
    }

    [printer clearCommandBuffer];
    NSLog(@"Disconnected!");
}

- (void)printFromBase64: (NSString*)base64String onSuccess: (void(^)(NSString *))onSuccess onError: (void(^)(NSString *))onError
{
    int result = EPOS2_SUCCESS;

    if (printer == nil) {
        NSString *errorString = [ErrorManager getEposErrorText: EPOS2_ERR_PARAM];
        onError(errorString);
        return;
    }

    NSData *data = [[NSData alloc] initWithBase64EncodedString: base64String options:0];

    result = [printer addCommand:data];
    if (result != EPOS2_SUCCESS) {
        [printer clearCommandBuffer];
        onError(@"Error - addFeedLine");
        return;
    }


    [self printData:^(NSString *result) {
            onSuccess(result);
        } onError:^(NSString *error) {
            onError(error);
    }];
}

- (void)getPrinterSettings:(int)type
                           onSuccess: (void(^)(NSString *))onSuccess
                           onError: (void(^)(NSString *))onError {
    int result = EPOS2_SUCCESS;
    if (printer == nil) {
        NSString *errorString = [ErrorManager getEposErrorText: EPOS2_ERR_PARAM];
        onError(errorString);
        return;
    }

    result = [printer connect: self.printerAddress timeout:EPOS2_PARAM_DEFAULT];

    if (result != EPOS2_SUCCESS) {
        [printer clearCommandBuffer];
        NSString *errorString = [ErrorManager getEposErrorText: result];
        onError(errorString);
        return;
    }

    [printer beginTransaction];
    result = [printer getPrinterSetting:EPOS2_PARAM_DEFAULT type:type delegate:self];

   if (result != EPOS2_SUCCESS) {
        [printer clearCommandBuffer];
        NSString *errorString = [ErrorManager getEposErrorText: result];
        onError(errorString);
        [printer disconnect];
        return;
    }

    NSString *successString = [ErrorManager getEposErrorText: EPOS2_SUCCESS];
    onSuccess(successString);
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


@end
