package com.reactnativeescposprinter;

import com.epson.epos2.Epos2Exception;
import com.epson.epos2.Epos2CallbackCode;
import com.epson.epos2.printer.Printer;
import com.epson.epos2.printer.PrinterStatusInfo;
import com.facebook.react.bridge.Arguments;

import com.facebook.react.bridge.WritableMap;
public class EscPosPrinterErrorManager {

    public static int getErrorStatus(Epos2Exception e) {
      return e.getErrorStatus();
    }

    public static String getEposExceptionText(int state) {

        String return_text = "";
        switch (state) {
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
                return_text = String.format("%d", state);
                break;
        }
        return return_text;
    }

    public static String getCodeText(int state) {
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

    public static int getEposGetWidthResult(int resultCode) {
      int result = 0;

      switch (resultCode) {
        case Printer.SETTING_PAPERWIDTH_58_0:
            result = 58;
            break;
        case Printer.SETTING_PAPERWIDTH_60_0:
            result = 60;
            break;
        case Printer.SETTING_PAPERWIDTH_80_0:
            result = 80;
            break;
        default:
            result = 0;
            break;
    }

    return result;
    }

    public static WritableMap makeStatusMassage(PrinterStatusInfo statusInfo) {
      WritableMap statusMessage = Arguments.createMap();


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

      statusMessage.putString("connection",connection);
      statusMessage.putString("online",online);
      statusMessage.putString("coverOpen",coverOpen);
      statusMessage.putString("paper",paper);
      statusMessage.putString("paperFeed",paperFeed);
      statusMessage.putString("panelSwitch",panelSwitch);
      statusMessage.putString("drawer",drawer);
      statusMessage.putString("errorStatus",errorStatus);
      statusMessage.putString("autoRecoverErr",autoRecoverErr);
      statusMessage.putString("adapter",adapter);
      statusMessage.putString("batteryLevel",batteryLevel);


      return statusMessage;
  }

  public static WritableMap getOfflineStatusMessage() {
    WritableMap statusMessage = Arguments.createMap();

      statusMessage.putString("connection","DISCONNECT");
      statusMessage.putString("online","OFFLINE");
      statusMessage.putString("coverOpen","UNKNOWN");
      statusMessage.putString("paper","UNKNOWN");
      statusMessage.putString("paperFeed","UNKNOWN");
      statusMessage.putString("panelSwitch","UNKNOWN");
      statusMessage.putString("drawer","UNKNOWN");
      statusMessage.putString("errorStatus","UNKNOWN");
      statusMessage.putString("autoRecoverErr","UNKNOWN");
      statusMessage.putString("adapter","UNKNOWN");
      statusMessage.putString("batteryLevel","UNKNOWN");


    return statusMessage;
 }
}
