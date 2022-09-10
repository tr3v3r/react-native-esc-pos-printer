#import "EposStringHelper.h"
#import "NSlogHelper.h"

@implementation EposStringHelper: NSObject

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
        case EPOS2_ERR_RECOVERY_FAILURE:
            errText = @"ERR_RECOVERY_FAILURE";
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
            result = @"ERR_INVALID_WINDOW";
            break;
        case EPOS2_CODE_CANCELED:
            result = @"CODE_CANCELED";
            break;
        case EPOS2_CODE_ERR_RECOGNITION:
            result = @"ERR_RECOGNITION";
            break;
        case EPOS2_CODE_ERR_READ:
            result = @"ERR_READ";
            break;
        case EPOS2_CODE_ERR_PAPER_JAM:
            result = @"ERR_PAPER_JAM";
            break;
        case EPOS2_CODE_ERR_PAPER_PULLED_OUT:
            result = @"ERR_PAPER_PULLED_OUT";
            break;
        case EPOS2_CODE_ERR_CANCEL_FAILED:
            result = @"ERR_CANCEL_FAILED";
            break;
        case EPOS2_CODE_ERR_PAPER_TYPE:
            result = @"ERR_PAPER_TYPE";
            break;
        case EPOS2_CODE_ERR_WAIT_INSERTION:
            result = @"ERR_WAIT_INSERTION";
            break;
        case EPOS2_CODE_ERR_ILLEGAL:
            result = @"ERR_ILLEGAL";
            break;
        case EPOS2_CODE_ERR_INSERTED:
            result = @"ERR_INSERTED";
            break;
        case EPOS2_CODE_ERR_WAIT_REMOVAL:
            result = @"ERR_WAIT_REMOVAL";
            break;
        case EPOS2_CODE_ERR_DEVICE_BUSY:
            result = @"ERR_DEVICE_BUSY";
            break;
        case EPOS2_CODE_ERR_IN_USE:
            result = @"ERR_IN_USE";
            break;
        case EPOS2_CODE_ERR_CONNECT:
            result = @"ERR_CONNECT";
            break;
        case EPOS2_CODE_ERR_DISCONNECT:
            result = @"ERR_DISCONNECT";
            break;
        case EPOS2_CODE_ERR_MEMORY:
            result = @"ERR_MEMORY";
            break;
        case EPOS2_CODE_ERR_PROCESSING:
            result = @"ERR_PROCESSING";
            break;
        case EPOS2_CODE_ERR_PARAM:
            result = @"ERR_PARAM";
            break;
        case EPOS2_CODE_RETRY:
            result = @"RETRY";
            break;
        case EPOS2_CODE_ERR_DIFFERENT_MODEL:
            result = @"ERR_DIFFERENT_MODEL";
            break;
        case EPOS2_CODE_ERR_DIFFERENT_VERSION:
            result = @"ERR_DIFFERENT_VERSION";
            break;
        case EPOS2_CODE_ERR_DATA_CORRUPTED:
            result = @"ERR_DATA_CORRUPTED";
            break;
        default:
            result = [NSString stringWithFormat:@"%d", resultCode];
            break;
    }

    return result;
}

