#import "EscPosPrinter.h"
#import "ErrorManager.h"

@interface EscPosPrinter() <Epos2PtrReceiveDelegate>
 @property (strong, nonatomic) NSString* printerAddress;
@end

@implementation EscPosPrinter

#define DISCONNECT_INTERVAL                  0.5

RCT_EXPORT_MODULE()

- (NSArray<NSString *> *)supportedEvents {
    return @[@"onPrintSuccess", @"onPrintFailure"];
}

RCT_EXPORT_METHOD(initLANprinter: (NSString *)ip
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)
{
   [self initializeLANprinter:ip
           onSuccess: ^(NSString *result) {
      resolve(result);
           }
           onError: ^(NSString *error) {
      reject(@"event_failure",error, nil);
           }
    ];
}

RCT_EXPORT_METHOD(initBTprinter: (NSString *)address
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)
{
   [self initializeBTprinter:address
           onSuccess: ^(NSString *result) {
      resolve(result);
           }
           onError: ^(NSString *error) {
      reject(@"event_failure",error, nil);
           }
    ];
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


// Methods
- (void)initializeLANprinter: (NSString*) ip onSuccess: (void(^)(NSString *))onSuccess onError: (void(^)(NSString *))onError
{
    [self finalizeObject];
    printer = nil;
    PrinterInfo* printerInfo = [PrinterInfo sharedPrinterInfo];
    printerInfo.printerSeries = EPOS2_TM_T88;
    printerInfo.lang = EPOS2_MODEL_ANK;

    printer = [[Epos2Printer alloc] initWithPrinterSeries:printerInfo.printerSeries lang:printerInfo.lang];

    if (printer == nil) {
        NSString *errorString = [ErrorManager getEposErrorText: EPOS2_ERR_PARAM];
        onError(errorString);
        return;
    }

    [printer setReceiveEventDelegate:self];
    self.printerAddress = [NSString stringWithFormat:@"TCP:%@", ip];

    NSString *successString = [ErrorManager getEposErrorText: EPOS2_SUCCESS];
    onSuccess(successString);
}

- (void)initializeBTprinter: (NSString*) bluetoothAddress onSuccess: (void(^)(NSString *))onSuccess onError: (void(^)(NSString *))onError
{
   [self finalizeObject];
   printer = nil;
   PrinterInfo* printerInfo = [PrinterInfo sharedPrinterInfo];
   printerInfo.printerSeries = EPOS2_TM_T88;
   printerInfo.lang = EPOS2_MODEL_ANK;

   printer = [[Epos2Printer alloc] initWithPrinterSeries:printerInfo.printerSeries lang:printerInfo.lang];

   if (printer == nil) {
       NSString *errorString = [ErrorManager getEposErrorText: EPOS2_ERR_PARAM];
       onError(errorString);
       return;
   }

   [printer setReceiveEventDelegate:self];

   self.printerAddress = [NSString stringWithFormat:@"BT:%@", bluetoothAddress];
   NSString *successString = [ErrorManager getEposErrorText: EPOS2_SUCCESS];
   onSuccess(successString);
}

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

@end
