#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

#import "ePOS2.h"
#import "PrinterInfo.h"

@interface EscPosPrinter : RCTEventEmitter <RCTBridgeModule>
{
    Epos2Printer *printer;
    Boolean isMonitoring_;
    NSOperationQueue* tasksQueue;
}
@end
