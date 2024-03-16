package com.reactnativeescposprinter;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.module.annotations.ReactModule;
import com.facebook.react.modules.core.DeviceEventManagerModule;

import java.util.HashMap;
import java.util.Map;

import android.content.Context;

import com.epson.epos2.printer.Printer;
import com.epson.epos2.Epos2Exception;
import com.epson.epos2.Epos2CallbackCode;

import com.facebook.react.bridge.WritableMap;
import com.facebook.react.bridge.ReadableMap;

import com.reactnativeescposprinter.ThePrinterManager;
import com.reactnativeescposprinter.ThePrinter;
import com.reactnativeescposprinter.EposStringHelper;
import com.reactnativeescposprinter.PrinterCallback;
import com.reactnativeescposprinter.EscPosPrinterErrorManager;


@ReactModule(name = EscPosPrinterModule.NAME)
public class EscPosPrinterModule extends ReactContextBaseJavaModule {
    private Context mContext;
    private final ReactApplicationContext reactContext;
    private ThePrinterManager thePrinterManager_ = ThePrinterManager.getInstance();
    private int ERR_INIT = -1;

    public static final String NAME = "EscPosPrinter";

    public EscPosPrinterModule(ReactApplicationContext reactContext) {
        super(reactContext);
        mContext = reactContext;
        this.reactContext = reactContext;
    }

    @Override
    @NonNull
    public String getName() {
        return NAME;
    }

