//
//  ThePrinter.m
//
//
//

#import <Foundation/Foundation.h>
#import "ThePrinter.h"
#import "NSlogHelper.h"
#import "EposStringHelper.h"


@interface ThePrinter() <Epos2PtrStatusChangeDelegate, Epos2PtrReceiveDelegate, Epos2PrinterSettingDelegate>
@end


@implementation ThePrinter

-(id)init {
    self = [super init];
    if (self)
    {
        printerTarget_ = nil;
        epos2Printer_ = nil;
        isConnected_ = false;
        didBeginTransaction_ = false;
        shutdown_ = false;
        didStartStatusMonitor_ = false;
        isWaitingForPrinterSettings_ = false;
        connectingState_ = PRINTER_IDLE;
        shutdownLock_ = [[NSObject alloc] init];
    }
    NSLog(@"ThePrinter init: %lu", (unsigned long)[self hash]);

    return self;
}

-(void)dealloc
{
    @synchronized (self) {
        NSLog(@"ThePrinter dealloc: %lu", (unsigned long)[self hash]);
        printerTarget_ = nil;
        if (epos2Printer_) {
            epos2Printer_ = nil;
        }
        isConnected_ = false;
        didBeginTransaction_ = false;
        didStartStatusMonitor_ = false;
        _Delegate = nil;
    }
}

-(void)removeDelegates
{
    @synchronized (self) {
        if (epos2Printer_ == nil) return;
        
        [epos2Printer_ setReceiveEventDelegate:nil];
        [epos2Printer_ setConnectionEventDelegate:nil];
        [epos2Printer_ setStatusChangeEventDelegate:nil];
    }
}

-(void)shutdown:(bool)closeConnection {
    
    // set flag;
    @synchronized (shutdownLock_) {
        if (shutdown_) return;
        shutdown_ = true;
        _Delegate = nil;
    }
    
    @synchronized (self) {

        // disconnect
        if (closeConnection && [self isConnected]) {
            [self disconnect];
        }

    }

}

- (id _Nonnull) initWith:(nonnull NSString*)printerTarget series:(int)series lang:(int)lang delegate:(id<PrinterDelegate >_Nullable)delegate
{

    @synchronized (self) {
        self = [self init];
        
        // store printer target
        printerTarget_ = printerTarget;
        
        // create printer object
        epos2Printer_ = [[Epos2Printer alloc] initWithPrinterSeries:series lang:lang];
        [epos2Printer_ setReceiveEventDelegate:self];
        
        _Delegate = delegate;
        
        if (epos2Printer_ == nil) {
            [self handleNoObject];
        }
        
        // give cpu some time
        [NSThread sleepForTimeInterval:0.01];
        
        return self;
    }
}

-(void) setBusy:(ThePrinterState)busy
{
    @synchronized (self) {
        connectingState_ = busy;
    }
}

- (Epos2Printer*) getEpos2Printer
{
    @synchronized (self) {
        return epos2Printer_;
    }
}

- (bool)isConnected
{
    // check to see if we are actually connected
    @synchronized (self) {
        bool isConnected = true;
        Epos2PrinterStatusInfo* info = [epos2Printer_ getStatus];
        if (info.connection) {
            isConnected = true;
        } else {
            isConnected = false;
        }
                
        return isConnected;
    }
}

- (nonnull NSString*) getPrinterTarget
{
    return printerTarget_;
}

- (bool) isPrinterBusy
{
    @synchronized (self) {
        bool isBusy = false;
        
        // printer not in idle state
        if (connectingState_ != PRINTER_IDLE) isBusy = true;
        
        // waiting for printer settings to callback
        if (isWaitingForPrinterSettings_) isBusy = true;
                
        return isBusy;
    }
}


