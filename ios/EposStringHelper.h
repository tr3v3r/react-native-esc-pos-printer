#import <Foundation/Foundation.h>
#import "ePOS2.h"

@interface EposStringHelper : NSObject

+ (NSString *)getEposErrorText:(int)error;
+ (NSString *)getEposResultText:(int)result;
+ (NSString *)getEposBTResultText:(int)result;
+ (NSDictionary *)makeStatusMessage:(Epos2PrinterStatusInfo *)status;
+ (NSDictionary *)getOfflineStatusMessage;
+ (int)getEposGetWidthResult:(int)result;
+ (NSString *)makeStatusMonitorMessage:(int)status;
+ (NSString *)convertPrintSpeedEnum2String:(int)speedEnum;
+ (NSString *)convertPrintDensityEnum2String:(int)dencityEnum;
+ (NSString *)convertPaperWidthEnum2String:(int)paperWidthEnum;
+ (NSString *)convertEpos2PrinterSettingTypeEnum2String:(int)printerSettingTypeEnum;
+ (int)getPrinterSeries:(NSString*)name;

@end