    @Override
    public Map<String, Object> getConstants() {
      final Map<String, Object> constants = new HashMap<>();

      // init models lang
      constants.put("MODEL_ANK", Printer.MODEL_ANK);
      constants.put("MODEL_CHINESE", Printer.MODEL_CHINESE);
      constants.put("MODEL_TAIWAN", Printer.MODEL_TAIWAN);
      constants.put("MODEL_KOREAN", Printer.MODEL_KOREAN);
      constants.put("MODEL_THAI", Printer.MODEL_THAI);
      constants.put("MODEL_SOUTHASIA", Printer.MODEL_SOUTHASIA);

      // cut types
      constants.put("CUT_FEED", Printer.CUT_FEED);
      constants.put("CUT_NO_FEED", Printer.CUT_NO_FEED);
      constants.put("CUT_RESERVE", Printer.CUT_RESERVE);
      constants.put("FULL_CUT_FEED", Printer.FULL_CUT_FEED);
      constants.put("FULL_CUT_NO_FEED", Printer.FULL_CUT_NO_FEED);
      constants.put("FULL_CUT_RESERVE", Printer.FULL_CUT_RESERVE);
      constants.put("PARAM_DEFAULT", Printer.PARAM_DEFAULT);
      constants.put("PARAM_UNSPECIFIED", Printer.PARAM_UNSPECIFIED);

      // errors
      constants.put("ERR_PARAM", Epos2Exception.ERR_PARAM);
      constants.put("ERR_MEMORY", Epos2Exception.ERR_MEMORY);
      constants.put("ERR_UNSUPPORTED", Epos2Exception.ERR_UNSUPPORTED);
      constants.put("ERR_FAILURE", Epos2Exception.ERR_FAILURE);
      constants.put("ERR_PROCESSING", Epos2Exception.ERR_PROCESSING);
      constants.put("ERR_CONNECT", Epos2Exception.ERR_CONNECT);
      constants.put("ERR_TIMEOUT", Epos2Exception.ERR_TIMEOUT);
      constants.put("ERR_ILLEGAL", Epos2Exception.ERR_ILLEGAL);
      constants.put("ERR_NOT_FOUND", Epos2Exception.ERR_NOT_FOUND);
      constants.put("ERR_IN_USE", Epos2Exception.ERR_IN_USE);
      constants.put("ERR_TYPE_INVALID", Epos2Exception.ERR_TYPE_INVALID);
      constants.put("ERR_RECOVERY_FAILURE", Epos2Exception.ERR_RECOVERY_FAILURE);
      constants.put("ERR_DISCONNECT", Epos2Exception.ERR_DISCONNECT);
      constants.put("ERR_INIT", ERR_INIT);

      // code errors

      constants.put("CODE_ERR_AUTORECOVER", Epos2CallbackCode.CODE_ERR_AUTORECOVER);
      constants.put("CODE_ERR_COVER_OPEN", Epos2CallbackCode.CODE_ERR_COVER_OPEN);
      constants.put("CODE_ERR_CUTTER", Epos2CallbackCode.CODE_ERR_CUTTER);
      constants.put("CODE_ERR_MECHANICAL", Epos2CallbackCode.CODE_ERR_MECHANICAL);
      constants.put("CODE_ERR_EMPTY", Epos2CallbackCode.CODE_ERR_EMPTY);
      constants.put("CODE_ERR_UNRECOVERABLE", Epos2CallbackCode.CODE_ERR_UNRECOVERABLE);
      constants.put("CODE_ERR_FAILURE", Epos2CallbackCode.CODE_ERR_FAILURE);
      constants.put("CODE_ERR_NOT_FOUND", Epos2CallbackCode.CODE_ERR_NOT_FOUND);
      constants.put("CODE_ERR_SYSTEM", Epos2CallbackCode.CODE_ERR_SYSTEM);
      constants.put("CODE_ERR_PORT", Epos2CallbackCode.CODE_ERR_PORT);
      constants.put("CODE_ERR_TIMEOUT", Epos2CallbackCode.CODE_ERR_TIMEOUT);
      constants.put("CODE_ERR_JOB_NOT_FOUND", Epos2CallbackCode.CODE_ERR_JOB_NOT_FOUND);
      constants.put("CODE_ERR_SPOOLER", Epos2CallbackCode.CODE_ERR_SPOOLER);
      constants.put("CODE_ERR_BATTERY_LOW", Epos2CallbackCode.CODE_ERR_BATTERY_LOW);
      constants.put("CODE_ERR_TOO_MANY_REQUESTS", Epos2CallbackCode.CODE_ERR_TOO_MANY_REQUESTS);
      constants.put("CODE_ERR_REQUEST_ENTITY_TOO_LARGE", Epos2CallbackCode.CODE_ERR_REQUEST_ENTITY_TOO_LARGE);
      constants.put("CODE_ERR_WAIT_REMOVAL", Epos2CallbackCode.CODE_ERR_WAIT_REMOVAL);
      constants.put("CODE_PRINTING", Epos2CallbackCode.CODE_PRINTING);
      constants.put("CODE_ERR_MEMORY", Epos2CallbackCode.CODE_ERR_MEMORY);
      constants.put("CODE_ERR_PROCESSING", Epos2CallbackCode.CODE_ERR_PROCESSING);
      constants.put("CODE_ERR_ILLEGAL", Epos2CallbackCode.CODE_ERR_ILLEGAL);
      constants.put("CODE_ERR_DEVICE_BUSY", Epos2CallbackCode.CODE_ERR_DEVICE_BUSY);

          // get printer settings

      constants.put("PRINTER_SETTING_PAPERWIDTH", Printer.SETTING_PAPERWIDTH);
      constants.put("PRINTER_SETTING_PRINTDENSITY", Printer.SETTING_PRINTDENSITY);
      constants.put("PRINTER_SETTING_PRINTSPEED", Printer.SETTING_PRINTSPEED);

      constants.put("PRINTER_SETTING_PAPERWIDTH58_0", Printer.SETTING_PAPERWIDTH_58_0);
      constants.put("PRINTER_SETTING_PAPERWIDTH60_0", Printer.SETTING_PAPERWIDTH_60_0);
      constants.put("PRINTER_SETTING_PAPERWIDTH70_0", Printer.SETTING_PAPERWIDTH_70_0);
      constants.put("PRINTER_SETTING_PAPERWIDTH76_0", Printer.SETTING_PAPERWIDTH_76_0);
      constants.put("PRINTER_SETTING_PAPERWIDTH80_0", Printer.SETTING_PAPERWIDTH_80_0);
      constants.put("PRINTER_SETTING_PRINTDENSITYDIP", Printer.SETTING_PRINTDENSITY_DIP);
      constants.put("PRINTER_SETTING_PRINTDENSITY70", Printer.SETTING_PRINTDENSITY_70);
      constants.put("PRINTER_SETTING_PRINTDENSITY75", Printer.SETTING_PRINTDENSITY_75);
      constants.put("PRINTER_SETTING_PRINTDENSITY80", Printer.SETTING_PRINTDENSITY_80);
      constants.put("PRINTER_SETTING_PRINTDENSITY85", Printer.SETTING_PRINTDENSITY_85);
      constants.put("PRINTER_SETTING_PRINTDENSITY90", Printer.SETTING_PRINTDENSITY_90);
      constants.put("PRINTER_SETTING_PRINTDENSITY95", Printer.SETTING_PRINTDENSITY_95);
      constants.put("PRINTER_SETTING_PRINTDENSITY100", Printer.SETTING_PRINTDENSITY_100);
      constants.put("PRINTER_SETTING_PRINTDENSITY105", Printer.SETTING_PRINTDENSITY_105);
      constants.put("PRINTER_SETTING_PRINTDENSITY110", Printer.SETTING_PRINTDENSITY_110);
      constants.put("PRINTER_SETTING_PRINTDENSITY115", Printer.SETTING_PRINTDENSITY_115);
      constants.put("PRINTER_SETTING_PRINTDENSITY120", Printer.SETTING_PRINTDENSITY_120);
      constants.put("PRINTER_SETTING_PRINTDENSITY125", Printer.SETTING_PRINTDENSITY_125);
      constants.put("PRINTER_SETTING_PRINTDENSITY130", Printer.SETTING_PRINTDENSITY_130);
      constants.put("PRINTER_SETTING_PRINTSPEED1", Printer.SETTING_PRINTSPEED_1);
      constants.put("PRINTER_SETTING_PRINTSPEED2", Printer.SETTING_PRINTSPEED_2);
      constants.put("PRINTER_SETTING_PRINTSPEED3", Printer.SETTING_PRINTSPEED_3);
      constants.put("PRINTER_SETTING_PRINTSPEED4", Printer.SETTING_PRINTSPEED_4);
      constants.put("PRINTER_SETTING_PRINTSPEED5", Printer.SETTING_PRINTSPEED_5);
      constants.put("PRINTER_SETTING_PRINTSPEED6", Printer.SETTING_PRINTSPEED_6);
      constants.put("PRINTER_SETTING_PRINTSPEED7", Printer.SETTING_PRINTSPEED_7);
      constants.put("PRINTER_SETTING_PRINTSPEED8", Printer.SETTING_PRINTSPEED_8);
      constants.put("PRINTER_SETTING_PRINTSPEED9", Printer.SETTING_PRINTSPEED_9);
      constants.put("PRINTER_SETTING_PRINTSPEED10", Printer.SETTING_PRINTSPEED_10);
      constants.put("PRINTER_SETTING_PRINTSPEED11", Printer.SETTING_PRINTSPEED_11);
      constants.put("PRINTER_SETTING_PRINTSPEED12", Printer.SETTING_PRINTSPEED_12);
      constants.put("PRINTER_SETTING_PRINTSPEED13", Printer.SETTING_PRINTSPEED_13);
      constants.put("PRINTER_SETTING_PRINTSPEED14", Printer.SETTING_PRINTSPEED_14);
      constants.put("PRINTER_SETTING_PRINTSPEED15", Printer.SETTING_PRINTSPEED_15);
      constants.put("PRINTER_SETTING_PRINTSPEED16", Printer.SETTING_PRINTSPEED_16);
      constants.put("PRINTER_SETTING_PRINTSPEED17", Printer.SETTING_PRINTSPEED_17);

      // printer status

      constants.put("TRUE", Printer.TRUE);
      constants.put("FALSE", Printer.FALSE);
      constants.put("UNKNOWN", Printer.UNKNOWN);
      constants.put("PAPER_OK", Printer.PAPER_OK);
      constants.put("PAPER_NEAR_END", Printer.PAPER_NEAR_END);
      constants.put("PAPER_EMPTY", Printer.PAPER_EMPTY);
      constants.put("SWITCH_ON", Printer.SWITCH_ON);
      constants.put("SWITCH_OFF", Printer.SWITCH_OFF);
      constants.put("DRAWER_HIGH", Printer.DRAWER_HIGH);
      constants.put("DRAWER_LOW", Printer.DRAWER_LOW);
      constants.put("NO_ERR", Printer.NO_ERR);
      constants.put("MECHANICAL_ERR", Printer.MECHANICAL_ERR);
      constants.put("AUTOCUTTER_ERR", Printer.AUTOCUTTER_ERR);
      constants.put("UNRECOVER_ERR", Printer.UNRECOVER_ERR);
      constants.put("AUTORECOVER_ERR", Printer.AUTORECOVER_ERR);
      constants.put("HEAD_OVERHEAT", Printer.HEAD_OVERHEAT);
      constants.put("MOTOR_OVERHEAT", Printer.MOTOR_OVERHEAT);
      constants.put("BATTERY_OVERHEAT", Printer.BATTERY_OVERHEAT);
      constants.put("WRONG_PAPER", Printer.WRONG_PAPER);
      constants.put("COVER_OPEN", Printer.COVER_OPEN);
      constants.put("EPOS2_BATTERY_LEVEL_6", Printer.BATTERY_LEVEL_6);
      constants.put("EPOS2_BATTERY_LEVEL_5", Printer.BATTERY_LEVEL_5);
      constants.put("EPOS2_BATTERY_LEVEL_4", Printer.BATTERY_LEVEL_4);
      constants.put("EPOS2_BATTERY_LEVEL_3", Printer.BATTERY_LEVEL_3);
      constants.put("EPOS2_BATTERY_LEVEL_2", Printer.BATTERY_LEVEL_2);
      constants.put("EPOS2_BATTERY_LEVEL_1", Printer.BATTERY_LEVEL_1);
      constants.put("EPOS2_BATTERY_LEVEL_0", Printer.BATTERY_LEVEL_0);
      constants.put("REMOVAL_WAIT_PAPER", Printer.REMOVAL_WAIT_PAPER);
      constants.put("REMOVAL_WAIT_NONE", Printer.REMOVAL_WAIT_NONE);
      constants.put("REMOVAL_DETECT_PAPER", Printer.REMOVAL_DETECT_PAPER);
      constants.put("REMOVAL_DETECT_PAPER_NONE", Printer.REMOVAL_DETECT_PAPER_NONE);
      constants.put("REMOVAL_DETECT_UNKNOWN", Printer.REMOVAL_DETECT_UNKNOWN);
      constants.put("HIGH_VOLTAGE_ERR", Printer.HIGH_VOLTAGE_ERR);
      constants.put("LOW_VOLTAGE_ERR", Printer.LOW_VOLTAGE_ERR);


      // image
      constants.put("COLOR_NONE", Printer.COLOR_NONE);
      constants.put("COLOR_1", Printer.COLOR_1);
      constants.put("COLOR_2", Printer.COLOR_2);
      constants.put("COLOR_3", Printer.COLOR_3);
      constants.put("COLOR_4", Printer.COLOR_4);
      constants.put("MODE_MONO", Printer.MODE_MONO);
      constants.put("MODE_GRAY16", Printer.MODE_GRAY16);
      constants.put("MODE_MONO_HIGH_DENSITY", Printer.MODE_MONO_HIGH_DENSITY);
      constants.put("HALFTONE_DITHER", Printer.HALFTONE_DITHER);
      constants.put("HALFTONE_ERROR_DIFFUSION", Printer.HALFTONE_ERROR_DIFFUSION);
      constants.put("HALFTONE_THRESHOLD", Printer.HALFTONE_THRESHOLD);
      constants.put("COMPRESS_DEFLATE", Printer.COMPRESS_DEFLATE);
      constants.put("COMPRESS_NONE", Printer.COMPRESS_NONE);
      constants.put("COMPRESS_AUTO", Printer.COMPRESS_AUTO);

      // barcode
      constants.put("BARCODE_UPC_A", Printer.BARCODE_UPC_A);
      constants.put("BARCODE_UPC_E", Printer.BARCODE_UPC_E);
      constants.put("BARCODE_EAN13", Printer.BARCODE_EAN13);
      constants.put("BARCODE_JAN13", Printer.BARCODE_JAN13);
      constants.put("BARCODE_EAN8", Printer.BARCODE_EAN8);
      constants.put("BARCODE_JAN8", Printer.BARCODE_JAN8);
      constants.put("BARCODE_CODE39", Printer.BARCODE_CODE39);
      constants.put("BARCODE_ITF", Printer.BARCODE_ITF);
      constants.put("BARCODE_CODABAR", Printer.BARCODE_CODABAR);
      constants.put("BARCODE_CODE93", Printer.BARCODE_CODE93);
      constants.put("BARCODE_CODE128", Printer.BARCODE_CODE128);
      constants.put("BARCODE_CODE128_AUTO", Printer.BARCODE_CODE128_AUTO);
      constants.put("BARCODE_GS1_128", Printer.BARCODE_GS1_128);
      constants.put("BARCODE_GS1_DATABAR_OMNIDIRECTIONAL", Printer.BARCODE_GS1_DATABAR_OMNIDIRECTIONAL);
      constants.put("BARCODE_GS1_DATABAR_TRUNCATED", Printer.BARCODE_GS1_DATABAR_TRUNCATED);
      constants.put("BARCODE_GS1_DATABAR_LIMITED", Printer.BARCODE_GS1_DATABAR_LIMITED);
      constants.put("BARCODE_GS1_DATABAR_EXPANDED", Printer.BARCODE_GS1_DATABAR_EXPANDED);
      constants.put("HRI_NONE", Printer.HRI_NONE);
      constants.put("HRI_ABOVE", Printer.HRI_ABOVE);
      constants.put("HRI_BELOW", Printer.HRI_BELOW);
      constants.put("HRI_BOTH", Printer.HRI_BOTH);

      // font

      constants.put("FONT_A", Printer.FONT_A);
      constants.put("FONT_B", Printer.FONT_B);
      constants.put("FONT_C", Printer.FONT_C);
      constants.put("FONT_D", Printer.FONT_D);
      constants.put("FONT_E", Printer.FONT_E);

      // symbol

      constants.put("SYMBOL_PDF417_STANDARD", Printer.SYMBOL_PDF417_STANDARD);
      constants.put("SYMBOL_PDF417_TRUNCATED", Printer.SYMBOL_PDF417_TRUNCATED);
      constants.put("SYMBOL_QRCODE_MODEL_1", Printer.SYMBOL_QRCODE_MODEL_1);
      constants.put("SYMBOL_QRCODE_MODEL_2", Printer.SYMBOL_QRCODE_MODEL_2);
      constants.put("SYMBOL_QRCODE_MICRO", Printer.SYMBOL_QRCODE_MICRO);
      constants.put("SYMBOL_MAXICODE_MODE_2", Printer.SYMBOL_MAXICODE_MODE_2);
      constants.put("SYMBOL_MAXICODE_MODE_3", Printer.SYMBOL_MAXICODE_MODE_3);
      constants.put("SYMBOL_MAXICODE_MODE_4", Printer.SYMBOL_MAXICODE_MODE_4);
      constants.put("SYMBOL_MAXICODE_MODE_5", Printer.SYMBOL_MAXICODE_MODE_5);
      constants.put("SYMBOL_MAXICODE_MODE_6", Printer.SYMBOL_MAXICODE_MODE_6);
      constants.put("SYMBOL_GS1_DATABAR_STACKED", Printer.SYMBOL_GS1_DATABAR_STACKED);
      constants.put("SYMBOL_GS1_DATABAR_STACKED_OMNIDIRECTIONAL", Printer.SYMBOL_GS1_DATABAR_STACKED_OMNIDIRECTIONAL);
      constants.put("SYMBOL_GS1_DATABAR_EXPANDED_STACKED", Printer.SYMBOL_GS1_DATABAR_EXPANDED_STACKED);
      constants.put("SYMBOL_AZTECCODE_FULLRANGE", Printer.SYMBOL_AZTECCODE_FULLRANGE);
      constants.put("SYMBOL_AZTECCODE_COMPACT", Printer.SYMBOL_AZTECCODE_COMPACT);
      constants.put("SYMBOL_DATAMATRIX_SQUARE", Printer.SYMBOL_DATAMATRIX_SQUARE);
      constants.put("SYMBOL_DATAMATRIX_RECTANGLE_8", Printer.SYMBOL_DATAMATRIX_RECTANGLE_8);
      constants.put("SYMBOL_DATAMATRIX_RECTANGLE_12", Printer.SYMBOL_DATAMATRIX_RECTANGLE_12);
      constants.put("SYMBOL_DATAMATRIX_RECTANGLE_16", Printer.SYMBOL_DATAMATRIX_RECTANGLE_16);
      constants.put("LEVEL_0", Printer.LEVEL_0);
      constants.put("LEVEL_1", Printer.LEVEL_1);
      constants.put("LEVEL_2", Printer.LEVEL_2);
      constants.put("LEVEL_3", Printer.LEVEL_3);
      constants.put("LEVEL_4", Printer.LEVEL_4);
      constants.put("LEVEL_5", Printer.LEVEL_5);
      constants.put("LEVEL_6", Printer.LEVEL_6);
      constants.put("LEVEL_7", Printer.LEVEL_7);
      constants.put("LEVEL_8", Printer.LEVEL_8);
      constants.put("LEVEL_L", Printer.LEVEL_L);
      constants.put("LEVEL_M", Printer.LEVEL_M);
      constants.put("LEVEL_Q", Printer.LEVEL_Q);
      constants.put("LEVEL_H", Printer.LEVEL_H);

      // add pulse

      constants.put("DRAWER_2PIN", Printer.DRAWER_2PIN);
      constants.put("DRAWER_5PIN", Printer.DRAWER_5PIN);
      constants.put("PULSE_100", Printer.PULSE_100);
      constants.put("PULSE_200", Printer.PULSE_200);
      constants.put("PULSE_300", Printer.PULSE_300);
      constants.put("PULSE_400", Printer.PULSE_400);
      constants.put("PULSE_500", Printer.PULSE_500);

      // text align

      constants.put("ALIGN_LEFT", Printer.ALIGN_LEFT);
      constants.put("ALIGN_CENTER", Printer.ALIGN_CENTER);
      constants.put("ALIGN_RIGHT", Printer.ALIGN_RIGHT);

      // lang

      constants.put("LANG_EN", Printer.LANG_EN);
      constants.put("LANG_JA", Printer.LANG_JA);
      constants.put("LANG_ZH_CN", Printer.LANG_ZH_CN);
      constants.put("LANG_ZH_TW", Printer.LANG_ZH_TW);
      constants.put("LANG_KO", Printer.LANG_KO);
      constants.put("LANG_TH", Printer.LANG_TH);
      constants.put("LANG_VI", Printer.LANG_VI);
      constants.put("LANG_MULTI", Printer.LANG_MULTI);

      return constants;
    }

