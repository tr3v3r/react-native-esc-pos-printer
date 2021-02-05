//
//  PrintManager.m
//  ePOS sample
//
//  Created by Igor Lebedev on 2/1/21.
//

#import <Foundation/Foundation.h>
#import "PrintManager.h"
#import "ePOS2.h"
#import "PrinterInfo.h"
#import "ShowMsg.h"

@interface PrintManager() <Epos2PtrReceiveDelegate, Epos2DiscoveryDelegate>

@property (weak, nonatomic) NSString* printerAddress;
@property (strong, nonatomic) Epos2FilterOption *filteroption;
@property (strong, nonatomic) NSMutableArray *printerList;

@end

@implementation PrintManager: NSObject

#define DISCONNECT_INTERVAL                  0.5

+ (PrintManager *)shared
{
    static PrintManager *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[PrintManager alloc] init];
        // Do any other initialisation stuff here
    });
    return shared;
}

//MARK: - discover devices

- (void)discoverDevices: (void(^)(NSMutableArray<Epos2DeviceInfo *>*))onSuccess onError: (void(^)(NSString *))onError
{
    [self startDiscovery:^(NSString *error) {
        onError(error);
    }];

    [self performDiscovery:^(NSString *result) {
        onSuccess(_printerList);
    }];

}

- (void) startDiscovery: (void(^)(NSString *))onError
{
    [Epos2Discovery stop];

    _filteroption  = [[Epos2FilterOption alloc] init];
    [_filteroption setDeviceType:EPOS2_TYPE_PRINTER];
    _printerList = [[NSMutableArray alloc]init];

    int result = [Epos2Discovery start:_filteroption delegate:self];
    if (result != EPOS2_SUCCESS) {
        onError(@"Error - discovery start failed");
    }
}

- (void) performDiscovery: (void(^)(NSString *))onFinish
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        onFinish(@"Search completed");
    });
}

- (void) onDiscovery:(Epos2DeviceInfo *)deviceInfo
{
    [_printerList addObject:deviceInfo];
}


//MARK: - print data

- (void)printHexString: (NSString*) hexString onSuccess: (void(^)(NSString *))onSuccess onError: (void(^)(NSString *))onError {
    NSString *finalString = [self stringFromHexString:hexString];

    [self printString:finalString onSuccess:^(NSString *result) {
            onSuccess(result);
        } onError:^(NSString *error) {
            onError(error);
        }];
}


- (void)printString: (NSString*) string onSuccess: (void(^)(NSString *))onSuccess onError: (void(^)(NSString *))onError
{
    int result = EPOS2_SUCCESS;

    if (printer == nil) {
        onError(@"Printer not connected");
        return;
    }

    NSMutableString *textData = [[NSMutableString alloc] init];

    if (textData == nil ) {
        onError(@"No text data initialized");
        return;
    }

    result = [printer addTextAlign:EPOS2_ALIGN_CENTER];
    if (result != EPOS2_SUCCESS) {
        [printer clearCommandBuffer];
        onError(@"Error - addTextAlign");
        return;
    }

    result = [printer addFeedLine:1];
    if (result != EPOS2_SUCCESS) {
        [printer clearCommandBuffer];
        onError(@"Error - addFeedLine");
        return;
    }
    [textData appendString:string];
    result = [printer addText:textData];
    if (result != EPOS2_SUCCESS) {
        [printer clearCommandBuffer];
        onError(@"Error - addText");
        return;
    }

    result = [printer addFeedLine:2];
    if (result != EPOS2_SUCCESS) {
        [printer clearCommandBuffer];
        onError(@"Error - addFeedLine");
        return;
    }

    result = [printer addCut:EPOS2_CUT_FEED];
    if (result != EPOS2_SUCCESS) {
        [printer clearCommandBuffer];
        onError(@"Error - addCut");
        return;
    }

    [self printData:^(NSString *result) {
            onSuccess(result);
        } onError:^(NSString *error) {
            onError(error);
        }];
}