+ (NSString *)makeStatusMonitorMessage:(int)status
{
    
    NSMutableString *stringStatus = [[NSMutableString alloc] initWithString:@""];
    if(stringStatus == nil){
        return nil;
    }
    
    switch (status) {
        case EPOS2_EVENT_ONLINE:
            [stringStatus appendString:@"ONLINE"];
            break;
        case EPOS2_EVENT_OFFLINE:
            [stringStatus appendString:@"OFFLINE"];
            break;
        case EPOS2_EVENT_POWER_OFF:
            [stringStatus appendString:@"POWER_OFF"];
            break;
        case EPOS2_EVENT_COVER_CLOSE:
            [stringStatus appendString:@"COVER_CLOSE"];
            break;
        case EPOS2_EVENT_COVER_OPEN:
            [stringStatus appendString:@"COVER_OPEN"];
            break;
        case EPOS2_EVENT_PAPER_OK:
            [stringStatus appendString:@"PAPER_OK"];
            break;
        case EPOS2_EVENT_PAPER_NEAR_END:
            [stringStatus appendString:@"PAPER_NEAR_END"];
            break;
        case EPOS2_EVENT_PAPER_EMPTY:
            [stringStatus appendString:@"PAPER_EMPTY"];
            break;
        case EPOS2_EVENT_DRAWER_HIGH:
            //This status depends on the drawer setting.
            [stringStatus appendString:@"DRAWER_HIGH(Drawer close)"];
            break;
        case EPOS2_EVENT_DRAWER_LOW:
            //This status depends on the drawer setting.
            [stringStatus appendString:@"DRAWER_LOW(Drawer open)"];
            break;
        case EPOS2_EVENT_BATTERY_ENOUGH:
            [stringStatus appendString:@"BATTERY_ENOUGH"];
            break;
        case EPOS2_EVENT_BATTERY_EMPTY:
            [stringStatus appendString:@"BATTERY_EMPTY"];
            break;
        case EPOS2_EVENT_REMOVAL_WAIT_PAPER:
            [stringStatus appendString:@"WAITING_FOR_PAPER_REMOVAL"];
            break;
        case EPOS2_EVENT_REMOVAL_WAIT_NONE:
            [stringStatus appendString:@"NOT_WAITING_FOR_PAPER_REMOVAL"];
            break;
        case EPOS2_EVENT_AUTO_RECOVER_ERROR:
            [stringStatus appendString:@"AUTO_RECOVER_ERROR"];
            break;
        case EPOS2_EVENT_AUTO_RECOVER_OK:
            [stringStatus appendString:@"AUTO_RECOVER_OK"];
            break;
        case EPOS2_EVENT_UNRECOVERABLE_ERROR:
            [stringStatus appendString:@"UNRECOVERABLE_ERROR"];
            break;
        default:
            break;
    }
    
    [stringStatus appendString:@"\n"];
    return stringStatus;
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

+(NSString *)convertPrintSpeedEnum2String:(int)speedEnum {
    NSString *speedStr = @"invalid";
    switch (speedEnum) {
        case EPOS2_PRINTER_SETTING_PRINTSPEED_1:
            speedStr = NSLocalizedString(@"printspeed_1", @"");
            break;
        case EPOS2_PRINTER_SETTING_PRINTSPEED_2:
            speedStr = NSLocalizedString(@"printspeed_2", @"");
            break;
        case EPOS2_PRINTER_SETTING_PRINTSPEED_3:
            speedStr = NSLocalizedString(@"printspeed_3", @"");
            break;
        case EPOS2_PRINTER_SETTING_PRINTSPEED_4:
            speedStr = NSLocalizedString(@"printspeed_4", @"");
            break;
        case EPOS2_PRINTER_SETTING_PRINTSPEED_5:
            speedStr = NSLocalizedString(@"printspeed_5", @"");
            break;
        case EPOS2_PRINTER_SETTING_PRINTSPEED_6:
            speedStr = NSLocalizedString(@"printspeed_6", @"");
            break;
        case EPOS2_PRINTER_SETTING_PRINTSPEED_7:
            speedStr = NSLocalizedString(@"printspeed_7", @"");
            break;
        case EPOS2_PRINTER_SETTING_PRINTSPEED_8:
            speedStr = NSLocalizedString(@"printspeed_8", @"");
            break;
        case EPOS2_PRINTER_SETTING_PRINTSPEED_9:
            speedStr = NSLocalizedString(@"printspeed_9", @"");
            break;
        case EPOS2_PRINTER_SETTING_PRINTSPEED_10:
            speedStr = NSLocalizedString(@"printspeed_10", @"");
            break;
        case EPOS2_PRINTER_SETTING_PRINTSPEED_11:
            speedStr = NSLocalizedString(@"printspeed_11", @"");
            break;
        case EPOS2_PRINTER_SETTING_PRINTSPEED_12:
            speedStr = NSLocalizedString(@"printspeed_12", @"");
            break;
        case EPOS2_PRINTER_SETTING_PRINTSPEED_13:
            speedStr = NSLocalizedString(@"printspeed_13", @"");
            break;
        case EPOS2_PRINTER_SETTING_PRINTSPEED_14:
            speedStr = NSLocalizedString(@"printspeed_14", @"");
            break;
        case EPOS2_PRINTER_SETTING_PRINTSPEED_15:
            speedStr = NSLocalizedString(@"printspeed_15", @"");
            break;
        case EPOS2_PRINTER_SETTING_PRINTSPEED_16:
            speedStr = NSLocalizedString(@"printspeed_16", @"");
            break;
        case EPOS2_PRINTER_SETTING_PRINTSPEED_17:
            speedStr = NSLocalizedString(@"printspeed_17", @"");
            break;
        default:
            break;
    }
    
    return speedStr;
}

+ (NSString *)convertPrintDensityEnum2String:(int)dencityEnum {
    NSString *deinsityStr = @"invalid";
    switch (dencityEnum) {
        case EPOS2_PRINTER_SETTING_PRINTDENSITY_DIP:
            deinsityStr = NSLocalizedString(@"printdensity_DIP", @"");
            break;
        case EPOS2_PRINTER_SETTING_PRINTDENSITY_70:
            deinsityStr = NSLocalizedString(@"printdensity_70", @"");
            break;
        case EPOS2_PRINTER_SETTING_PRINTDENSITY_75:
            deinsityStr = NSLocalizedString(@"printdensity_75", @"");
            break;
        case EPOS2_PRINTER_SETTING_PRINTDENSITY_80:
            deinsityStr = NSLocalizedString(@"printdensity_80", @"");
            break;
        case EPOS2_PRINTER_SETTING_PRINTDENSITY_85:
            deinsityStr = NSLocalizedString(@"printdensity_85", @"");
            break;
        case EPOS2_PRINTER_SETTING_PRINTDENSITY_90:
            deinsityStr = NSLocalizedString(@"printdensity_90", @"");
            break;
        case EPOS2_PRINTER_SETTING_PRINTDENSITY_95:
            deinsityStr = NSLocalizedString(@"printdensity_95", @"");
            break;
        case EPOS2_PRINTER_SETTING_PRINTDENSITY_100:
            deinsityStr = NSLocalizedString(@"printdensity_100", @"");
            break;
        case EPOS2_PRINTER_SETTING_PRINTDENSITY_105:
            deinsityStr = NSLocalizedString(@"printdensity_105", @"");
            break;
        case EPOS2_PRINTER_SETTING_PRINTDENSITY_110:
            deinsityStr = NSLocalizedString(@"printdensity_110", @"");
            break;
        case EPOS2_PRINTER_SETTING_PRINTDENSITY_115:
            deinsityStr = NSLocalizedString(@"printdensity_115", @"");
            break;
        case EPOS2_PRINTER_SETTING_PRINTDENSITY_120:
            deinsityStr = NSLocalizedString(@"printdensity_120", @"");
            break;
        case EPOS2_PRINTER_SETTING_PRINTDENSITY_125:
            deinsityStr = NSLocalizedString(@"printdensity_125", @"");
            break;
        case EPOS2_PRINTER_SETTING_PRINTDENSITY_130:
            deinsityStr = NSLocalizedString(@"printdensity_130", @"");
            break;
        default:
            break;
    }
    
    return deinsityStr;
}

+ (NSString *)convertPaperWidthEnum2String:(int)paperWidthEnum {
    NSString *paperWidthStr = @"invalid";
    switch (paperWidthEnum) {
        case EPOS2_PRINTER_SETTING_PAPERWIDTH_58_0:
            paperWidthStr = NSLocalizedString(@"paperwidth_58", @"");
            break;
        case EPOS2_PRINTER_SETTING_PAPERWIDTH_60_0:
            paperWidthStr = NSLocalizedString(@"paperwidth_60", @"");
            break;
        case EPOS2_PRINTER_SETTING_PAPERWIDTH_70_0:
            paperWidthStr = NSLocalizedString(@"paperwidth_70", @"");
            break;
        case EPOS2_PRINTER_SETTING_PAPERWIDTH_76_0:
            paperWidthStr = NSLocalizedString(@"paperwidth_76", @"");
            break;
        case EPOS2_PRINTER_SETTING_PAPERWIDTH_80_0:
            paperWidthStr = NSLocalizedString(@"paperwidth_80", @"");
            break;
        default:
            break;
    }
    
    return paperWidthStr;
}

+ (NSString *)convertEpos2PrinterSettingTypeEnum2String:(int)printerSettingTypeEnum {
    
    NSString *printerSettingTypeStr = @"invalid";
    switch (printerSettingTypeEnum) {
        case EPOS2_PRINTER_SETTING_PAPERWIDTH:
            printerSettingTypeStr = @"PRINTER_SETTING_PAPERWIDTH";
            break;
        case EPOS2_PRINTER_SETTING_PRINTDENSITY:
            printerSettingTypeStr = @"PRINTER_SETTING_PRINTDENSITY";
            break;
        case EPOS2_PRINTER_SETTING_PRINTSPEED:
            printerSettingTypeStr = @"PRINTER_SETTING_PRINTSPEED";
            break;
        default:
            break;
    }
    
    return printerSettingTypeStr;
    
}

+ (int)getPrinterSeries:(NSString*)name
{
    
    if (name == nil || [name isEqualToString:@""]) return EPOS2_TM_T88;

    if ([name hasPrefix:@"TM-T88VII"]) return EPOS2_TM_T88VII;
    if ([name hasPrefix:@"TM-m30II"]) return EPOS2_TM_M30II;
    if ([name hasPrefix:@"TM-m30"]) return EPOS2_TM_M30;
    if ([name hasPrefix:@"TM-L90LFC"]) return EPOS2_TM_L90LFC;
    if ([name hasPrefix:@"TM-L90"]) return EPOS2_TM_L90;
    if ([name hasPrefix:@"TM-m50"]) return EPOS2_TM_M50;
    if ([name hasPrefix:@"TM-L100"]) return EPOS2_TM_L100;
    if ([name hasPrefix:@"TM-m10"]) return EPOS2_TM_M10;
    if ([name hasPrefix:@"TM-P20"]) return EPOS2_TM_P20;
    if ([name hasPrefix:@"TM-P60II"]) return EPOS2_TM_P60II;
    if ([name hasPrefix:@"TM-P60"]) return EPOS2_TM_P60;
    if ([name hasPrefix:@"TM-P80"]) return EPOS2_TM_P80;
    if ([name hasPrefix:@"TM-T20"]) return EPOS2_TM_T20;
    if ([name hasPrefix:@"TM-T60"]) return EPOS2_TM_T60;
    if ([name hasPrefix:@"TM-T70"]) return EPOS2_TM_T70;
    if ([name hasPrefix:@"TM-T81"]) return EPOS2_TM_T81;
    if ([name hasPrefix:@"TM-T82"]) return EPOS2_TM_T82;
    if ([name hasPrefix:@"TM-T83III"]) return EPOS2_TM_T83III;
    if ([name hasPrefix:@"TM-T83"]) return EPOS2_TM_T83;
    if ([name hasPrefix:@"TM-T88"]) return EPOS2_TM_T88;
    if ([name hasPrefix:@"TM-T90KP"]) return EPOS2_TM_T90KP;
    if ([name hasPrefix:@"TM-T90"]) return EPOS2_TM_T90;
    if ([name hasPrefix:@"TM-U220"]) return EPOS2_TM_U220;
    if ([name hasPrefix:@"TM-U330"]) return EPOS2_TM_U330;
    if ([name hasPrefix:@"TM-H6000"]) return EPOS2_TM_H6000;
    if ([name hasPrefix:@"TM-T100"]) return EPOS2_TM_T100;
    if ([name hasPrefix:@"TS-100"]) return EPOS2_TS_100;
    if ([name hasPrefix:@"TM_T88VII"]) return EPOS2_TM_T88VII;
    if ([name hasPrefix:@"TM_L90LFC"]) return EPOS2_TM_L90LFC;
    if ([name hasPrefix:@"TM_L100"]) return EPOS2_TM_L100;
    
    return EPOS2_TM_T88;
}


@end
