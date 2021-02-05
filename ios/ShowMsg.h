#import <Foundation/Foundation.h>
#import "ePOS2.h"

@interface ShowMsg : NSObject
    //show method error
+ (void)showErrorEpos:(int)result method:(NSString *)method;
+ (void)showErrorEposBt:(int)result method:(NSString *)method;
+ (void)showErrorEposCode:(int)result method:(NSString *)method;


//show Printer Result
+ (void)showResult:(int)code errMsg:(NSString *)errMsg;

//show message
+ (void)show:(NSString *)msg;
@end
