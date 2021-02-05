//
//  PrintManager.h
//  ePOS sample
//
//  Created by Igor Lebedev on 2/1/21.
//

#ifndef PrintManager_h
#define PrintManager_h

#import "ePOS2.h"
#import "PrinterInfo.h"

@interface PrintManager : NSObject
{
    Epos2Printer *printer;
}

+ (PrintManager *)shared;
- (void)discoverDevices: (void(^)(NSMutableArray<Epos2DeviceInfo *>*))onSuccess onError: (void(^)(NSString *))onError;
- (void)initializeLANprinter: (NSString*) ip onSuccess: (void(^)(NSString *))onSuccess onError: (void(^)(NSString *))onError;
- (void)initializeUSBprinter: (void(^)(NSString *))onSuccess onError: (void(^)(NSString *))onError;
- (void)initializeBTprinter: (void(^)(NSString *))onSuccess onError: (void(^)(NSString *))onError;
- (void)initializeBTprinter: (NSString*) bluetoothAddress onSuccess: (void(^)(NSString *))onSuccess onError: (void(^)(NSString *))onError;
- (void)printString: (NSString*) string onSuccess: (void(^)(NSString *))onSuccess onError: (void(^)(NSString *))onError;
- (void)printHexString: (NSString*) hexString onSuccess: (void(^)(NSString *))onSuccess onError: (void(^)(NSString *))onError;
- (void)printSample: (void(^)(NSString *))onSuccess onError: (void(^)(NSString *))onError;

@end

#endif /* PrintManager_h */
