#ifndef ThePrinter_h
#define ThePrinter_h
#import "ePOS2.h"


/**
 Delegate callbacks
 callbacks have the objectid in their params.
*/
@protocol PrinterDelegate <NSObject>

@optional
- (void) onGetPrinterSetting:(NSString* _Nonnull)objectid code:(int)code type:(int)type value:(int)value;
- (void) onPtrReceive:(NSString* _Nonnull)objectid data:(NSDictionary* _Nonnull)data;
@end


@interface ThePrinter : NSObject {

@private
    NSString*        printerTarget_; // the printer target
    Epos2Printer*    epos2Printer_;  // eposPrinter
    bool             isConnected_;   // cache if printer is connected
    bool             didBeginTransaction_; // did start transactions
}

/**
 ThePrinter Delegate callbacks
 */
@property (nonatomic, assign) id<PrinterDelegate> _Nullable Delegate;

/**
 Returns ThePrinter
 function initWith Will create a new printer with settings given
 @param printerTarget the target for the printer  -- deviceInfo.target
 @param series the printer series -- EPOS2_TM_M30II
 @param lang the printer language -- EPOS2_MODEL_ANK
 @return ThePrinter object
 */
- (id _Nonnull) initWith:(nonnull NSString*)printerTarget series:(int)series lang:(int)lang delegate:(id<PrinterDelegate >_Nullable)delegate;

/**
 Returns ePOS result int
 Function connect tries to connect selected printer
 @param timeout the amount of time before giving up -- EPOS2_PARAM_DEFAULT
 @return int ePOS result
 */
- (int) connect:(long)timeout;

/**
 Returns ePOS result int
 Function disconnect tries to disconnect selected printer
 @return int ePOS result
 */
- (int) disconnect;

-(int) clearCommandBuffer;

-(int) addText: (nonnull NSString*)data;

-(int) addTextLang:(int)lang;

-(int) addFeedLine: (int)line;

-(int) addLineSpace: (int)linespc;

-(int) addCut: (int)type;

-(int) addCommand: (nonnull NSString* )base64string;

-(int) addPulse:(int)drawer time:(int)time;

-(int) addTextAlign:(int)align;

-(int) addTextSize:(long)width height:(long)height;

-(int) addTextSmooth:(int)smooth;

-(int) addTextStyle:(int)reverse ul:(int)ul em:(int)em color:(int)color;

-(int) addImage: (nonnull NSDictionary*)source
      width:(long)width
      color:(int)color
      mode:(int)mode
      halftone:(int)halftone
      brightness:(double)brightness
      compress:(int)compress;

-(int) addBarcode: (nonnull NSString *)data type:(int)type hri:(int)hri font:(int)font width:(long)width height:(long)height;

-(int) addSymbol:(nonnull NSString *)data type:(int)type level:(int)level width:(long)width height:(long)height size:(long)size;

-(nonnull NSDictionary*) getStatus;

/**
 Returns BOOL
 Function isConnected uses getStatus to understand if it is connected or not.
 @return bool -- returns true if connected
 */
- (bool) isConnected;

/**
 Returns String
 Function getPrinterTarget retrievies the printer target set from initWith.
 @return String containing printer target
 */
- (nonnull NSString*) getPrinterTarget;

/**
 Returns Epos2Printer
 Function getEpos2Printer returns the inner Epos2Printer -- please do not release this pointer. it is exposed for ease of use
 @return Epos2Printer inner pointer
 */
- (Epos2Printer* _Nonnull) getEpos2Printer;


/**
 Returns ePOS int result
 Function getPrinterSettings see ePOS SDK
 @param long timeout -- how long to wait before timing out EPOS2_PARAM_DEFAULT
 @param int type of Printer settings to get ie, EPOS2_PRINTER_SETTING_PAPERWIDTH
 @return ePOS int result
 */
-(void) getPrinterSetting:(long)timeout type:(int)type successHandler: (void(^_Nonnull)(NSDictionary*_Nonnull data)) successHandler
   errorHandler: (void(^_Nonnull)(NSString*_Nonnull data)) errorHandler;
/**
 Returns ePOS int result
 Function sendData see ePOS SDK
 @param long timeout -- how long to wait before timing out EPOS2_PARAM_DEFAULT
 @return  ePOS int result
 */
-(void) sendData:(long)timeout successHandler: (void(^_Nonnull)(NSDictionary*_Nonnull data)) successHandler
   errorHandler: (void(^_Nonnull)(NSString* data)) errorHandler;

/**
 Returns ePOS int result
 Function beginTransaction see ePOS SDK
 @return ePOS int result
 */
-(int) beginTransaction;

/**
 Returns ePOS int result
 Function endTransaction see ePOS SDK
 @return ePOS int result
 */
-(int) endTransaction;

@end

#endif /* ThePrinter_h */
