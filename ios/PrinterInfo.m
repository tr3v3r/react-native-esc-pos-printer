#import <Foundation/Foundation.h>
#import "PrinterInfo.h"
#import "ePOS2.h"

@implementation PrinterInfo

static PrinterInfo *sharedPrinterInfo_ = nil;

+ (PrinterInfo *)sharedPrinterInfo{
    @synchronized(self){
        if (!sharedPrinterInfo_) {
            sharedPrinterInfo_ = [PrinterInfo new];
            sharedPrinterInfo_.printerSeries = EPOS2_TM_M10;
            sharedPrinterInfo_.lang = EPOS2_MODEL_ANK;
            sharedPrinterInfo_.target = [NSString stringWithFormat:@"TCP:192.168.192.168"];
        }
    }
    return sharedPrinterInfo_;
}

- (id)init
{
    self = [super init];
    if (self) {
        //Initialization
    }
    return self;
}

@end




