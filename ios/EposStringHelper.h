#import <Foundation/Foundation.h>
#import "ePOS2.h"

@interface EposStringHelper : NSObject

+ (NSDictionary *)convertStatusInfoToDictionary:(Epos2PrinterStatusInfo *)status;
+ (int)getPrinterSeries:(NSString*)name;

@end
