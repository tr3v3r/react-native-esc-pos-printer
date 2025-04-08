#import <Foundation/Foundation.h>
#import "ThePrinter.h"

NS_ASSUME_NONNULL_BEGIN

@interface ThePrinterManager : NSObject

+ (instancetype)sharedManager;

- (NSString *)add:(ThePrinter*)obj;
- (ThePrinter*)getObject:(NSString *) identifier;
- (void)remove:(NSString *) identifier;
- (void)removeAll;

@end

NS_ASSUME_NONNULL_END