    @ReactMethod
    synchronized public void initWithPrinterDeviceName(String target, String deviceName, int lang, Promise promise) {
      ThePrinter thePrinter = thePrinterManager_.getObject(target);

      try {
        if (thePrinter == null) {
          thePrinter = new ThePrinter();
          thePrinterManager_.add(thePrinter, target);
          int series = EposStringHelper.getPrinterSeries(deviceName);
          thePrinter.setupWith(target, series, lang, mContext);
        }

        Printer mPrinter = thePrinter.getEpos2Printer();

        if(mPrinter == null) {
          promise.reject(EscPosPrinterErrorManager.getErrorTextData(Epos2Exception.ERR_MEMORY, ""));
        } else {
          promise.resolve(null);
        }
        } catch(Exception e) {
          processError(promise,e, "");
        }
    }

    @ReactMethod
    synchronized public void connect(String target, int timeout, Promise promise) {
      ThePrinter thePrinter = thePrinterManager_.getObject(target);
      if (thePrinter == null) {
        promise.reject(EscPosPrinterErrorManager.getErrorTextData(ERR_INIT, ""));
      } else {
        try {
          thePrinter.connect(timeout);
          promise.resolve(null);
        } catch(Exception e) {
          processError(promise,e, "");
        }
      }
    }

