#import "EscPosPrinterDiscovery.h"
#import "ErrorManager.h"

#import "ePOS2.h"

@interface EscPosPrinterDiscovery() <Epos2DiscoveryDelegate>
    @property (strong, nonatomic) NSMutableArray *printerList;
@end

@implementation EscPosPrinterDiscovery

RCT_EXPORT_MODULE()

- (NSDictionary *)constantsToExport
{
 return @{
           // filter options
          @"PORTTYPE_ALL": @(EPOS2_PORTTYPE_ALL),
          @"PORTTYPE_TCP": @(EPOS2_PORTTYPE_TCP),
          @"PORTTYPE_BLUETOOTH": @(EPOS2_PORTTYPE_BLUETOOTH),
          @"PORTTYPE_USB": @(EPOS2_PORTTYPE_USB),
          @"PORTTYPE_BLUETOOTH_LE": @(EPOS2_PORTTYPE_BLUETOOTH_LE),
          @"MODEL_ALL": @(EPOS2_MODEL_ALL),
          @"TYPE_ALL": @(EPOS2_TYPE_ALL),
          @"TYPE_PRINTER": @(EPOS2_TYPE_PRINTER),
          @"TYPE_HYBRID_PRINTER": @(EPOS2_TYPE_HYBRID_PRINTER),
          @"TYPE_DISPLAY": @(EPOS2_TYPE_DISPLAY),
          @"TYPE_KEYBOARD": @(EPOS2_TYPE_KEYBOARD),
          @"TYPE_SCANNER": @(EPOS2_TYPE_SCANNER),
          @"TYPE_SERIAL": @(EPOS2_TYPE_SERIAL),
          @"TYPE_POS_KEYBOARD": @(EPOS2_TYPE_POS_KEYBOARD),
          @"TYPE_MSR": @(EPOS2_TYPE_MSR),
          @"TYPE_GFE": @(EPOS2_TYPE_GFE),
          @"TYPE_OTHER_PERIPHERAL": @(EPOS2_TYPE_OTHER_PERIPHERAL),
          // return value
          @"ERR_PARAM": @(EPOS2_ERR_PARAM),
          @"ERR_ILLEGAL": @(EPOS2_ERR_ILLEGAL),
          @"ERR_MEMORY": @(EPOS2_ERR_MEMORY),
          @"ERR_FAILURE": @(EPOS2_ERR_FAILURE),
          @"ERR_PROCESSING": @(EPOS2_ERR_PROCESSING),
 };
}

- (NSArray<NSString *> *)supportedEvents {
    return @[@"onDiscovery"];
}

RCT_REMAP_METHOD(startDiscovery,
                 params:(NSDictionary *)params
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)
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


RCT_REMAP_METHOD(stopDiscovery,
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)
{
    int result = EPOS2_SUCCESS;
    result = [Epos2Discovery stop];

    if(result == EPOS2_SUCCESS) {
       resolve(nil);
    } else {
       reject(@"event_failure", [@(result) stringValue], nil);
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

    [_printerList addObject:@{
        @"target": target,
        @"deviceName": deviceName,
        @"ipAddress": ipAddress,
        @"macAddress": macAddress,
        @"bdAddress": bdAddress,
    }];

    [self sendEventWithName:@"onDiscovery" body:_printerList];
}

@end
