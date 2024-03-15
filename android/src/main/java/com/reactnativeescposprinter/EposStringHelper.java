package com.reactnativeescposprinter;

import com.epson.epos2.printer.Printer;
import com.epson.epos2.printer.PrinterStatusInfo;

import org.json.JSONException;
import org.json.JSONObject;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.WritableMap;

public class EposStringHelper {


public static WritableMap convertStatusInfoToWritableMap(PrinterStatusInfo statusInfo) {
    WritableMap statusMessage = Arguments.createMap();

    statusMessage.putInt("connection",statusInfo.getConnection());
    statusMessage.putInt("online",statusInfo.getOnline());
    statusMessage.putInt("coverOpen",statusInfo.getCoverOpen());
    statusMessage.putInt("paper",statusInfo.getPaper());
    statusMessage.putInt("paperFeed",statusInfo.getPaperFeed());
    statusMessage.putInt("panelSwitch",statusInfo.getPanelSwitch());
    statusMessage.putInt("drawer",statusInfo.getDrawer());
    statusMessage.putInt("errorStatus",statusInfo.getErrorStatus());
    statusMessage.putInt("autoRecoverError",statusInfo.getAutoRecoverError());
    statusMessage.putInt("buzzer",statusInfo.getBuzzer());
    statusMessage.putInt("adapter",statusInfo.getAdapter());
    statusMessage.putInt("batteryLevel", statusInfo.getBatteryLevel());
    statusMessage.putInt("removalWaiting", statusInfo.getRemovalWaiting());
    statusMessage.putInt("paperTakenSensor", statusInfo.getPaperTakenSensor());
    statusMessage.putInt("unrecoverError", statusInfo.getUnrecoverError());

    return statusMessage;
}

public static int getPrinterSeries(final String deviceName) {

        if (deviceName == null || deviceName.isEmpty()) return Printer.TM_T88;

        if (deviceName.startsWith("TM-m10")) return Printer.TM_M10;
        if (deviceName.startsWith("TM-m30")) return Printer.TM_M30;
        if (deviceName.startsWith("TM-m30III")) return Printer.TM_M30III;
        if (deviceName.startsWith("TM-m30II")) return Printer.TM_M30II;
        if (deviceName.startsWith("TM-m50II")) return Printer.TM_M50II;
        if (deviceName.startsWith("TM-m50")) return Printer.TM_M50;
        if (deviceName.startsWith("TM-P20II")) return Printer.TM_P20II;
        if (deviceName.startsWith("TM-P20")) return Printer.TM_P20;
        if (deviceName.startsWith("TM-P60II")) return Printer.TM_P60II;
        if (deviceName.startsWith("TM-P60")) return Printer.TM_P60;
        if (deviceName.startsWith("TM-P80II")) return Printer.TM_P80II;
        if (deviceName.startsWith("TM-P80")) return Printer.TM_P80;
        if (deviceName.startsWith("TM-T20")) return Printer.TM_T20;
        if (deviceName.startsWith("TM-T60")) return Printer.TM_T60;
        if (deviceName.startsWith("TM-T70")) return Printer.TM_T70;
        if (deviceName.startsWith("TM-T81")) return Printer.TM_T81;
        if (deviceName.startsWith("TM-T82")) return Printer.TM_T82;
        if (deviceName.startsWith("TM-T83III")) return Printer.TM_T83III;
        if (deviceName.startsWith("TM-T83")) return Printer.TM_T83;
        if (deviceName.startsWith("TM-T88VII")) return Printer.TM_T88VII;
        if (deviceName.startsWith("TM-T88")) return Printer.TM_T88;
        if (deviceName.startsWith("TM-T90")) return Printer.TM_T90;
        if (deviceName.startsWith("TM-T100")) return Printer.TM_T100;
        if (deviceName.startsWith("TM-U220")) return Printer.TM_U220;
        if (deviceName.startsWith("TM-U330")) return Printer.TM_U330;
        if (deviceName.startsWith("TM-L90LFC")) return Printer.TM_L90LFC;
        if (deviceName.startsWith("TM-L90")) return Printer.TM_L90;
        if (deviceName.startsWith("TM-L100")) return Printer.TM_L100;
        if (deviceName.startsWith("TM-H6000")) return Printer.TM_H6000;

        return Printer.TM_T88;

    }
}
