package com.reactnativeescposprinter;

import static com.reactnativeescposprinter.ePOSCmd.POS_SUCCESS;

import android.content.Context;

import androidx.annotation.NonNull;

import com.epson.epos2.Epos2CallbackCode;
import com.epson.epos2.Epos2Exception;
import com.epson.epos2.printer.Printer;
import com.epson.epos2.printer.PrinterStatusInfo;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.Locale;

public class EposStringHelper {

    public static JSONObject makeStatusMessage(PrinterStatusInfo statusInfo) {

        String connection = "";
        String online = "";
        String coverOpen = "";
        String paper = "";
        String paperFeed = "";
        String panelSwitch = "";
        String drawer = "";
        String errorStatus = "";
        String autoRecoverErr = "";
        String adapter = "";
        String batteryLevel = "";
        String paperWait = "";


        switch (statusInfo.getConnection()) {
            case Printer.TRUE:
                connection = "CONNECT";
                break;
            case Printer.FALSE:
                connection = "DISCONNECT";
                break;
            case Printer.UNKNOWN:
                connection = "UNKNOWN";
                break;
            default:
                break;
        }

        switch (statusInfo.getOnline()) {
            case Printer.TRUE:
                online = "ONLINE";
                break;
            case Printer.FALSE:
                online = "OFFLINE";
                break;
            case Printer.UNKNOWN:
                online = "UNKNOWN";
                break;
            default:
                break;
        }

        switch (statusInfo.getCoverOpen()) {
            case Printer.TRUE:
                coverOpen = "COVER_OPEN";
                break;
            case Printer.FALSE:
                coverOpen = "COVER_CLOSE";
                break;
            case Printer.UNKNOWN:
                coverOpen = "UNKNOWN";
                break;
            default:
                break;
        }

        switch (statusInfo.getPaper()) {
            case Printer.PAPER_OK:
                paper = "PAPER_OK";
                break;
            case Printer.PAPER_NEAR_END:
                paper = "PAPER_NEAR_END";
                break;
            case Printer.PAPER_EMPTY:
                paper = "PAPER_EMPTY";
                break;
            case Printer.UNKNOWN:
                paper = "UNKNOWN";
                break;
            default:
                break;
        }

        switch (statusInfo.getPaperFeed()) {
            case Printer.TRUE:
                paperFeed = "PAPER_FEED";
                break;
            case Printer.FALSE:
                paperFeed = "PAPER_STOP";
                break;
            case Printer.UNKNOWN:
                paperFeed = "UNKNOWN";
                break;
            default:
                break;
        }

        switch (statusInfo.getPanelSwitch()) {
            case Printer.TRUE:
                panelSwitch = "SWITCH_ON";
                break;
            case Printer.FALSE:
                panelSwitch = "SWITCH_OFF";
                break;
            case Printer.UNKNOWN:
                panelSwitch = "UNKNOWN";
                break;
            default:
                break;
        }

        switch (statusInfo.getDrawer()) {
            case Printer.DRAWER_HIGH:
                //This status depends on the drawer setting.
                drawer = "DRAWER_HIGH(Drawer close)";
                break;
            case Printer.DRAWER_LOW:
                //This status depends on the drawer setting.
                drawer = "DRAWER_LOW(Drawer open)";
                break;
            case Printer.UNKNOWN:
                drawer = "UNKNOWN";
                break;
            default:
                break;
        }

        switch (statusInfo.getErrorStatus()) {
            case Printer.NO_ERR:
                errorStatus = "NO_ERR";
                break;
            case Printer.MECHANICAL_ERR:
                errorStatus = "MECHANICAL_ERR";
                break;
            case Printer.AUTOCUTTER_ERR:
                errorStatus = "AUTOCUTTER_ERR";
                break;
            case Printer.UNRECOVER_ERR:
                errorStatus = "UNRECOVER_ERR";
                break;
            case Printer.AUTORECOVER_ERR:
                errorStatus = "AUTOCUTTER_ERR";
                break;
            case Printer.UNKNOWN:
                errorStatus = "UNKNOWN";
                break;
            default:
                break;
        }

        switch (statusInfo.getAutoRecoverError()) {
            case Printer.HEAD_OVERHEAT:
                autoRecoverErr = "HEAD_OVERHEAT";
                break;
            case Printer.MOTOR_OVERHEAT:
                autoRecoverErr = "MOTOR_OVERHEAT";
                break;
            case Printer.BATTERY_OVERHEAT:
                autoRecoverErr = "BATTERY_OVERHEAT";
                break;
            case Printer.WRONG_PAPER:
                autoRecoverErr = "WRONG_PAPER";
                break;
            case Printer.COVER_OPEN:
                autoRecoverErr = "COVER_OPEN";
                break;
            case Printer.UNKNOWN:
                autoRecoverErr = "UNKNOWN";
                break;
            default:
                break;
        }

        switch (statusInfo.getAdapter()) {
            case Printer.TRUE:
                adapter = "AC ADAPTER CONNECT";
                break;
            case Printer.FALSE:
                adapter = "AC ADAPTER DISCONNECT";
                break;
            case Printer.UNKNOWN:
                adapter = "UNKNOWN";
                break;
            default:
                break;
        }

        switch (statusInfo.getBatteryLevel()) {
            case Printer.BATTERY_LEVEL_0:
                batteryLevel = "BATTERY_LEVEL_0";
                break;
            case Printer.BATTERY_LEVEL_1:
                batteryLevel = "BATTERY_LEVEL_1";
                break;
            case Printer.BATTERY_LEVEL_2:
                batteryLevel = "BATTERY_LEVEL_2";
                break;
            case Printer.BATTERY_LEVEL_3:
                batteryLevel = "BATTERY_LEVEL_3";
                break;
            case Printer.BATTERY_LEVEL_4:
                batteryLevel = "BATTERY_LEVEL_4";
                break;
            case Printer.BATTERY_LEVEL_5:
                batteryLevel = "BATTERY_LEVEL_5";
                break;
            case Printer.BATTERY_LEVEL_6:
                batteryLevel = "BATTERY_LEVEL_6";
                break;
            case Printer.UNKNOWN:
                batteryLevel = "UNKNOWN";
                break;
            default:
                break;
        }

        switch (statusInfo.getRemovalWaiting()) {
            case Printer.EVENT_REMOVAL_WAIT_PAPER:
                paperWait = "WAITING_FOR_PAPER_REMOVAL";
                break;
            case Printer.EVENT_REMOVAL_WAIT_NONE:
                paperWait = "NOT_WAITING_FOR_PAPER_REMOVAL";
                break;
            case Printer.UNKNOWN:
                paperWait = "UNKNOWN";
                break;
            default:
                break;
        }

        JSONObject jsonStatus = new JSONObject();
        try {
            jsonStatus.put("connection", connection);
            jsonStatus.put("online",online);
            jsonStatus.put("coverOpen",coverOpen);
            jsonStatus.put("paper",paper);
            jsonStatus.put("paperFeed",paperFeed);
            jsonStatus.put("panelSwitch",panelSwitch);
            jsonStatus.put("drawer",drawer);
            jsonStatus.put("errorStatus",errorStatus);
            jsonStatus.put("autoRecoverErr",autoRecoverErr);
            jsonStatus.put("adapter",adapter);
            jsonStatus.put("batteryLevel",batteryLevel);
            jsonStatus.put("paperWait",paperWait);

        } catch (JSONException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return jsonStatus;

    }

    public static String convertPrintSpeedEnum2String(int speedEnum, @NonNull Context context) {

        String speedStr = "invalid";
        switch (speedEnum) {
            case Printer.SETTING_PRINTSPEED_1:
                speedStr = "1";
                break;
            case Printer.SETTING_PRINTSPEED_2:
                speedStr = "2";
                break;
            case Printer.SETTING_PRINTSPEED_3:
                speedStr = "3";
                break;
            case Printer.SETTING_PRINTSPEED_4:
                speedStr = "4";
                break;
            case Printer.SETTING_PRINTSPEED_5:
                speedStr = "5";
                break;
            case Printer.SETTING_PRINTSPEED_6:
                speedStr = "6";
                break;
            case Printer.SETTING_PRINTSPEED_7:
                speedStr = "7";
                break;
            case Printer.SETTING_PRINTSPEED_8:
                speedStr = "8";
                break;
            case Printer.SETTING_PRINTSPEED_9:
                speedStr = "9";
                break;
            case Printer.SETTING_PRINTSPEED_10:
                speedStr = "10";
                break;
            case Printer.SETTING_PRINTSPEED_11:
                speedStr = "11";
                break;
            case Printer.SETTING_PRINTSPEED_12:
                speedStr = "12";
                break;
            case Printer.SETTING_PRINTSPEED_13:
                speedStr = "13";
                break;
            case Printer.SETTING_PRINTSPEED_14:
                speedStr = "14";
                break;
            case Printer.SETTING_PRINTSPEED_15:
                speedStr = "15";
                break;
            case Printer.SETTING_PRINTSPEED_16:
                speedStr = "16";
                break;
            case Printer.SETTING_PRINTSPEED_17:
                speedStr = "17";
                break;
            default:
                break;
        }

        return speedStr;

    }

     public static String convertPaperWidthEnum2String(int paperWidthEnum, @NonNull Context context) {

         String paperWidthStr = "invalid";
         switch (paperWidthEnum) {
             case Printer.SETTING_PAPERWIDTH_58_0:
                 paperWidthStr = "58mm";
                 break;
             case Printer.SETTING_PAPERWIDTH_60_0:
                 paperWidthStr = "60mm";
                 break;
             case Printer.SETTING_PAPERWIDTH_70_0:
                 paperWidthStr = "70mm";
                 break;
             case Printer.SETTING_PAPERWIDTH_76_0:
                 paperWidthStr = "76mm";
                 break;
             case Printer.SETTING_PAPERWIDTH_80_0:
                 paperWidthStr = "80mm";
                 break;
             default:
                 break;
         }

         return paperWidthStr;
     }

    public static String convertPrintDensityEnum2String(int densityEnum, @NonNull Context context) {
        String deinsityStr = "invalid";
        switch (densityEnum) {
            case Printer.SETTING_PRINTDENSITY_DIP:
                deinsityStr = "DIP";
                break;
            case Printer.SETTING_PRINTDENSITY_70:
                deinsityStr = "70%";
                break;
            case Printer.SETTING_PRINTDENSITY_75:
                deinsityStr = "75%";
                break;
            case Printer.SETTING_PRINTDENSITY_80:
                deinsityStr = "80%";
                break;
            case Printer.SETTING_PRINTDENSITY_85:
                deinsityStr = "85%";
                break;
            case Printer.SETTING_PRINTDENSITY_90:
                deinsityStr = "90%";
                break;
            case Printer.SETTING_PRINTDENSITY_95:
                deinsityStr = "95%";
                break;
            case Printer.SETTING_PRINTDENSITY_100:
                deinsityStr = "100%";
                break;
            case Printer.SETTING_PRINTDENSITY_105:
                deinsityStr = "105%";
                break;
            case Printer.SETTING_PRINTDENSITY_110:
                deinsityStr = "110%";
                break;
            case Printer.SETTING_PRINTDENSITY_115:
                deinsityStr = "115%";
                break;
            case Printer.SETTING_PRINTDENSITY_120:
                deinsityStr = "120%";
                break;
            case Printer.SETTING_PRINTDENSITY_125:
                deinsityStr = "125%";
                break;
            case Printer.SETTING_PRINTDENSITY_130:
                deinsityStr = "130%";
                break;
            default:
                break;
        }

        return deinsityStr;
    }


     public static String convertEpos2PrinterSettingTypeEnum2String(int printerSettingTypeEnum) {

         String printerSettingTypeStr = "invalid";
         switch (printerSettingTypeEnum) {
             case Printer.SETTING_PAPERWIDTH:
                 printerSettingTypeStr = "SETTING_PAPERWIDTH";
                 break;
             case Printer.SETTING_PRINTDENSITY:
                 printerSettingTypeStr = "SETTING_PRINTDENSITY";
                 break;
             case Printer.SETTING_PRINTSPEED:
                 printerSettingTypeStr = "SETTING_PRINTSPEED";
                 break;
             default:
                 break;
         }

         return printerSettingTypeStr;

     }


     public static String makeStatusMonitorMessage(int type) {
         String msg = "";

         switch (type) {
             case Printer.EVENT_ONLINE:
                 msg += "ONLINE";
                 break;
             case Printer.EVENT_OFFLINE:
                 msg += "OFFLINE";
                 break;
             case Printer.EVENT_POWER_OFF:
                 msg += "POWER_OFF";
                 break;
             case Printer.EVENT_COVER_CLOSE:
                 msg += "COVER_CLOSE";
                 break;
             case Printer.EVENT_COVER_OPEN:
                 msg += "COVER_OPEN";
                 break;
             case Printer.EVENT_PAPER_OK:
                 msg += "PAPER_OK";
                 break;
             case Printer.EVENT_PAPER_NEAR_END:
                 msg += "PAPER_NEAR_END";
                 break;
             case Printer.EVENT_PAPER_EMPTY:
                 msg += "PAPER_EMPTY";
                 break;
             case Printer.EVENT_DRAWER_HIGH:
                 //This status depends on the drawer setting.
                 msg += "DRAWER_HIGH(Drawer close)";
                 break;
             case Printer.EVENT_DRAWER_LOW:
                 //This status depends on the drawer setting.
                 msg += "DRAWER_LOW(Drawer open)";
                 break;
             case Printer.EVENT_BATTERY_ENOUGH:
                 msg += "BATTERY_ENOUGH";
                 break;
             case Printer.EVENT_BATTERY_EMPTY:
                 msg += "BATTERY_EMPTY";
                 break;
             case Printer.EVENT_REMOVAL_WAIT_PAPER:
                 msg += "WAITING_FOR_PAPER_REMOVAL";
                 break;
             case Printer.EVENT_REMOVAL_WAIT_NONE:
                 msg += "NOT_WAITING_FOR_PAPER_REMOVAL";
                 break;
             case Printer.EVENT_AUTO_RECOVER_ERROR:
                 msg += "AUTO_RECOVER_ERROR";
                 break;
             case Printer.EVENT_AUTO_RECOVER_OK:
                 msg += "AUTO_RECOVER_OK";
                 break;
             case Printer.EVENT_UNRECOVERABLE_ERROR:
                 msg += "UNRECOVERABLE_ERROR";
                 break;
             default:
                 break;
         }
         msg += "\n";
         return msg;
     }

    public static String getEposExceptionText(int state) {
        String return_text = "";
        switch (state) {
            case POS_SUCCESS:
                return_text = "SUCCESS";
                break;
            case    Epos2Exception.ERR_PARAM:
                return_text = "ERR_PARAM";
                break;
            case    Epos2Exception.ERR_CONNECT:
                return_text = "ERR_CONNECT";
                break;
            case    Epos2Exception.ERR_TIMEOUT:
                return_text = "ERR_TIMEOUT";
                break;
            case    Epos2Exception.ERR_MEMORY:
                return_text = "ERR_MEMORY";
                break;
            case    Epos2Exception.ERR_ILLEGAL:
                return_text = "ERR_ILLEGAL";
                break;
            case    Epos2Exception.ERR_PROCESSING:
                return_text = "ERR_PROCESSING";
                break;
            case    Epos2Exception.ERR_NOT_FOUND:
                return_text = "ERR_NOT_FOUND";
                break;
            case    Epos2Exception.ERR_IN_USE:
                return_text = "ERR_IN_USE";
                break;
            case    Epos2Exception.ERR_TYPE_INVALID:
                return_text = "ERR_TYPE_INVALID";
                break;
            case    Epos2Exception.ERR_DISCONNECT:
                return_text = "ERR_DISCONNECT";
                break;
            case    Epos2Exception.ERR_ALREADY_OPENED:
                return_text = "ERR_ALREADY_OPENED";
                break;
            case    Epos2Exception.ERR_ALREADY_USED:
                return_text = "ERR_ALREADY_USED";
                break;
            case    Epos2Exception.ERR_BOX_COUNT_OVER:
                return_text = "ERR_BOX_COUNT_OVER";
                break;
            case    Epos2Exception.ERR_BOX_CLIENT_OVER:
                return_text = "ERR_BOX_CLIENT_OVER";
                break;
            case    Epos2Exception.ERR_UNSUPPORTED:
                return_text = "ERR_UNSUPPORTED";
                break;
            case    Epos2Exception.ERR_FAILURE:
                return_text = "ERR_FAILURE";
                break;
            default:
                return_text = String.format(Locale.ENGLISH, "%d", state);
                break;
        }
        return return_text;
    }

    public static String getEposResultText(int state) {
        String return_text = "";
        switch (state) {
            case Epos2CallbackCode.CODE_SUCCESS:
                return_text = "PRINT_SUCCESS";
                break;
            case Epos2CallbackCode.CODE_PRINTING:
                return_text = "PRINTING";
                break;
            case Epos2CallbackCode.CODE_ERR_AUTORECOVER:
                return_text = "ERR_AUTORECOVER";
                break;
            case Epos2CallbackCode.CODE_ERR_COVER_OPEN:
                return_text = "ERR_COVER_OPEN";
                break;
            case Epos2CallbackCode.CODE_ERR_CUTTER:
                return_text = "ERR_CUTTER";
                break;
            case Epos2CallbackCode.CODE_ERR_MECHANICAL:
                return_text = "ERR_MECHANICAL";
                break;
            case Epos2CallbackCode.CODE_ERR_EMPTY:
                return_text = "ERR_EMPTY";
                break;
            case Epos2CallbackCode.CODE_ERR_UNRECOVERABLE:
                return_text = "ERR_UNRECOVERABLE";
                break;
            case Epos2CallbackCode.CODE_ERR_FAILURE:
                return_text = "ERR_FAILURE";
                break;
            case Epos2CallbackCode.CODE_ERR_NOT_FOUND:
                return_text = "ERR_NOT_FOUND";
                break;
            case Epos2CallbackCode.CODE_ERR_SYSTEM:
                return_text = "ERR_SYSTEM";
                break;
            case Epos2CallbackCode.CODE_ERR_PORT:
                return_text = "ERR_PORT";
                break;
            case Epos2CallbackCode.CODE_ERR_TIMEOUT:
                return_text = "ERR_TIMEOUT";
                break;
            case Epos2CallbackCode.CODE_ERR_JOB_NOT_FOUND:
                return_text = "ERR_JOB_NOT_FOUND";
                break;
            case Epos2CallbackCode.CODE_ERR_SPOOLER:
                return_text = "ERR_SPOOLER";
                break;
            case Epos2CallbackCode.CODE_ERR_BATTERY_LOW:
                return_text = "ERR_BATTERY_LOW";
                break;
            case Epos2CallbackCode.CODE_ERR_TOO_MANY_REQUESTS:
                return_text = "ERR_TOO_MANY_REQUESTS";
                break;
            case Epos2CallbackCode.CODE_ERR_REQUEST_ENTITY_TOO_LARGE:
                return_text = "ERR_REQUEST_ENTITY_TOO_LARGE";
                break;
            case Epos2CallbackCode.CODE_CANCELED:
                return_text = "CODE_CANCELED";
                break;
            case Epos2CallbackCode.CODE_ERR_NO_MICR_DATA:
                return_text = "ERR_NO_MICR_DATA";
                break;
            case Epos2CallbackCode.CODE_ERR_ILLEGAL_LENGTH:
                return_text = "ERR_ILLEGAL_LENGTH";
                break;
            case Epos2CallbackCode.CODE_ERR_NO_MAGNETIC_DATA:
                return_text = "ERR_NO_MAGNETIC_DATA";
                break;
            case Epos2CallbackCode.CODE_ERR_RECOGNITION:
                return_text = "ERR_RECOGNITION";
                break;
            case Epos2CallbackCode.CODE_ERR_READ:
                return_text = "ERR_READ";
                break;
            case Epos2CallbackCode.CODE_ERR_NOISE_DETECTED:
                return_text = "ERR_NOISE_DETECTED";
                break;
            case Epos2CallbackCode.CODE_ERR_PAPER_JAM:
                return_text = "ERR_PAPER_JAM";
                break;
            case Epos2CallbackCode.CODE_ERR_PAPER_PULLED_OUT:
                return_text = "ERR_PAPER_PULLED_OUT";
                break;
            case Epos2CallbackCode.CODE_ERR_CANCEL_FAILED:
                return_text = "ERR_CANCEL_FAILED";
                break;
            case Epos2CallbackCode.CODE_ERR_PAPER_TYPE:
                return_text = "ERR_PAPER_TYPE";
                break;
            case Epos2CallbackCode.CODE_ERR_WAIT_INSERTION:
                return_text = "ERR_WAIT_INSERTION";
                break;
            case Epos2CallbackCode.CODE_ERR_ILLEGAL:
                return_text = "ERR_ILLEGAL";
                break;
            case Epos2CallbackCode.CODE_ERR_INSERTED:
                return_text = "ERR_INSERTED";
                break;
            case Epos2CallbackCode.CODE_ERR_WAIT_REMOVAL:
                return_text = "ERR_WAIT_REMOVAL";
                break;
            case Epos2CallbackCode.CODE_ERR_DEVICE_BUSY:
                return_text = "ERR_DEVICE_BUSY";
                break;
            case Epos2CallbackCode.CODE_ERR_IN_USE:
                return_text = "ERR_IN_USE";
                break;
            case Epos2CallbackCode.CODE_ERR_CONNECT:
                return_text = "ERR_CONNECT";
                break;
            case Epos2CallbackCode.CODE_ERR_DISCONNECT:
                return_text = "ERR_DISCONNECT";
                break;
            case Epos2CallbackCode.CODE_ERR_MEMORY:
                return_text = "ERR_MEMORY";
                break;
            case Epos2CallbackCode.CODE_ERR_PROCESSING:
                return_text = "ERR_PROCESSING";
                break;
            case Epos2CallbackCode.CODE_ERR_PARAM:
                return_text = "ERR_PARAM";
                break;
            case Epos2CallbackCode.CODE_RETRY:
                return_text = "RETRY";
                break;
            case Epos2CallbackCode.CODE_ERR_DIFFERENT_MODEL:
                return_text = "ERR_DIFFERENT_MODEL";
                break;
            case Epos2CallbackCode.CODE_ERR_DIFFERENT_VERSION:
                return_text = "ERR_DIFFERENT_VERSION";
                break;
            case Epos2CallbackCode.CODE_ERR_DATA_CORRUPTED:
                return_text = "ERR_DATA_CORRUPTED";
                break;
            default:
                return_text = String.format("%d", state);
                break;
        }
        return return_text;
    }

    public static int getPrinterSeries(final String deviceName) {

        if (deviceName == null || deviceName.isEmpty()) return Printer.TM_T88;

        if (deviceName.startsWith("TM-T88VII")) return Printer.TM_T88VII;
        if (deviceName.startsWith("TM-m30II")) return Printer.TM_M30II;
        if (deviceName.startsWith("TM-m30")) return Printer.TM_M30;
        if (deviceName.startsWith("TM-L90LFC")) return Printer.TM_L90LFC;
        if (deviceName.startsWith("TM-L90")) return Printer.TM_L90;
        if (deviceName.startsWith("TM-m50")) return Printer.TM_M50;
        if (deviceName.startsWith("TM-L100")) return Printer.TM_L100;
        if (deviceName.startsWith("TM-m10")) return Printer.TM_M10;
        if (deviceName.startsWith("TM-P20")) return Printer.TM_P20;
        if (deviceName.startsWith("TM-P60II")) return Printer.TM_P60II;
        if (deviceName.startsWith("TM-P60")) return Printer.TM_P60;
        if (deviceName.startsWith("TM-P80")) return Printer.TM_P80;
        if (deviceName.startsWith("TM-T20")) return Printer.TM_T20;
        if (deviceName.startsWith("TM-T60")) return Printer.TM_T60;
        if (deviceName.startsWith("TM-T70")) return Printer.TM_T70;
        if (deviceName.startsWith("TM-T81")) return Printer.TM_T81;
        if (deviceName.startsWith("TM-T82")) return Printer.TM_T82;
        if (deviceName.startsWith("TM-T83III")) return Printer.TM_T83III;
        if (deviceName.startsWith("TM-T83")) return Printer.TM_T83;
        if (deviceName.startsWith("TM-T88")) return Printer.TM_T88;
        if (deviceName.startsWith("TM-T90KP")) return Printer.TM_T90KP;
        if (deviceName.startsWith("TM-T90")) return Printer.TM_T90;
        if (deviceName.startsWith("TM-U220")) return Printer.TM_U220;
        if (deviceName.startsWith("TM-U330")) return Printer.TM_U330;
        if (deviceName.startsWith("TM-H6000")) return Printer.TM_H6000;
        if (deviceName.startsWith("TM-T100")) return Printer.TM_T100;
        if (deviceName.startsWith("TS-100")) return Printer.TS_100;
        if (deviceName.startsWith("EU_M30")) return Printer.EU_M30;

        return Printer.TM_T88;

    }
}
