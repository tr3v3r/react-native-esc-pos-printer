#import <Foundation/Foundation.h>
#import "ePOS2.h"

@interface ErrorManager : NSObject

+ (NSString *)getEposErrorText:(int)error;
+ (NSString *)getEposResultText:(int)result;

@end