- (void)initializeLANprinter: (NSString*) ip onSuccess: (void(^)(NSString *))onSuccess onError: (void(^)(NSString *))onError
{
    printer = nil;
    PrinterInfo* printerInfo = [PrinterInfo sharedPrinterInfo];
    printerInfo.printerSeries = EPOS2_TM_M30;
    printerInfo.lang = EPOS2_MODEL_ANK;

    printer = [[Epos2Printer alloc] initWithPrinterSeries:printerInfo.printerSeries lang:printerInfo.lang];

    if (printer == nil) {
        onError(@"LAN Printer initialization error");
        return;
    }

    [printer setReceiveEventDelegate:self];
    self.printerAddress = [NSString stringWithFormat:@"TCP:%@", ip];

    onSuccess(@"LAN Printer initialized");
}

- (void)initializeBTprinter: (void(^)(NSString *))onSuccess onError: (void(^)(NSString *))onError
{
    printer = nil;
    PrinterInfo* printerInfo = [PrinterInfo sharedPrinterInfo];
    printerInfo.printerSeries = EPOS2_TM_M30;
    printerInfo.lang = EPOS2_MODEL_ANK;

    printer = [[Epos2Printer alloc] initWithPrinterSeries:printerInfo.printerSeries lang:printerInfo.lang];

    if (printer == nil) {
        onError(@"Error - initWithPrinterSeries");
        return;
    }

    [printer setReceiveEventDelegate:self];

    Epos2BluetoothConnection *btConnection = [[Epos2BluetoothConnection alloc] init];
    NSMutableString *BDAddress = [[NSMutableString alloc] init];
    int result = [btConnection connectDevice:BDAddress];
    if (result == EPOS2_SUCCESS) {
        self.printerAddress = [NSString stringWithFormat:@"BT:%@", BDAddress];
        onSuccess(@"BT printer initialized");
    } else {
        onError(@"BT printer initialization failure");
    }
}

- (void)initializeBTprinter: (NSString*) bluetoothAddress onSuccess: (void(^)(NSString *))onSuccess onError: (void(^)(NSString *))onError
{
    printer = nil;
    PrinterInfo* printerInfo = [PrinterInfo sharedPrinterInfo];
    printerInfo.printerSeries = EPOS2_TM_M30;
    printerInfo.lang = EPOS2_MODEL_ANK;

    printer = [[Epos2Printer alloc] initWithPrinterSeries:printerInfo.printerSeries lang:printerInfo.lang];

    if (printer == nil) {
        onError(@"Error - initWithPrinterSeries");
        return;
    }

    [printer setReceiveEventDelegate:self];

    self.printerAddress = [NSString stringWithFormat:@"BT:%@", bluetoothAddress];
    onSuccess(@"BT printer initialized");
}

- (void)initializeUSBprinter: (void(^)(NSString *))onSuccess onError: (void(^)(NSString *))onError
{
    printer = nil;
    PrinterInfo* printerInfo = [PrinterInfo sharedPrinterInfo];
    printerInfo.printerSeries = EPOS2_TM_M30;
    printerInfo.lang = EPOS2_MODEL_ANK;

    printer = [[Epos2Printer alloc] initWithPrinterSeries:printerInfo.printerSeries lang:printerInfo.lang];

    if (printer == nil) {
        onError(@"Error - initWithPrinterSeries");
        return;
    }

    [printer setReceiveEventDelegate:self];

    self.printerAddress = @"USB:";
    onSuccess(@"USB printer initialized");
}

- (void)printData: (void(^)(NSString *))onSuccess onError: (void(^)(NSString *))onError
{
    int result = EPOS2_SUCCESS;

    if (printer == nil) {
        onError(@"Error - printer not initialized");
        return;
    }

    if (![self connectPrinter]) {
        [printer clearCommandBuffer];
        onError(@"Error - printer not connected");
        return;
    }

    result = [printer sendData:EPOS2_PARAM_DEFAULT];
    if (result != EPOS2_SUCCESS) {
        [printer clearCommandBuffer];
        onError(@"Error - sendData");
        [printer disconnect];
        return;
    }

    onSuccess(@"Data sent to printer");
}

