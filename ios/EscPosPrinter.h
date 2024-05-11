#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

#import "ePOS2.h"
#import "ThePrinterManager.h"

@interface EscPosPrinter : RCTEventEmitter <RCTBridgeModule>
{
    ThePrinterManager* objManager_;
}
@end
