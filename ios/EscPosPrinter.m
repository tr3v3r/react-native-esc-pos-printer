#import "EscPosPrinter.h"
#import "PrintManager.h"

@implementation EscPosPrinter

RCT_EXPORT_MODULE()

// Example method
// See // https://reactnative.dev/docs/native-modules-ios
RCT_REMAP_METHOD(multiply,
                 multiplyWithA:(nonnull NSNumber*)a withB:(nonnull NSNumber*)b
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)
{
  NSNumber *result = @([a floatValue] * [b floatValue]);

  resolve(result);
}

RCT_EXPORT_METHOD(initLANprinter: (NSString *)ip
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)
{
  [PrintManager.shared initializeLANprinter:ip
           onSuccess: ^(NSString *result) {
      resolve(result);
           }
           onError: ^(NSString *error) {
      reject(@"event_failure",error, nil);
           }
   ];
}

RCT_EXPORT_METHOD(printText: (NSString *)text
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)
{
 [PrintManager.shared printString:text onSuccess:^(NSString *result) {
            resolve(result);
        } onError:^(NSString *error) {
            reject(@"event_failure",error, nil);
        }];
}



@end