- (void)finalizeObject
{
    if (printer == nil) {
        return;
    }

    [printer setReceiveEventDelegate:nil];

    printer = nil;
}

-(BOOL)connectPrinter
{
    int result = EPOS2_SUCCESS;

    if (printer == nil) {
        return NO;
    }

    result = [printer connect: self.printerAddress timeout:EPOS2_PARAM_DEFAULT];
    if (result != EPOS2_SUCCESS) {
        return NO;
    }

    return YES;
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
}

- (void) onPtrReceive:(Epos2Printer *)printerObj code:(int)code status:(Epos2PrinterStatusInfo *)status printJobId:(NSString *)printJobId
{
    [ShowMsg showResult:code errMsg:[self makeErrorMessage:status]];

    [self dispPrinterWarnings:status];

    [self performSelectorInBackground:@selector(disconnectPrinter) withObject:nil];
}

- (void)dispPrinterWarnings:(Epos2PrinterStatusInfo *)status
{
    NSMutableString *warningMsg = [[NSMutableString alloc] init];

    if (status == nil) {
        return;
    }

    if (status.paper == EPOS2_PAPER_NEAR_END) {
        [warningMsg appendString:NSLocalizedString(@"warn_receipt_near_end", @"")];
    }

    if (status.batteryLevel == EPOS2_BATTERY_LEVEL_1) {
        [warningMsg appendString:NSLocalizedString(@"warn_battery_near_end", @"")];
    }
}

- (NSString *)makeErrorMessage:(Epos2PrinterStatusInfo *)status
{
    NSMutableString *errMsg = [[NSMutableString alloc] initWithString:@""];

    if (status.getOnline == EPOS2_FALSE) {
        [errMsg appendString:NSLocalizedString(@"err_offline", @"")];
    }
    if (status.getConnection == EPOS2_FALSE) {
        [errMsg appendString:NSLocalizedString(@"err_no_response", @"")];
    }
    if (status.getCoverOpen == EPOS2_TRUE) {
        [errMsg appendString:NSLocalizedString(@"err_cover_open", @"")];
    }
    if (status.getPaper == EPOS2_PAPER_EMPTY) {
        [errMsg appendString:NSLocalizedString(@"err_receipt_end", @"")];
    }
    if (status.getPaperFeed == EPOS2_TRUE || status.getPanelSwitch == EPOS2_SWITCH_ON) {
        [errMsg appendString:NSLocalizedString(@"err_paper_feed", @"")];
    }
    if (status.getErrorStatus == EPOS2_MECHANICAL_ERR || status.getErrorStatus == EPOS2_AUTOCUTTER_ERR) {
        [errMsg appendString:NSLocalizedString(@"err_autocutter", @"")];
        [errMsg appendString:NSLocalizedString(@"err_need_recover", @"")];
    }
    if (status.getErrorStatus == EPOS2_UNRECOVER_ERR) {
        [errMsg appendString:NSLocalizedString(@"err_unrecover", @"")];
    }

    if (status.getErrorStatus == EPOS2_AUTORECOVER_ERR) {
        if (status.getAutoRecoverError == EPOS2_HEAD_OVERHEAT) {
            [errMsg appendString:NSLocalizedString(@"err_overheat", @"")];
            [errMsg appendString:NSLocalizedString(@"err_head", @"")];
        }
        if (status.getAutoRecoverError == EPOS2_MOTOR_OVERHEAT) {
            [errMsg appendString:NSLocalizedString(@"err_overheat", @"")];
            [errMsg appendString:NSLocalizedString(@"err_motor", @"")];
        }
        if (status.getAutoRecoverError == EPOS2_BATTERY_OVERHEAT) {
            [errMsg appendString:NSLocalizedString(@"err_overheat", @"")];
            [errMsg appendString:NSLocalizedString(@"err_battery", @"")];
        }
        if (status.getAutoRecoverError == EPOS2_WRONG_PAPER) {
            [errMsg appendString:NSLocalizedString(@"err_wrong_paper", @"")];
        }
    }
    if (status.getBatteryLevel == EPOS2_BATTERY_LEVEL_0) {
        [errMsg appendString:NSLocalizedString(@"err_battery_real_end", @"")];
    }

    return errMsg;
}