#pragma mark - Epos2Printer objc API
- (int) connect:(long)timeout startMonitor:(bool)startMonitor {
    
    @synchronized (shutdownLock_) {
        if (shutdown_) return EPOS2_ERR_ILLEGAL;
    }
    
    @synchronized (self) {
        if (epos2Printer_ == nil) {
            return false;
        }
        
        int connectResult = EPOS2_SUCCESS;
        
        if (isConnected_) {
            return connectResult;
        }

        NSLog(@"Printer - About to connect to: %@", printerTarget_);
        // set printer to connecting
        connectingState_ = PRINTER_CONNECTING;
        connectResult = [epos2Printer_ connect:printerTarget_ timeout:timeout];
        if (connectResult != EPOS2_SUCCESS)
        {
            // seet printer to idle
            isConnected_ = false;
            connectingState_ = PRINTER_IDLE;
            return connectResult;
        }
        
        // connection success
        isConnected_ = true;
                
        // start monitor
        if (startMonitor) {
            int resultMonitor = [self startMonitor];
            if (resultMonitor != EPOS2_SUCCESS) {
                connectingState_ = PRINTER_IDLE;
            }
        } else {
            connectingState_ = PRINTER_IDLE;
        }

        [NSThread sleepForTimeInterval:0.01];
        NSLog(@"Printer - connected to: %@", printerTarget_);

        return connectResult;
    }
}

- (int) disconnect
{
    @synchronized (self) {
        
        if (epos2Printer_ == nil) {
            NSLog(@"epos2Printer is nil %@", printerTarget_);
            return EPOS2_ERR_MEMORY;
        }
        
        
        if (!isConnected_) {
            NSLog(@"epos2Printer is already disconnected %@", printerTarget_);
            return EPOS2_SUCCESS;
        }
        
        //update printer state
        connectingState_ = PRINTER_DISCONNECTING;

        NSLog(@"Printer - About to disconnect from: %@", printerTarget_);
        
        // end transaction if it was started
        [self endTransaction];

        // stop monitor if it was started
        if (didStartStatusMonitor_) {
            [epos2Printer_ setStatusChangeEventDelegate:nil];
            int stopmonitor = [self stopMonitor];
            if (stopmonitor != EPOS2_SUCCESS) {
                NSLog(@"Printer - Stopping StatusMonitor failed");
            }
        }
        didStartStatusMonitor_ = false;
        
        int result = 1;
        bool exit_loop = false;
        int nWaitSeconds = 10;
        
        // try and disconnect from printer
        while(result || exit_loop)
        {
            if(epos2Printer_ == nil)
            {
                NSLog(@"Printer -  Disconnected Already!");
                break;
            }
            
            [self endTransaction];
            
            NSLog(@"Printer -  disconnecting");
            result = [epos2Printer_ disconnect];
            
            switch(result)
            {
                case EPOS2_SUCCESS:
                    NSLog(@"Printer -  EPOS2_SUCCESS");
                    exit_loop = true;
                    break;
                case EPOS2_ERR_ILLEGAL:
                    NSLog(@"Printer -  EPOS2_ERR_ILLEGAL");
                    exit_loop = true;
                    break;
                case EPOS2_ERR_MEMORY:
                    NSLog(@"Printer -  EPOS2_ERR_MEMORY");
                    exit_loop = true;
                    break;
                case EPOS2_ERR_FAILURE:
                    NSLog(@"Printer -  EPOS2_ERR_FAILURE");
                    exit_loop = true;
                    break;
                case EPOS2_ERR_PROCESSING:
                    NSLog(@"Printer -  EPOS2_ERR_PROCESSING");
                    exit_loop = false;
                    break;
                case EPOS2_ERR_DISCONNECT:
                    NSLog(@"Printer -  EPOS2_ERR_DISCONNECT");
                    exit_loop = true;
                    break;
            }
            
            if (exit_loop) {
                break;
            }
            
            [NSThread sleepForTimeInterval:1];
            
            @synchronized (shutdownLock_) {
                if (shutdown_) {
                    break;
                }
            }
            
            if (--nWaitSeconds == 0) {
                // timeout 20aeconds.
                break;
            }
        }
        
        [epos2Printer_ clearCommandBuffer];
        isConnected_ = false;
                
        NSLog(@"Printer - disconnected from: %@", printerTarget_);
        
        // update printer state
        connectingState_ = PRINTER_IDLE;

        return result;
    }
}

- (int) sendData:(long)timeout
{
    @synchronized (shutdownLock_) {
        if (shutdown_) return EPOS2_ERR_ILLEGAL;
    }
    
    @synchronized (self) {
        if (epos2Printer_ == nil) return EPOS2_ERR_MEMORY;
        
        return [epos2Printer_ sendData:timeout];

    }
}