   @ReactMethod
    synchronized public void disconnect(String target, Promise promise) {
      ThePrinter thePrinter = thePrinterManager_.getObject(target);
      if (thePrinter == null) {
        promise.reject(EscPosPrinterErrorManager.getErrorTextData(ERR_INIT, ""));
      } else {
        try {
          thePrinter.disconnect();
          promise.resolve(null);
        } catch(Exception e) {
          processError(promise,e, "");
        }
      }
    }

    @ReactMethod
    synchronized public void clearCmdBuffer(String target, Promise promise){
      ThePrinter thePrinter = thePrinterManager_.getObject(target);
      if (thePrinter == null) {
        promise.reject(EscPosPrinterErrorManager.getErrorTextData(ERR_INIT, ""));
      } else {
        try {
          thePrinter.clearCmdBuffer();
          promise.resolve(null);
        } catch(Exception e) {
          processError(promise, e, "");
        }
      }
    }

    @ReactMethod
    synchronized public void addText(String target, String data, Promise promise) {
      ThePrinter thePrinter = thePrinterManager_.getObject(target);
      if (thePrinter == null) {
        promise.reject(EscPosPrinterErrorManager.getErrorTextData(ERR_INIT, ""));
      } else {
          try {
            thePrinter.addText(data);
            promise.resolve(null);
          } catch(Exception e) {
            processError(promise, e, "");
          }
      }
    }

