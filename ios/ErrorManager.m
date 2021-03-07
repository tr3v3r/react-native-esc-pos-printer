#import "ShowMsg.h"
#import "ErrorManager.h"

@implementation ErrorManager: NSObject

//convert Epos2Printer Error to text
+ (NSString *)getEposErrorText:(int)error
{
    NSString *errText = @"";
    switch (error) {
        case EPOS2_SUCCESS:
            errText = @"SUCCESS";
            break;
        case EPOS2_ERR_PARAM:
            errText = @"ERR_PARAM";
            break;
        case EPOS2_ERR_CONNECT:
            errText = @"ERR_CONNECT";
            break;
        case EPOS2_ERR_TIMEOUT:
            errText = @"ERR_TIMEOUT";
            break;
        case EPOS2_ERR_MEMORY:
            errText = @"ERR_MEMORY";
            break;
        case EPOS2_ERR_ILLEGAL:
            errText = @"ERR_ILLEGAL";
            break;
        case EPOS2_ERR_PROCESSING:
            errText = @"ERR_PROCESSING";
            break;
        case EPOS2_ERR_NOT_FOUND:
            errText = @"ERR_NOT_FOUND";
            break;
        case EPOS2_ERR_IN_USE:
            errText = @"ERR_IN_USE";
            break;
        case EPOS2_ERR_TYPE_INVALID:
            errText = @"ERR_TYPE_INVALID";
            break;
        case EPOS2_ERR_DISCONNECT:
            errText = @"ERR_DISCONNECT";
            break;
        case EPOS2_ERR_ALREADY_OPENED:
            errText = @"ERR_ALREADY_OPENED";
            break;
        case EPOS2_ERR_ALREADY_USED:
            errText = @"ERR_ALREADY_USED";
            break;
        case EPOS2_ERR_BOX_COUNT_OVER:
            errText = @"ERR_BOX_COUNT_OVER";
            break;
        case EPOS2_ERR_BOX_CLIENT_OVER:
            errText = @"ERR_BOXT_CLIENT_OVER";
            break;
        case EPOS2_ERR_UNSUPPORTED:
            errText = @"ERR_UNSUPPORTED";
            break;
        case EPOS2_ERR_FAILURE:
            errText = @"ERR_FAILURE";
            break;
        default:
            errText = [NSString stringWithFormat:@"%d", error];
            break;
    }
    return errText;
}

