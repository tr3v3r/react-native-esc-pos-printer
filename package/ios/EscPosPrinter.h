#import "ePOS2.h"
#import "ThePrinterManager.h"

#if RCT_NEW_ARCH_ENABLED
#import "RNEscPosPrinterSpec.h"

@interface EscPosPrinter : NSObject <NativeEscPosPrinterSpec>
{
    ThePrinterManager* objManager_;
}
@end
#else

#import <React/RCTBridgeModule.h>
@interface EscPosPrinter : NSObject <RCTBridgeModule>
{
    ThePrinterManager* objManager_;
}
@end


#endif
