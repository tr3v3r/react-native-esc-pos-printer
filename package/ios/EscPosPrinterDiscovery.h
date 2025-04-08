#if RCT_NEW_ARCH_ENABLED
#import "RNEspPosPrinterSpec.h"

@interface EscPosPrinterDiscovery : NativeEscPosPrinterDiscoverySpecBase<NativeEscPosPrinterDiscoverySpec>

@end

#else

#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

@interface EscPosPrinterDiscovery : RCTEventEmitter <RCTBridgeModule>

@end

#endif