    @ReactMethod
    synchronized public void addTextLang(String target, int lang, Promise promise) {
      ThePrinter thePrinter = thePrinterManager_.getObject(target);
      if (thePrinter == null) {
        promise.reject(EscPosPrinterErrorManager.getErrorTextData(ERR_INIT, ""));
      } else {
          try {
            thePrinter.addTextLang(lang);
            promise.resolve(null);
          } catch(Exception e) {
            processError(promise, e, "");
          }
      }
    }

    @ReactMethod
    synchronized public void addFeedLine(String target, int line, Promise promise) {
      ThePrinter thePrinter = thePrinterManager_.getObject(target);
      if (thePrinter == null) {
        promise.reject(EscPosPrinterErrorManager.getErrorTextData(ERR_INIT, ""));
      } else {
        try {
          thePrinter.addFeedLine(line);
          promise.resolve(null);
        } catch(Exception e) {
          processError(promise, e, "");
        }
      }
    }

    @ReactMethod
    synchronized public void addCut(String target, int type, Promise promise) {
      ThePrinter thePrinter = thePrinterManager_.getObject(target);
      if (thePrinter == null) {
        promise.reject(EscPosPrinterErrorManager.getErrorTextData(ERR_INIT, ""));
      } else {
        try {
          thePrinter.addCut(type);
          promise.resolve(null);
        } catch(Exception e) {
          processError(promise, e, "");
        }
      }
    }

