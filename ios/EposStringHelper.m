#import "EposStringHelper.h"

@implementation EposStringHelper: NSObject

+ (NSDictionary *)convertStatusInfoToDictionary:(Epos2PrinterStatusInfo *)info
{
   return @{
      @"connection": [@(info.connection) stringValue],
      @"online": [@(info.online) stringValue],
      @"coverOpen": [@(info.coverOpen) stringValue],
      @"paper": [@(info.paper) stringValue],
      @"paperFeed": [@(info.paperFeed) stringValue],
      @"panelSwitch": [@(info.panelSwitch) stringValue],
      @"drawer": [@(info.drawer) stringValue],
      @"errorStatus": [@(info.errorStatus) stringValue],
      @"autoRecoverError": [@(info.autoRecoverError) stringValue],
      @"buzzer": [@(info.buzzer) stringValue],
      @"adapter": [@(info.adapter) stringValue],
      @"batteryLevel": [@(info.batteryLevel) stringValue],
      @"removalWaiting": [@(info.removalWaiting) stringValue],
      @"paperTakenSensor": [@(info.paperTakenSensor) stringValue],
      @"unrecoverError": [@(info.unrecoverError) stringValue],
    };
}

+ (int)getPrinterSeries:(NSString*)name
{
    if (name == nil || [name isEqualToString:@""]) return EPOS2_TM_T88;

    if ([name hasPrefix:@"TM-m10"]) return EPOS2_TM_M10;
    if ([name hasPrefix:@"TM-m30"]) return EPOS2_TM_M30;
    if ([name hasPrefix:@"TM-m30III"]) return EPOS2_TM_M30III;
    if ([name hasPrefix:@"TM-m30II"]) return EPOS2_TM_M30II;
    if ([name hasPrefix:@"TM-m50II"]) return EPOS2_TM_M50II;
    if ([name hasPrefix:@"TM-m50"]) return EPOS2_TM_M50;
    if ([name hasPrefix:@"TM-P20II"]) return EPOS2_TM_P20II;
    if ([name hasPrefix:@"TM-P20"]) return EPOS2_TM_P20;
    if ([name hasPrefix:@"TM-P60II"]) return EPOS2_TM_P60II;
    if ([name hasPrefix:@"TM-P60"]) return EPOS2_TM_P60;
    if ([name hasPrefix:@"TM-P80II"]) return EPOS2_TM_P80II;
    if ([name hasPrefix:@"TM-P80"]) return EPOS2_TM_P80;
    if ([name hasPrefix:@"TM-T20"]) return EPOS2_TM_T20;
    if ([name hasPrefix:@"TM-T60"]) return EPOS2_TM_T60;
    if ([name hasPrefix:@"TM-T70"]) return EPOS2_TM_T70;
    if ([name hasPrefix:@"TM-T81"]) return EPOS2_TM_T81;
    if ([name hasPrefix:@"TM-T82"]) return EPOS2_TM_T82;
    if ([name hasPrefix:@"TM-T83III"]) return EPOS2_TM_T83III;
    if ([name hasPrefix:@"TM-T83"]) return EPOS2_TM_T83;
    if ([name hasPrefix:@"TM-T88VII"]) return EPOS2_TM_T88VII;
    if ([name hasPrefix:@"TM-T88"]) return EPOS2_TM_T88;
    if ([name hasPrefix:@"TM-T90"]) return EPOS2_TM_T90;
    if ([name hasPrefix:@"TM-T100"]) return EPOS2_TM_T100;
    if ([name hasPrefix:@"TM-U220"]) return EPOS2_TM_U220;
    if ([name hasPrefix:@"TM-U330"]) return EPOS2_TM_U330;
    if ([name hasPrefix:@"TM-L90LFC"]) return EPOS2_TM_L90LFC;
    if ([name hasPrefix:@"TM-L90"]) return EPOS2_TM_L90;
    if ([name hasPrefix:@"TM-L100"]) return EPOS2_TM_L100;
    if ([name hasPrefix:@"TM-H6000"]) return EPOS2_TM_H6000;

    return EPOS2_TM_T88;
}


@end
