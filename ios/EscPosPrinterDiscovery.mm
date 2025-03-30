#import "EscPosPrinterDiscovery.h"
#import "EposStringHelper.h"

#import "ePOS2.h"

@interface EscPosPrinterDiscovery() <Epos2DiscoveryDelegate>
    @property (strong, nonatomic) NSMutableArray *printerList;
@end

@implementation EscPosPrinterDiscovery

RCT_EXPORT_MODULE()

- (NSDictionary *)constantsToExport
{
 return [EposStringHelper getDiscoveryConstants];
}

- (NSDictionary *)getConstants {
    return [self constantsToExport];
}

#if RCT_NEW_ARCH_ENABLED
- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params
{
    return std::make_shared<facebook::react::NativeEscPosPrinterDiscoverySpecJSI>(params);
}
#endif

+ (BOOL) requiresMainQueueSetup {
  return YES;
}

- (NSArray<NSString *> *)supportedEvents {
    return @[@"onDiscovery"];
}

RCT_EXPORT_METHOD(startDiscovery:(NSDictionary *)params
                 resolve:(RCTPromiseResolveBlock)resolve
                 reject:(RCTPromiseRejectBlock)reject)
{
    Epos2FilterOption *filterOption = [self getFilterOptionsFromParams: params];
    _printerList = [ [NSMutableArray alloc] init ];

    int result = [Epos2Discovery start:filterOption delegate:self];
    if(result == EPOS2_SUCCESS) {
       resolve(nil);
    } else {
       reject(@"event_failure", [@(result) stringValue], nil);
    }
}


RCT_EXPORT_METHOD(stopDiscovery:(RCTPromiseResolveBlock)resolve
                 reject:(RCTPromiseRejectBlock)reject)
{
    int result = EPOS2_SUCCESS;
    result = [Epos2Discovery stop];

    if(result == EPOS2_SUCCESS) {
       resolve(nil);
    } else {
       reject(@"event_failure", [@(result) stringValue], nil);
    }
}

RCT_EXPORT_METHOD(pairBluetoothDevice: (NSString *) macAddress
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
{
    @synchronized (self) {
       Epos2BluetoothConnection *pairingPrinter = [[Epos2BluetoothConnection alloc] init];
       NSMutableString *address = [NSMutableString stringWithString: macAddress];
       int result = [pairingPrinter connectDevice: address];

        if(result == EPOS2_BT_SUCCESS || result == EPOS2_BT_ERR_ALREADY_CONNECT) {
            resolve(nil);
        } else {
            reject(@"event_failure", [@(result) stringValue], nil);
        }
    }
}

- (Epos2FilterOption*) getFilterOptionsFromParams: (NSDictionary *)params {
    Epos2FilterOption *filterOption = [[Epos2FilterOption alloc] init];


    int portType = (int)[params[@"portType"] integerValue];
    NSString *broadcast = params[@"broadcast"];
    int deviceModel = (int)[params[@"deviceModel"] integerValue];
    int deviceType = (int)[params[@"deviceType"] integerValue];

    if(portType) {
       [filterOption setPortType:portType];
    }
    if(broadcast) {
       [filterOption setBroadcast:broadcast];
    }
    if(deviceModel) {
       [filterOption setDeviceModel:deviceModel];
    }
    if(deviceType) {
       [filterOption setDeviceType:deviceType];
    }
    return filterOption;
}

- (void) onDiscovery:(Epos2DeviceInfo *)deviceInfo
{
    NSString *target = [deviceInfo getTarget];
    NSString *deviceName = [deviceInfo getDeviceName];
    NSString *ipAddress = [deviceInfo getIpAddress];
    NSString *macAddress = [deviceInfo getMacAddress];
    NSString *bdAddress = [deviceInfo getBdAddress];
    int deviceType = [deviceInfo getDeviceType];

    [_printerList addObject:@{
        @"target": target,
        @"deviceName": deviceName,
        @"ipAddress": ipAddress,
        @"macAddress": macAddress,
        @"bdAddress": bdAddress,
        @"deviceType": @(deviceType)
    }];

    #if RCT_NEW_ARCH_ENABLED

    [self emitOnDiscovery:_printerList];
    #else
    [self sendEventWithName:@"onDiscovery" body:_printerList];
    #endif
}
@end