-(int) getPrinterSettings:(long)timeout type:(int)type
{
    
    @synchronized (shutdownLock_) {
        if (shutdown_) return EPOS2_ERR_ILLEGAL;
    }
    
    @synchronized (self) {
        if (epos2Printer_ == nil) {
            return EPOS2_ERR_MEMORY;
        }
        
        // you need to be connected to get printer settings
        if (!isConnected_) {
            return EPOS2_ERR_CONNECT;
        }
        
        // still waiting for previous attempt
        if (isWaitingForPrinterSettings_) {
            return EPOS2_ERR_PROCESSING;
        }
        
        if (_Delegate == nil) {
            return EPOS2_ERR_PARAM;
        }
        
        isWaitingForPrinterSettings_ = true;
        return [epos2Printer_ getPrinterSetting:timeout type:type delegate:self];
    }
        
}

- (int) startMonitor
{
    @synchronized (shutdownLock_) {
        if (shutdown_) return EPOS2_ERR_ILLEGAL;
    }
    
    @synchronized (self) {
        
        if (epos2Printer_ == nil) {
            return EPOS2_ERR_MEMORY;
        }
        
        if (!isConnected_) {
            // please connect printer before starting monitor
            return EPOS2_ERR_PARAM;
        }
        
        NSString* msg = @"SUCCESS";
        int monitorResult = EPOS2_SUCCESS;
        
        if (didStartStatusMonitor_) return monitorResult;
        
        [epos2Printer_ setStatusChangeEventDelegate:self];
        monitorResult = [epos2Printer_ startMonitor];
        if (monitorResult != EPOS2_SUCCESS) {
            msg = [EposStringHelper getEposErrorText:monitorResult];
            NSLog(@"failed to start Monitor %@", msg);
            didStartStatusMonitor_ = false;
            [epos2Printer_ setStatusChangeEventDelegate:nil];
        } else {
            didStartStatusMonitor_ = true;
            
        }
        
        [self handleStartStatusMonitor:msg didStart:didStartStatusMonitor_];
              
        return monitorResult;
    }

}

- (int) stopMonitor
{
    
    @synchronized (self) {
        
        if (epos2Printer_ == nil) {
            return EPOS2_ERR_MEMORY;
        }
        
        if (!isConnected_) {
            // please call before disconnecting printer
            return EPOS2_ERR_DISCONNECT;
        }
        
        NSString* msg = @"SUCCESS";
        
        int result = EPOS2_SUCCESS;
         
        if (!didStartStatusMonitor_) return result;
        
        result = [epos2Printer_ stopMonitor];
        if (result != EPOS2_SUCCESS) {
            msg = [EposStringHelper getEposErrorText:result];
            NSLog(@"failed to stop Monitor %@", msg);
            didStartStatusMonitor_ = true;
        } else {
            NSLog(@"stopped Monitor");
            didStartStatusMonitor_ = false;
            [epos2Printer_ setStatusChangeEventDelegate:nil];

        }
        
        [self handleStopStatusMonitor:msg didStop:!didStartStatusMonitor_];
            
        
        didStartStatusMonitor_ = false;
        
        return result;
    }
}

-(int) beginTransaction;
{
    @synchronized (self) {
        
        if (epos2Printer_ == nil) {
            return EPOS2_ERR_MEMORY;
        }
        
        if (!isConnected_) {
            // please call before disconnecting printer
            return EPOS2_ERR_DISCONNECT;
        }
        
        int result = [epos2Printer_ beginTransaction];
        if (result != EPOS2_SUCCESS) {
            didBeginTransaction_ = false;
        } else {
            didBeginTransaction_ = true;
        }
        
        return result;
        
    }
}

-(int) endTransaction;
{
    @synchronized (self) {
        
        if (epos2Printer_ == nil) {
            return EPOS2_ERR_MEMORY;
        }
        
        if (!isConnected_) {
            // please call before disconnecting printer
            return EPOS2_ERR_DISCONNECT;
        }
        
        if (!didBeginTransaction_) return EPOS2_SUCCESS;
        
        int result = [epos2Printer_ endTransaction];
        if (result != EPOS2_SUCCESS) {
            NSLog(@"Transaction end error!");
        } else {
            didBeginTransaction_ = false;
        }
        return result;
        
    }
}

