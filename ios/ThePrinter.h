//
//  ThePrinter.h
//
//
//

#ifndef ThePrinter_h
#define ThePrinter_h
#import "ePOS2.h"

typedef NS_ENUM(NSUInteger, ThePrinterState) {
    PRINTER_IDLE = 0,
    PRINTER_CONNECTING,
    PRINTER_DISCONNECTING,
    PRINTER_PRINTING,
    PRINTER_REMOVING
};

/**
 Delegate callbacks
 callbacks have the objectid in their params.
*/
@protocol PrinterDelegate <NSObject>

@optional
- (void) onPrinterStartStatusMonitorResult:(NSString* _Nonnull)objectid hasError:(bool)hasError error:(NSString* _Nullable)error;
- (void) onPrinterStopStatusMonitorResult:(NSString* _Nonnull)objectid hasError:(bool)hasError error:(NSString* _Nullable)error;
- (void) onPrinterFailedCreateObject:(NSString* _Nonnull)printerTarget;
- (void) onPrinterStatusChange:(NSString* _Nonnull)objectid status:(int)status;
- (void) onGetPrinterSetting:(NSString* _Nonnull)objectid code:(int)code type:(int)type value:(int)value;
- (void) onPtrReceive:(NSString* _Nonnull)objectid data:(NSDictionary* _Nonnull)data;
@end


@interface ThePrinter : NSObject {
    
@private
    NSString*        printerTarget_; // the printer target
    Epos2Printer*    epos2Printer_;  // eposPrinter
    bool             isConnected_;   // cache if printer is connected
    bool             didBeginTransaction_; // did start transactions
    bool             didStartStatusMonitor_; // did start Status Monitor
    NSObject*        shutdownLock_;  // removing printer object
    bool             shutdown_;      // removing printer objecy
    bool             isWaitingForPrinterSettings_; // Printer Settings requested
    //int              copyNumber_; // current copy number
    ThePrinterState  connectingState_; // state of connection

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
 @param startMonitor to Start the realtime statusMonitor
 @return int ePOS result
 */
- (int) connect:(long)timeout startMonitor:(bool)startMonitor;

/**
 Returns ePOS result int
 Function disconnect tries to disconnect selected printer
 @return int ePOS result
 */
- (int) disconnect;

/**
 Returns BOOL
 Function isConnected uses getStatus to understand if it is connected or not.
 @return bool -- returns true if connected
 */
- (bool) isConnected;

/**
 Returns bool
 Function isPrinterBusy returns if printer is busy doing a long operation
 @return bool YES == printer is busy
 */
- (bool) isPrinterBusy;

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
 Returns void
 Function shutdown disconnects printer and sets flag to shutdown.  Used when tring to remove object
 @param bool closeConnection set to yest to disconnect printer
 @return void
 */
-(void) shutdown:(bool)closeConnection;


/**
 Returns void
 Function removeDelegates removes all delegate callbacks.  Used when tring to remove object
 @return void
 */
-(void) removeDelegates;

/**
 Returns void
 Function setBusy set the busy state of the printer
 @param ThePrinterState
 @return void
 */
-(void) setBusy:(ThePrinterState)busy;

/**
 Returns ePOS int result
 Function getPrinterSettings see ePOS SDK
 @param long timeout -- how long to wait before timing out EPOS2_PARAM_DEFAULT
 @param int type of Printer settings to get ie, EPOS2_PRINTER_SETTING_PAPERWIDTH
 @return ePOS int result
 */
-(int) getPrinterSettings:(long)timeout type:(int)type;

/**
 Returns ePOS int result
 Function sendData see ePOS SDK
 @param long timeout -- how long to wait before timing out EPOS2_PARAM_DEFAULT
 @return  ePOS int result
 */
-(int) sendData:(long)timeout;

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
