#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

#import "ePOS2.h"
#import "PrinterInfo.h"
#import "ThePrinterManager.h"

@interface EscPosPrinter : RCTEventEmitter <RCTBridgeModule>
{
    Boolean isMonitoring_;
    NSOperationQueue* tasksQueue;
    ThePrinterManager* objManager_;
}
@end
