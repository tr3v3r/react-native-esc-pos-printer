//
//  ThePrinterWrapper.h
//
//

#ifndef ThePrinterWrapper_h
#define ThePrinterWrapper_h

#import "ThePrinterManager.h"
#import <React/RCTEventEmitter.h>

/**
 Delegate callbacks
 callbacks have the objectid in their params.
*/
@protocol ThePrinterWrapperDelegate <NSObject>

@optional

- (void) onPrinterStartStatusMonitorResult:(NSString* _Nonnull)objectid hasError:(bool)hasError error:(NSString* _Nullable)error;
- (void) onPrinterStopStatusMonitorResult:(NSString* _Nonnull)objectid hasError:(bool)hasError error:(NSString* _Nullable)error;
- (void) onPrinterStatusChange:(NSString* _Nonnull)objectid status:(int)status;
- (void) onPtrReceive:(NSString* _Nonnull)objectid data:(NSDictionary* _Nonnull)data;
- (void) onGetPrinterSetting:(NSString* _Nonnull)objectid  code:(int)code type:(int)type value:(int)value;

- (void) onMemoryError:(NSString* _Nonnull)objectid error:(NSString* _Nonnull)error;
- (void) onDidEnterBackgroundNotification:(NSNotification* _Nonnull)notification;
@end

@interface ThePrinterWrapper : RCTEventEmitter <RCTBridgeModule> {
    @private
    ThePrinterManager* objManager_; // manage the ThePrinter objects
    NSObject* memoryNotification_; // memory notification
    NSObject* backgroundNotification_; // background notifcation

    
}

@property (nonatomic, assign) id<ThePrinterWrapperDelegate> _Nullable Delegate;

- (id _Nonnull) init;

/**
 Returns the object hash key
 function newPrinterWithSettings Will create a new printer with settings given
 @param printerTarget the target for the printer  -- deviceInfo.target
 @param series the printer series -- EPOS2_TM_M30II
 @param lang the printer language -- EPOS2_MODEL_ANK
 @return String the object hash key
 */
-(NSString* _Nonnull) newPrinterWithSettings:(NSString* _Nonnull)printerTarget series:(int)series lang:(int)lang;

/**
 Returns ePOS result int
 Function connectPrinter tries to connect selected printer
 @param objectid the object hash key from newPrinterWithSettings
 @param timeout the amount of time before giving up -- EPOS2_PARAM_DEFAULT
 @return int ePOS result
 */
-(int) connectPrinter:(nonnull NSString*)objectid timeout:(long)timeout;

/**
 Returns ePOS result int
 Function disconnectPrinter tries to disconnect selected printer
 @param objectid the object hash key from newPrinterWithSettings
 @return int ePOS result
 */
-(int) disconnectPrinter:(nonnull NSString*)objectid;

/**
 Returns ePOS result int
 Function deallocPrinter tries to delete selected printer from memory and disconnect if connected.
 @param objectid the object hash key from newPrinterWithSettings
 @return int ePOS result
 */
-(int) deallocPrinter:(nonnull NSString*)objectid;

/**
 Returns String
 Function getPrinterTarget retrievies the printer target set from newPrinterWithSettings.
 @param objectid the object hash key from newPrinterWithSettings
 @return String containing printer target
 */
-(NSString*  _Nonnull) getPrinterTarget:(nonnull NSString*)objectid;

/**
 Returns bool
 Function isPrinterBusy used to understand if printer is busy printing/disconnecting/connecting
 @param objectid the object hash key from newPrinterWithSettings
 @return bool true if is busy
 */
-(bool) isPrinterBusy:(nonnull NSString*)objid;

/**
 Returns void
 Function setBusy used to set printer is busy printing/disconnecting/connecting
 @param objectid the object hash key from newPrinterWithSettings
 @param state set the busy state of the printer
 @return void
 */
-(void) setBusy:(nonnull NSString*)objectid state:(ThePrinterState)state;

#pragma mark - Epos2Printer objc API
/**
 Please refer to the ePOS_SDK_iOS pdf manual
 not all API have been added please add more as you use them
 theses funtions wrap arround the API
 Returns ePOS result int
 @param objectid the object hash key from newPrinterWithSettings
 @return int ePOS result
 */

-(int) beginTransaction:(nonnull NSString*)objectid;
-(int) endTransaction:(nonnull NSString*)objectid;
-(int) clearCommandBuffer:(nonnull NSString*)objectid;
-(int) getPrinterSettings:(nonnull NSString*)objectid timeout:(long)timeout type:(int)type;
-(int) addText:(nonnull NSString*)objectid text:(NSString* _Nonnull)text;
-(int) addFeedLine:(nonnull NSString*)objectid lines:(long)lines;
-(int) addPulse:(nonnull NSString*)objectid pulse:(int)pulse time:(int)time;
-(int) addTextStyle:(nonnull NSString*)objectid style:(int)style ul:(int)ul em:(int)em color:(int)color;
-(int) addTextSize:(nonnull NSString*)objectid width:(long)width height:(long)height;
-(int) addTextAlign:(nonnull NSString*)objectid align:(int)align;
-(int) addImage:(nonnull NSString*)objectid image:(UIImage* _Nonnull)image x:(long)x y:(long)y width:(long)width height:(long)height color:(int)color mode:(int)mode halftone:(int)halftone brightness:(double)brightness compress:(int)compress;
-(int) addCommand:(nonnull NSString*)objectid data:(NSData* _Nonnull)data;
-(int) addCut:(nonnull NSString*)objectid feed:(int)feed;
-(int) addTextSmooth:(nonnull NSString*)objectid smooth:(int)smooth;
-(void) shutdown:(nonnull NSString*)objectid;
-(int) addBarcode:(nonnull NSString*)objectid code:(NSString* _Nonnull)code type:(int)type hri:(int)hri font:(int)font width:(long)width height:(long)height;
-(int) addSymbol:(nonnull NSString*)objectid symbol:(NSString* _Nonnull)symbol type:(int)type level:(int)level width:(long)width height:(long)height size:(long)size;
-(int) sendData:(nonnull NSString*)objectid timeout:(long)timeout;
-(Epos2PrinterStatusInfo* _Nullable) getStatus:(nonnull NSString*)objectid;

@end

#endif /* ThePrinterWrapper_h */
