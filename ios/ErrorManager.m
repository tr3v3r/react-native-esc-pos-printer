#import "ErrorManager.h"

@implementation ErrorManager: NSObject

+ (NSString *)convertDictionatyToJsonString:(NSDictionary *)dict
{
   NSData *nsData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
   NSString *jsonString = [[NSString alloc] initWithData:nsData encoding:NSUTF8StringEncoding];

   return jsonString;
}

@end