    @ReactMethod
    synchronized public void addCommand(String target, String base64string, Promise promise) {
      ThePrinter thePrinter = thePrinterManager_.getObject(target);
      if (thePrinter == null) {
        promise.reject(EscPosPrinterErrorManager.getErrorTextData(ERR_INIT, ""));
      } else {
        try {
          thePrinter.addCommand(base64string);
          promise.resolve(null);
        } catch(Exception e) {
          processError(promise, e, "");
        }
      }
    }

    @ReactMethod
    synchronized public void addPulse(String target, int drawer, int time, Promise promise) {
      ThePrinter thePrinter = thePrinterManager_.getObject(target);
      if (thePrinter == null) {
        promise.reject(EscPosPrinterErrorManager.getErrorTextData(ERR_INIT, ""));
      } else {
        try {
          thePrinter.addPulse(drawer, time);
          promise.resolve(null);
        } catch(Exception e) {
          processError(promise, e, "");
        }
      }
    }

    @ReactMethod
    synchronized public void addTextAlign(String target, int align, Promise promise) {
      ThePrinter thePrinter = thePrinterManager_.getObject(target);
      if (thePrinter == null) {
        promise.reject(EscPosPrinterErrorManager.getErrorTextData(ERR_INIT, ""));
      } else {
        try {
          thePrinter.addTextAlign(align);
          promise.resolve(null);
        } catch(Exception e) {
          processError(promise, e, "");
        }
      }
    }