+ (NSString *)getEposResultText:(int)resultCode
{
    NSString *result = @"";
    switch (resultCode) {
        case EPOS2_CODE_SUCCESS:
            result = @"PRINT_SUCCESS";
            break;
        case EPOS2_CODE_PRINTING:
            result = @"PRINTING";
            break;
        case EPOS2_CODE_ERR_AUTORECOVER:
            result = @"ERR_AUTORECOVER";
            break;
        case EPOS2_CODE_ERR_COVER_OPEN:
            result = @"ERR_COVER_OPEN";
            break;
        case EPOS2_CODE_ERR_CUTTER:
            result = @"ERR_CUTTER";
            break;
        case EPOS2_CODE_ERR_MECHANICAL:
            result = @"ERR_MECHANICAL";
            break;
        case EPOS2_CODE_ERR_EMPTY:
            result = @"ERR_EMPTY";
            break;
        case EPOS2_CODE_ERR_UNRECOVERABLE:
            result = @"ERR_UNRECOVERABLE";
            break;
        case EPOS2_CODE_ERR_FAILURE:
            result = @"ERR_FAILURE";
            break;
        case EPOS2_CODE_ERR_NOT_FOUND:
            result = @"ERR_NOT_FOUND";
            break;
        case EPOS2_CODE_ERR_SYSTEM:
            result = @"ERR_SYSTEM";
            break;
        case EPOS2_CODE_ERR_PORT:
            result = @"ERR_PORT";
            break;
        case EPOS2_CODE_ERR_TIMEOUT:
            result = @"ERR_TIMEOUT";
            break;
        case EPOS2_CODE_ERR_JOB_NOT_FOUND:
            result = @"ERR_JOB_NOT_FOUND";
            break;
        case EPOS2_CODE_ERR_SPOOLER:
            result = @"ERR_SPOOLER";
            break;
        case EPOS2_CODE_ERR_BATTERY_LOW:
            result = @"ERR_BATTERY_LOW";
            break;
        case EPOS2_CODE_ERR_TOO_MANY_REQUESTS:
            result = @"ERR_TOO_MANY_REQUESTS";
            break;
        case EPOS2_CODE_ERR_REQUEST_ENTITY_TOO_LARGE:
            result = @"ERR_REQUEST_ENTITY_TOO_LARGE";
            break;
        case EPOS2_CODE_ERR_INVALID_WINDOW:
            result = @"EPOS2_CODE_ERR_INVALID_WINDOW";
            break;
        case EPOS2_CODE_CANCELED:
            result = @"EPOS2_CODE_CANCELED";
            break;
        case EPOS2_CODE_ERR_RECOGNITION:
            result = @"EPOS2_CODE_ERR_RECOGNITION";
            break;
        case EPOS2_CODE_ERR_READ:
            result = @"EPOS2_CODE_ERR_READ";
            break;
        case EPOS2_CODE_ERR_PAPER_JAM:
            result = @"EPOS2_CODE_ERR_PAPER_JAM";
            break;
        case EPOS2_CODE_ERR_PAPER_PULLED_OUT:
            result = @"EPOS2_CODE_ERR_PAPER_PULLED_OUT";
            break;
        case EPOS2_CODE_ERR_CANCEL_FAILED:
            result = @"EPOS2_CODE_ERR_CANCEL_FAILED";
            break;
        case EPOS2_CODE_ERR_PAPER_TYPE:
            result = @"EPOS2_CODE_ERR_PAPER_TYPE";
            break;
        case EPOS2_CODE_ERR_WAIT_INSERTION:
            result = @"EPOS2_CODE_ERR_WAIT_INSERTION";
            break;
        case EPOS2_CODE_ERR_ILLEGAL:
            result = @"EPOS2_CODE_ERR_ILLEGAL";
            break;
        case EPOS2_CODE_ERR_INSERTED:
            result = @"EPOS2_CODE_ERR_INSERTED";
            break;
        case EPOS2_CODE_ERR_WAIT_REMOVAL:
            result = @"EPOS2_CODE_ERR_WAIT_REMOVAL";
            break;
        case EPOS2_CODE_ERR_DEVICE_BUSY:
            result = @"EPOS2_CODE_ERR_DEVICE_BUSY";
            break;
        case EPOS2_CODE_ERR_IN_USE:
            result = @"EPOS2_CODE_ERR_IN_USE";
            break;
        case EPOS2_CODE_ERR_CONNECT:
            result = @"EPOS2_CODE_ERR_CONNECT";
            break;
        case EPOS2_CODE_ERR_DISCONNECT:
            result = @"EPOS2_CODE_ERR_DISCONNECT";
            break;
        case EPOS2_CODE_ERR_MEMORY:
            result = @"EPOS2_CODE_ERR_MEMORY";
            break;
        case EPOS2_CODE_ERR_PROCESSING:
            result = @"EPOS2_CODE_ERR_PROCESSING";
            break;
        case EPOS2_CODE_ERR_PARAM:
            result = @"EPOS2_CODE_ERR_PARAM";
            break;
        case EPOS2_CODE_RETRY:
            result = @"EPOS2_CODE_RETRY";
            break;
        case EPOS2_CODE_ERR_DIFFERENT_MODEL:
            result = @"EPOS2_CODE_ERR_DIFFERENT_MODEL";
            break;
        case EPOS2_CODE_ERR_DIFFERENT_VERSION:
            result = @"EPOS2_CODE_ERR_DIFFERENT_VERSION";
            break;
        case EPOS2_CODE_ERR_DATA_CORRUPTED:
            result = @"EPOS2_CODE_ERR_DATA_CORRUPTED";
            break;
        default:
            result = [NSString stringWithFormat:@"%d", resultCode];
            break;
    }

    return result;
}

+ (int)getEposGetWidthResult:(int)resultCode
{
    int result = 0;
    switch (resultCode) {
        case EPOS2_PRINTER_SETTING_PAPERWIDTH_58_0:
            result = 58;
            break;
        case EPOS2_PRINTER_SETTING_PAPERWIDTH_60_0:
            result = 60;
            break;
        case EPOS2_PRINTER_SETTING_PAPERWIDTH_80_0:
            result = 80;
            break;
        default:
            result = 0;
            break;
    }

    return result;
}