#pragma mark - error handling
- (void) handleStartStatusMonitor:(NSString*)msg didStart:(bool)didStart {
    
    @synchronized (shutdownLock_) {
        if (shutdown_) return;
    }
    
    @synchronized (self) {
        
        if (epos2Printer_ == nil) return;
        
        NSString *_objID = [NSString stringWithFormat:@"%li", [self hash]];
        
        if (_Delegate != nil && [self.Delegate respondsToSelector:@selector(onPrinterStartStatusMonitorResult:hasError:error:)]) {
            [self.Delegate onPrinterStartStatusMonitorResult:_objID hasError:(didStart) ? false : true error:(didStart)? nil : msg];
        }
    }
}

- (void) handleStopStatusMonitor:(NSString*)msg didStop:(bool)didStop {
    
    @synchronized (shutdownLock_) {
        if (shutdown_) return;
    }
    
    @synchronized (self) {
        
        if (epos2Printer_ == nil) return;
        
        NSString *_objID = [NSString stringWithFormat:@"%li", [self hash]];
        
        if (_Delegate != nil && [self.Delegate respondsToSelector:@selector(onPrinterStopStatusMonitorResult:hasError:error:)]) {
            [self.Delegate onPrinterStopStatusMonitorResult:_objID hasError:(didStop) ? false : true error:(didStop)? nil : msg];
        }
    }
}

- (void) handleNoObject {
    
   // could not create printer object
    @synchronized (self) {
        
        if (_Delegate != nil && [self.Delegate respondsToSelector:@selector(onPrinterFailedCreateObject:)]) {
            [self.Delegate onPrinterFailedCreateObject:printerTarget_];
        }
    }
}


#pragma mark - Epos2PtrStatusChangeDelegate
- (void) onPtrStatusChange:(Epos2Printer *)printerObj eventType:(int)eventType
{
    
    @synchronized (shutdownLock_) {
        if (shutdown_) { // we are in shutdown do not return anything
            if (connectingState_ == PRINTER_CONNECTING) connectingState_ = PRINTER_IDLE;
            return;
        }
    }
    
    @synchronized (self) {
 
        // update printer state
        if (connectingState_ == PRINTER_CONNECTING) connectingState_ = PRINTER_IDLE;
        
        NSString *_objID = [NSString stringWithFormat:@"%li", [self hash]];
        
        if (_Delegate != nil && [self.Delegate respondsToSelector:@selector(onPrinterStatusChange:status:)]) {
            [self.Delegate onPrinterStatusChange:_objID status:eventType];
            return;
        } else {
            if (connectingState_ == PRINTER_CONNECTING) connectingState_ = PRINTER_IDLE;
        }
        
    }
}


#pragma mark - Epos2PtrReceiveDelegate
- (void) onPtrReceive:(Epos2Printer *)printerObj code:(int)code status:(Epos2PrinterStatusInfo *)status printJobId:(NSString *)printJobId
{
    @synchronized (shutdownLock_) {
        if (shutdown_) {
            connectingState_  = PRINTER_IDLE;
            return;
        }
    }
    
    @synchronized (self) {
        
        if (printJobId == nil) {
            printJobId = @"";
        }
        
        // store result of printing
        NSDictionary* returnData = @{
            @"ResultRawCode": [NSNumber numberWithInt:code],
            @"ResultCode": [EposStringHelper getEposResultText:code],
            @"ResultStatus": [EposStringHelper makeStatusMessage:status],
            @"printJobId": printJobId
          };
        
        NSString *_objID = [NSString stringWithFormat:@"%li", [self hash]];
                
        if (_Delegate != nil && [self.Delegate respondsToSelector:@selector(onPtrReceive:data:)]) {
            [self.Delegate onPtrReceive:_objID data:returnData];
        } else {
            connectingState_ = PRINTER_IDLE;
        }
    }
}


#pragma mark - Epos2PrinterSettingDelegate
- (void) onGetPrinterSetting:(int)code type:(int)type value:(int)value
{
    @synchronized (shutdownLock_) {
        if (shutdown_) {
            isWaitingForPrinterSettings_ = false;
            return;
        }
    }
    
    
    @synchronized (self) {
        NSString *_objID = [NSString stringWithFormat:@"%li", [self hash]];
        if (_Delegate != nil && [self.Delegate respondsToSelector:@selector(onGetPrinterSetting:code:type:value:)]) {
            [self.Delegate onGetPrinterSetting:_objID code:code type:type value:value];
        }
        isWaitingForPrinterSettings_ = false;
    }

}

- (void) onSetPrinterSetting:(int)code
{
    
}
@end
