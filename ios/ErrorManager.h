#import <Foundation/Foundation.h>
#import "ePOS2.h"

@interface ErrorManager : NSObject

+ (NSString *)getEposErrorText:(int)error;
+ (NSString *)getEposResultText:(int)result;
+ (NSString *)getEposBTResultText:(int)result;
+ (NSDictionary *)makeStatusMessage:(Epos2PrinterStatusInfo *)status;
+ (NSDictionary *)getOfflineStatusMessage;
+ (int)getEposGetWidthResult:(int)result;

@end