//convert Epos2Printer Error to text
+ (NSString *)getEposBTResultText:(int)error
{
    NSString *errText = @"";
    switch (error) {
        case EPOS2_BT_SUCCESS:
            errText = @"BT_SUCCESS";
            break;
        case EPOS2_BT_ERR_PARAM:
            errText = @"BT_ERR_PARAM";
            break;
        case EPOS2_BT_ERR_UNSUPPORTED:
            errText = @"BT_ERR_UNSUPPORTED";
            break;
        case EPOS2_BT_ERR_CANCEL:
            errText = @"BT_ERR_CANCEL";
            break;
        case EPOS2_BT_ERR_ALREADY_CONNECT:
            errText = @"BT_ERR_ALREADY_CONNECT";
            break;
        case EPOS2_BT_ERR_ILLEGAL_DEVICE:
            errText = @"BT_ERR_ILLEGAL_DEVICE";
            break;
        case EPOS2_BT_ERR_FAILURE:
            errText = @"BT_ERR_FAILURE";
            break;
        default:
            errText = [NSString stringWithFormat:@"%d", error];
            break;
    }
    return errText;
}

+ (NSDictionary *)makeStatusMessage:(Epos2PrinterStatusInfo *)status
{
    NSString *connection = @"";
    NSString *online = @"";
    NSString *coverOpen = @"";
    NSString *paper = @"";
    NSString *paperFeed = @"";
    NSString *panelSwitch = @"";
    NSString *drawer = @"";
    NSString *errorStatus = @"";
    NSString *autoRecoverErr = @"";
    NSString *adapter = @"";
    NSString *batteryLevel = @"";

    switch(status.connection){
        case EPOS2_TRUE:
            connection = @"CONNECT";
            break;
        case EPOS2_FALSE:
            connection = @"DISCONNECT";
            break;
        case EPOS2_UNKNOWN:
            connection = @"UNKNOWN";
            break;
        default:
            break;
    }

    switch(status.online){
        case EPOS2_TRUE:
            online = @"ONLINE";
            break;
        case EPOS2_FALSE:
            online = @"OFFLINE";
            break;
        case EPOS2_UNKNOWN:
            online = @"UNKNOWN";
            break;
        default:
            break;
    }

    switch(status.coverOpen){
        case EPOS2_TRUE:
            coverOpen = @"COVER_OPEN";
            break;
        case EPOS2_FALSE:
            coverOpen = @"COVER_CLOSE";
            break;
        case EPOS2_UNKNOWN:
            coverOpen = @"UNKNOWN";
            break;
        default:
            break;
    }

    switch(status.paper){
        case EPOS2_PAPER_OK:
            paper = @"PAPER_OK";
            break;
        case EPOS2_PAPER_NEAR_END:
            paper = @"PAPER_NEAR_END";
            break;
        case EPOS2_PAPER_EMPTY:
            paper = @"PAPER_EMPTY";
            break;
        case EPOS2_UNKNOWN:
            paper = @"UNKNOWN";
            break;
        default:
            break;
    }

    switch(status.paperFeed){
        case EPOS2_TRUE:
            paperFeed = @"PAPER_FEED";
            break;
        case EPOS2_FALSE:
            paperFeed = @"PAPER_STOP";
            break;
        case EPOS2_UNKNOWN:
            paperFeed = @"UNKNOWN";
            break;
        default:
            break;
    }

    switch(status.panelSwitch){
        case EPOS2_TRUE:
            panelSwitch = @"SWITCH_ON";
            break;
        case EPOS2_FALSE:
            panelSwitch = @"SWITCH_OFF";
            break;
        case EPOS2_UNKNOWN:
            panelSwitch = @"UNKNOWN";
            break;
        default:
            break;
    }

    switch(status.drawer){
        case EPOS2_DRAWER_HIGH:
            //This status depends on the drawer setting.
            drawer = @"DRAWER_HIGH(Drawer close)";
            break;
        case EPOS2_DRAWER_LOW:
            //This status depends on the drawer setting.
            drawer = @"DRAWER_LOW(Drawer open)";
            break;
        case EPOS2_UNKNOWN:
            drawer = @"UNKNOWN";
            break;
        default:
            break;
    }

    switch(status.errorStatus){
        case EPOS2_NO_ERR:
            errorStatus = @"NO_ERR";
            break;
        case EPOS2_MECHANICAL_ERR:
            errorStatus = @"MECHANICAL_ERR";
            break;
        case EPOS2_AUTOCUTTER_ERR:
            errorStatus = @"AUTOCUTTER_ERR";
            break;
        case EPOS2_UNRECOVER_ERR:
            errorStatus = @"UNRECOVER_ERR";
            break;
        case EPOS2_AUTORECOVER_ERR:
            errorStatus = @"AUTORECOVER_ERR";
            break;
        case EPOS2_UNKNOWN:
            errorStatus = @"UNKNOWN";
            break;
        default:
            break;
    }

    switch(status.autoRecoverError){
        case EPOS2_HEAD_OVERHEAT:
            autoRecoverErr = @"HEAD_OVERHEAT";
            break;
        case EPOS2_MOTOR_OVERHEAT:
            autoRecoverErr = @"MOTOR_OVERHEAT";
            break;
        case EPOS2_BATTERY_OVERHEAT:
            autoRecoverErr = @"BATTERY_OVERHEAT";
            break;
        case EPOS2_WRONG_PAPER:
            autoRecoverErr = @"WRONG_PAPER";
            break;
        case EPOS2_COVER_OPEN:
            autoRecoverErr = @"COVER_OPEN";
            break;
        case EPOS2_UNKNOWN:
            autoRecoverErr = @"UNKNOWN";
            break;
        default:
            break;
    }

    switch(status.adapter){
        case EPOS2_TRUE:
            adapter = @"AC ADAPTER CONNECT";
            break;
        case EPOS2_FALSE:
            adapter = @"AC ADAPTER DISCONNECT";
            break;
        case EPOS2_UNKNOWN:
            adapter = @"UNKNOWN";
            break;
        default:
            break;
    }

    switch(status.batteryLevel){
        case EPOS2_BATTERY_LEVEL_0:
           batteryLevel = @"BATTERY_LEVEL_0";
            break;
        case EPOS2_BATTERY_LEVEL_1:
           batteryLevel = @"BATTERY_LEVEL_1";
            break;
        case EPOS2_BATTERY_LEVEL_2:
           batteryLevel = @"BATTERY_LEVEL_2";
            break;
        case EPOS2_BATTERY_LEVEL_3:
           batteryLevel = @"BATTERY_LEVEL_3";
            break;
        case EPOS2_BATTERY_LEVEL_4:
           batteryLevel = @"BATTERY_LEVEL_4";
            break;
        case EPOS2_BATTERY_LEVEL_5:
           batteryLevel = @"BATTERY_LEVEL_5";
            break;
        case EPOS2_BATTERY_LEVEL_6:
           batteryLevel = @"BATTERY_LEVEL_6";
            break;
        case EPOS2_UNKNOWN:
           batteryLevel = @"UNKNOWN";
            break;
        default:
            break;
    }

    return @{
      @"connection": connection,
      @"online": online,
      @"coverOpen": coverOpen,
      @"paper": paper,
      @"paperFeed": paperFeed,
      @"panelSwitch": panelSwitch,
      @"drawer": drawer,
      @"errorStatus": errorStatus,
      @"autoRecoverErr": autoRecoverErr,
      @"adapter": adapter,
      @"batteryLevel": batteryLevel
    };
}

+ (NSDictionary *)getOfflineStatusMessage {
   return @{
      @"connection": @"DISCONNECT",
      @"online": @"OFFLINE",
      @"coverOpen": @"UNKNOWN",
      @"paper": @"UNKNOWN",
      @"paperFeed": @"UNKNOWN",
      @"panelSwitch": @"UNKNOWN",
      @"drawer": @"UNKNOWN",
      @"errorStatus": @"UNKNOWN",
      @"autoRecoverErr": @"UNKNOWN",
      @"adapter": @"UNKNOWN",
      @"batteryLevel": @"UNKNOWN"
    };
}



@end
