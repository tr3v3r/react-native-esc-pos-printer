#import "EscPosPrinterDiscovery.h"
#import "ErrorManager.h"

#import "ePOS2.h"

@interface EscPosPrinterDiscovery() <Epos2DiscoveryDelegate>
    @property (strong, nonatomic) Epos2FilterOption *filteroption;
    @property (strong, nonatomic) NSMutableArray *printerList;
@end

@implementation EscPosPrinterDiscovery

RCT_EXPORT_MODULE()

- (NSArray<NSString *> *)supportedEvents {
    return @[@"onDiscoveryDone"];
}

RCT_REMAP_METHOD(discover,
                 params:(NSDictionary *)params
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)
{
    [self startDiscovery:^(NSString *error) {
        reject(@"event_failure",error, nil);
    }];

    [self performDiscovery:^(NSString *result) {
        resolve(result);

    } params:params];
}

- (void) startDiscovery: (void(^)(NSString *))onError
{
    [Epos2Discovery stop];

    _filteroption  = [[Epos2FilterOption alloc] init];
    [_filteroption setDeviceType:EPOS2_TYPE_PRINTER];
    _printerList = [ [NSMutableArray alloc] init ];

    int result = [Epos2Discovery start:_filteroption delegate:self];
    if (result != EPOS2_SUCCESS) {
        onError(@"startDiscovery error");
    }
}

- (void)stopDiscovery
{
    int result = EPOS2_SUCCESS;

    result = [Epos2Discovery stop];

    if (result != EPOS2_SUCCESS) {
        return;
    }
}

- (void) performDiscovery: (void(^)(NSString *))onFinish params:(NSDictionary *)params
{
    // Default to 5000 if the value is not passed.
    int scanningTimeout = (int)[params[@"scanningTimeoutIOS"] integerValue] ?: 5000;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, scanningTimeout * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
        [self stopDiscovery];
        onFinish(@"Search completed");
    });
}

- (NSString *) getUSBAddress: (NSString *)target {
    NSRange rangeFirstThree = NSMakeRange(0, 3);
    NSRange rangeThreeTillLength = NSMakeRange(4, [target length] - 4);
    NSString *res;
    if ([[target substringWithRange:rangeFirstThree] isEqualToString:@"USB"]) {
        res = [target substringWithRange:rangeThreeTillLength];
    } else {
        res = @"";
    }
    
    return res;
}

- (void) onDiscovery:(Epos2DeviceInfo *)deviceInfo
{
    [_printerList addObject:deviceInfo];

    NSMutableArray *stringArray = [[NSMutableArray alloc] init];

    for (int i = 0; i < [_printerList count]; i++)
    {
        Epos2DeviceInfo *info = _printerList[i];
        NSString *name = [info getDeviceName];
        NSString *ip = [info getIpAddress];
        NSString *mac = [info getMacAddress];
        NSString *target = [info getTarget];
        NSString *bt = [info getBdAddress];
        NSString *usb = [self getUSBAddress: target];

        [stringArray addObject:@{
            @"name": name,
            @"ip": ip,
            @"mac": mac,
            @"target": target,
            @"bt": bt,
            @"usb": usb
        }];
    }


    [self sendEventWithName:@"onDiscoveryDone" body:stringArray];

    NSLog(@"Discovery done!");
}

@end