    @ReactMethod
    synchronized public void addTextSize(String target, int width, int height, Promise promise) {
      ThePrinter thePrinter = thePrinterManager_.getObject(target);
      if (thePrinter == null) {
        promise.reject(EscPosPrinterErrorManager.getErrorTextData(ERR_INIT, ""));
      } else {
        try {
          thePrinter.addTextSize(width, height);
          promise.resolve(null);
        } catch(Exception e) {
          processError(promise, e, "");
        }
      }
    }

    @ReactMethod
    synchronized public void addTextSmooth(String target, int smooth, Promise promise) {
      ThePrinter thePrinter = thePrinterManager_.getObject(target);
      if (thePrinter == null) {
        promise.reject(EscPosPrinterErrorManager.getErrorTextData(ERR_INIT, ""));
      } else {
        try {
          thePrinter.addTextSmooth(smooth);
          promise.resolve(null);
        } catch(Exception e) {
          processError(promise, e, "");
        }
      }
    }

    @ReactMethod
    synchronized public void addTextStyle(String target, int reverse, int ul, int em, int color, Promise promise) {
      ThePrinter thePrinter = thePrinterManager_.getObject(target);
      if (thePrinter == null) {
        promise.reject(EscPosPrinterErrorManager.getErrorTextData(ERR_INIT, ""));
      } else {
        try {
          thePrinter.addTextStyle(reverse, ul, em, color);
          promise.resolve(null);
        } catch(Exception e) {
          processError(promise, e, "");
        }
      }
    }