//MARK: - string from hex

- (NSString *)stringFromHexString:(NSString *)hexString {

    // The hex codes should all be two characters.
    if (([hexString length] % 2) != 0)
        return nil;

    NSMutableString *string = [NSMutableString string];

    for (NSInteger i = 0; i < [hexString length]; i += 2) {

        NSString *hex = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSInteger decimalValue = 0;
        sscanf([hex UTF8String], "%x", &decimalValue);
        [string appendFormat:@"%c", decimalValue];
    }

    return string;
}

//MARK: - sample receipt print

- (void)printSample: (void(^)(NSString *))onSuccess onError: (void(^)(NSString *))onError {
    if ([self createReceiptData]) {
        [self printData:^(NSString *result) {
                onSuccess(result);
            } onError:^(NSString *error) {
                onError(error);
            }];
    }
}

- (BOOL)createReceiptData
{
    int result = EPOS2_SUCCESS;

    const int barcodeWidth = 2;
    const int barcodeHeight = 100;

    if (printer == nil) {
        return NO;
    }

    NSMutableString *textData = [[NSMutableString alloc] init];
    UIImage *logoData = [UIImage imageNamed:@"store.png"];

    if (textData == nil || logoData == nil) {
        return NO;
    }

    result = [printer addTextAlign:EPOS2_ALIGN_CENTER];
    if (result != EPOS2_SUCCESS) {
        [printer clearCommandBuffer];
        [ShowMsg showErrorEpos:result method:@"addTextAlign"];
        return NO;
    }

    result = [printer addImage:logoData x:0 y:0
              width:logoData.size.width
              height:logoData.size.height
              color:EPOS2_COLOR_1
              mode:EPOS2_MODE_MONO
              halftone:EPOS2_HALFTONE_DITHER
              brightness:EPOS2_PARAM_DEFAULT
              compress:EPOS2_COMPRESS_AUTO];

    if (result != EPOS2_SUCCESS) {
        [printer clearCommandBuffer];
        [ShowMsg showErrorEpos:result method:@"addImage"];
        return NO;
    }

    // Section 1 : Store infomation
    result = [printer addFeedLine:1];
    if (result != EPOS2_SUCCESS) {
        [printer clearCommandBuffer];
        [ShowMsg showErrorEpos:result method:@"addFeedLine"];
        return NO;
    }
    [textData appendString:@"THE STORE 123 (555) 555 – 5555\n"];
    [textData appendString:@"STORE DIRECTOR – John Smith\n"];
    [textData appendString:@"\n"];
    [textData appendString:@"7/01/07 16:58 6153 05 0191 134\n"];
    [textData appendString:@"ST# 21 OP# 001 TE# 01 TR# 747\n"];
    [textData appendString:@"------------------------------\n"];
    result = [printer addText:textData];
    if (result != EPOS2_SUCCESS) {
        [printer clearCommandBuffer];
        [ShowMsg showErrorEpos:result method:@"addText"];
        return NO;
    }
    [textData setString:@""];

    // Section 2 : Purchaced items
    [textData appendString:@"400 OHEIDA 3PK SPRINGF  9.99 R\n"];
    [textData appendString:@"410 3 CUP BLK TEAPOT    9.99 R\n"];
    [textData appendString:@"445 EMERIL GRIDDLE/PAN 17.99 R\n"];
    [textData appendString:@"438 CANDYMAKER ASSORT   4.99 R\n"];
    [textData appendString:@"474 TRIPOD              8.99 R\n"];
    [textData appendString:@"433 BLK LOGO PRNTED ZO  7.99 R\n"];
    [textData appendString:@"458 AQUA MICROTERRY SC  6.99 R\n"];
    [textData appendString:@"493 30L BLK FF DRESS   16.99 R\n"];
    [textData appendString:@"407 LEVITATING DESKTOP  7.99 R\n"];
    [textData appendString:@"441 **Blue Overprint P  2.99 R\n"];
    [textData appendString:@"476 REPOSE 4PCPM CHOC   5.49 R\n"];
    [textData appendString:@"461 WESTGATE BLACK 25  59.99 R\n"];
    [textData appendString:@"------------------------------\n"];

    result = [printer addText:textData];
    if (result != EPOS2_SUCCESS) {
        [printer clearCommandBuffer];
        [ShowMsg showErrorEpos:result method:@"addText"];
        return NO;
    }
    [textData setString:@""];

    // Section 3 : Payment infomation
    [textData appendString:@"SUBTOTAL                160.38\n"];
    [textData appendString:@"TAX                      14.43\n"];
    result = [printer addText:textData];
    if (result != EPOS2_SUCCESS) {
        [printer clearCommandBuffer];
        [ShowMsg showErrorEpos:result method:@"addText"];
        return NO;
    }
    [textData setString:@""];

    result = [printer addTextSize:2 height:2];
    if (result != EPOS2_SUCCESS) {
        [printer clearCommandBuffer];
        [ShowMsg showErrorEpos:result method:@"addTextSize"];
        return NO;
    }

    result = [printer addText:@"TOTAL    174.81\n"];
    if (result != EPOS2_SUCCESS) {
        [printer clearCommandBuffer];
        [ShowMsg showErrorEpos:result method:@"addText"];
        return NO;
    }

    result = [printer addTextSize:1 height:1];
    if (result != EPOS2_SUCCESS) {
        [printer clearCommandBuffer];
        [ShowMsg showErrorEpos:result method:@"addTextSize"];
        return NO;
    }

    result = [printer addFeedLine:1];
    if (result != EPOS2_SUCCESS) {
        [printer clearCommandBuffer];
        [ShowMsg showErrorEpos:result method:@"addFeedLine"];
        return NO;
    }

    [textData appendString:@"CASH                    200.00\n"];
    [textData appendString:@"CHANGE                   25.19\n"];
    [textData appendString:@"------------------------------\n"];
    result = [printer addText:textData];
    if (result != EPOS2_SUCCESS) {
        [printer clearCommandBuffer];
        [ShowMsg showErrorEpos:result method:@"addText"];
        return NO;
    }
    [textData setString:@""];

    // Section 4 : Advertisement
    [textData appendString:@"Purchased item total number\n"];
    [textData appendString:@"Sign Up and Save !\n"];
    [textData appendString:@"With Preferred Saving Card\n"];
    result = [printer addText:textData];
    if (result != EPOS2_SUCCESS) {
        [printer clearCommandBuffer];
        [ShowMsg showErrorEpos:result method:@"addText"];
        return NO;
    }
    [textData setString:@""];

    result = [printer addFeedLine:2];
    if (result != EPOS2_SUCCESS) {
        [printer clearCommandBuffer];
        [ShowMsg showErrorEpos:result method:@"addFeedLine"];
        return NO;
    }

    result = [printer addBarcode:@"01209457"
              type:EPOS2_BARCODE_CODE39
              hri:EPOS2_HRI_BELOW
              font:EPOS2_FONT_A
              width:barcodeWidth
              height:barcodeHeight];
    if (result != EPOS2_SUCCESS) {
        [printer clearCommandBuffer];
        [ShowMsg showErrorEpos:result method:@"addBarcode"];
        return NO;
    }

    result = [printer addCut:EPOS2_CUT_FEED];
    if (result != EPOS2_SUCCESS) {
        [printer clearCommandBuffer];
        [ShowMsg showErrorEpos:result method:@"addCut"];
        return NO;
    }

    return YES;
}

@end