    @ReactMethod
    synchronized public void addImage(String target, ReadableMap source, int width, int color,
                                      int mode, int halftone, double brightness, int compress, Promise promise) {
      ThePrinter thePrinter = thePrinterManager_.getObject(target);
      if (thePrinter == null) {
        promise.reject(EscPosPrinterErrorManager.getErrorTextData(ERR_INIT, ""));
      } else {
        try {
          thePrinter.addImage(source, mContext, width, color, mode, halftone, brightness, compress);
          promise.resolve(null);
        } catch(Exception e) {
          processError(promise, e, "");
        }
      }
    }

    @ReactMethod
    synchronized public void addBarcode(String target, String data, int type, int hri, int font, int width, int height, Promise promise) {
      ThePrinter thePrinter = thePrinterManager_.getObject(target);
      if (thePrinter == null) {
        promise.reject(EscPosPrinterErrorManager.getErrorTextData(ERR_INIT, ""));
      } else {
        try {
          thePrinter.addBarcode(data, type, hri, font, width, height);
          promise.resolve(null);
        } catch(Exception e) {
          processError(promise, e, "");
        }
      }
    }

    @ReactMethod
    synchronized public void addSymbol(String target, String data, int type, int level, int width, int height, int size, Promise promise) {
      ThePrinter thePrinter = thePrinterManager_.getObject(target);
      if (thePrinter == null) {
        promise.reject(EscPosPrinterErrorManager.getErrorTextData(ERR_INIT, ""));
      } else {
        try {
          thePrinter.addSymbol(data, type, level, width, height, size);
          promise.resolve(null);
        } catch(Exception e) {
          processError(promise, e, "");
        }
      }
    }

    @ReactMethod
    synchronized public void getStatus(String target, Promise promise) {
      ThePrinter thePrinter = thePrinterManager_.getObject(target);
      if (thePrinter == null) {
        promise.reject(EscPosPrinterErrorManager.getErrorTextData(ERR_INIT, ""));
      } else {
        try {
          WritableMap data = thePrinter.getStatus();
          promise.resolve(data);
        } catch(Exception e) {
          processError(promise, e, "");
        }
      }
    }

    @ReactMethod
    synchronized public void sendData(String target, int timeout, Promise promise) {
      ThePrinter thePrinter = thePrinterManager_.getObject(target);
      if (thePrinter == null) {
        promise.reject(EscPosPrinterErrorManager.getErrorTextData(ERR_INIT, "result"));
      } else {
          try {
            thePrinter.sendData(timeout, new PrinterCallback() {
            @Override
            public void onSuccess(WritableMap returnData) {
              promise.resolve(returnData);
            }

            @Override
            public void onError(String errorData) {
              promise.reject(errorData);
            }
          });
        } catch(Exception e) {
            processError(promise, e, "result");
        }
      }
    }

    @ReactMethod
    synchronized public void getPrinterSetting(String target, int timeout, int type, Promise promise) {
      ThePrinter thePrinter = thePrinterManager_.getObject(target);
      if (thePrinter == null) {
        promise.reject(EscPosPrinterErrorManager.getErrorTextData(ERR_INIT, "result"));
      } else {
          try {
            thePrinter.getPrinterSetting(timeout, type, new PrinterCallback() {
            @Override
            public void onSuccess(WritableMap returnData) {
              promise.resolve(returnData);
            }

            @Override
            public void onError(String errorData) {
              promise.reject(errorData);
            }
          });
        } catch(Exception e) {
            processError(promise, e, "result");
        }
      }
    }

    private void  processError(Promise promise, Exception e, String errorType) {
      int errorCode;
      if (e instanceof Epos2Exception) {
        errorCode = ((Epos2Exception) e).getErrorStatus();
      } else {
        errorCode = Epos2Exception.ERR_FAILURE;
      }
      promise.reject(EscPosPrinterErrorManager.getErrorTextData(errorCode, errorType));
    }
}
