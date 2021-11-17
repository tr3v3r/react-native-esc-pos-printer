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

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

import android.content.Context;

import com.epson.epos2.printer.Printer;
import com.epson.epos2.Epos2Exception;
import com.epson.epos2.Epos2CallbackCode;
import com.epson.epos2.printer.ReceiveListener;
import com.epson.epos2.printer.PrinterStatusInfo;
import com.epson.epos2.printer.PrinterSettingListener;

import com.facebook.react.bridge.UiThreadUtil;

import android.content.res.AssetManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.util.Base64;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.Timer;
import java.util.TimerTask;
import com.facebook.react.bridge.WritableMap;
import android.os.Handler;
import java.util.concurrent.Callable;

import com.facebook.react.bridge.ReadableMap;
import android.util.Log;
import java.net.URL;
class PrintingCommands {
  public static final int COMMAND_ADD_TEXT = 0;
  public static final int COMMAND_ADD_NEW_LINE = 1;
  public static final int COMMAND_ADD_TEXT_STYLE = 2;
  public static final int COMMAND_ADD_TEXT_SIZE = 3;
  public static final int COMMAND_ADD_ALIGN = 4;
  public static final int COMMAND_ADD_IMAGE_BASE_64 = 5;
  public static final int COMMAND_ADD_IMAGE_ASSET = 6;
  public static final int COMMAND_ADD_CUT = 7;
  public static final int COMMAND_ADD_DATA = 8;
  public static final int COMMAND_ADD_TEXT_SMOOTH = 9;
  public static final int COMMAND_ADD_BARCODE = 10;
  public static final int COMMAND_ADD_QRCODE = 11;
  public static final int COMMAND_ADD_IMAGE = 12;
  public static final int COMMAND_ADD_PULSE = 13;
}

@ReactModule(name = EscPosPrinterModule.NAME)
public class EscPosPrinterModule extends ReactContextBaseJavaModule implements ReceiveListener {
    private static final int DISCONNECT_INTERVAL = 500;
    private Context mContext;
    public static Printer  mPrinter = null;
    private final ReactApplicationContext reactContext;
    private String printerAddress = null;
    private Runnable monitor = null;

    ExecutorService tasksQueue = Executors.newSingleThreadExecutor();
    private Boolean mIsMonitoring = false;
    interface MyCallbackInterface {
      void onSuccess(String result);
      void onError(String result);
   }

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
      constants.put("EPOS2_TM_M10", Printer.TM_M10);
      constants.put("EPOS2_TM_M30", Printer.TM_M30);
      constants.put("EPOS2_TM_P20", Printer.TM_P20);
      constants.put("EPOS2_TM_P60", Printer.TM_P60);
      constants.put("EPOS2_TM_P60II", Printer.TM_P60II);
      constants.put("EPOS2_TM_P80", Printer.TM_P80);
      constants.put("EPOS2_TM_T20", Printer.TM_T20);
      constants.put("EPOS2_TM_T60", Printer.TM_T60);
      constants.put("EPOS2_TM_T70", Printer.TM_T70);
      constants.put("EPOS2_TM_T81", Printer.TM_T81);
      constants.put("EPOS2_TM_T82", Printer.TM_T82);
      constants.put("EPOS2_TM_T83", Printer.TM_T83);
      constants.put("EPOS2_TM_T88", Printer.TM_T88);
      constants.put("EPOS2_TM_T90", Printer.TM_T90);
      constants.put("EPOS2_TM_T90KP", Printer.TM_T90KP);
      constants.put("EPOS2_TM_U220", Printer.TM_U220);
      constants.put("EPOS2_TM_U330", Printer.TM_U330);
      constants.put("EPOS2_TM_L90", Printer.TM_L90);
      constants.put("EPOS2_TM_H6000", Printer.TM_H6000);
      constants.put("EPOS2_TM_T83III", Printer.TM_T83III);
      constants.put("EPOS2_TM_T100", Printer.TM_T100);
      constants.put("EPOS2_TM_M30II", Printer.TM_M30II);
      constants.put("EPOS2_TS_100", Printer.TS_100);
      constants.put("EPOS2_TM_M50", Printer.TM_M50);
      constants.put("COMMAND_ADD_TEXT", PrintingCommands.COMMAND_ADD_TEXT);
      constants.put("COMMAND_ADD_NEW_LINE", PrintingCommands.COMMAND_ADD_NEW_LINE);
      constants.put("COMMAND_ADD_TEXT_STYLE", PrintingCommands.COMMAND_ADD_TEXT_STYLE);
      constants.put("COMMAND_ADD_TEXT_SIZE", PrintingCommands.COMMAND_ADD_TEXT_SIZE);
      constants.put("COMMAND_ADD_TEXT_SMOOTH", PrintingCommands.COMMAND_ADD_TEXT_SMOOTH);
      constants.put("COMMAND_ADD_ALIGN", PrintingCommands.COMMAND_ADD_ALIGN);
      constants.put("COMMAND_ADD_IMAGE_BASE_64", PrintingCommands.COMMAND_ADD_IMAGE_BASE_64);
      constants.put("COMMAND_ADD_IMAGE_ASSET", PrintingCommands.COMMAND_ADD_IMAGE_ASSET);
      constants.put("COMMAND_ADD_IMAGE", PrintingCommands.COMMAND_ADD_IMAGE);
      constants.put("COMMAND_ADD_BARCODE", PrintingCommands.COMMAND_ADD_BARCODE);
      constants.put("COMMAND_ADD_QRCODE", PrintingCommands.COMMAND_ADD_QRCODE);
      constants.put("COMMAND_ADD_CUT", PrintingCommands.COMMAND_ADD_CUT);
      constants.put("COMMAND_ADD_DATA", PrintingCommands.COMMAND_ADD_DATA);
      constants.put("COMMAND_ADD_PULSE", PrintingCommands.COMMAND_ADD_PULSE);
      constants.put("EPOS2_ALIGN_LEFT", Printer.ALIGN_LEFT);
      constants.put("EPOS2_ALIGN_RIGHT", Printer.ALIGN_RIGHT);
      constants.put("EPOS2_ALIGN_CENTER", Printer.ALIGN_CENTER);
      constants.put("EPOS2_TRUE", Printer.TRUE);
      constants.put("EPOS2_FALSE", Printer.FALSE);
      constants.put("EPOS2_LANG_EN", Printer.LANG_EN);
      constants.put("EPOS2_LANG_JA", Printer.LANG_JA);
      constants.put("EPOS2_LANG_ZH_CN", Printer.LANG_ZH_CN);
      constants.put("EPOS2_LANG_ZH_TW", Printer.LANG_ZH_TW);
      constants.put("EPOS2_LANG_KO", Printer.LANG_KO);
      constants.put("EPOS2_LANG_TH", Printer.LANG_TH);
      constants.put("EPOS2_LANG_VI", Printer.LANG_VI);
      constants.put("EPOS2_LANG_MULTI", Printer.PARAM_DEFAULT);
      constants.put("EPOS2_BARCODE_UPC_A", Printer.BARCODE_UPC_A);
      constants.put("EPOS2_BARCODE_UPC_E", Printer.BARCODE_UPC_E);
      constants.put("EPOS2_BARCODE_EAN13", Printer.BARCODE_EAN13);
      constants.put("EPOS2_BARCODE_JAN13", Printer.BARCODE_JAN13);
      constants.put("EPOS2_BARCODE_EAN8", Printer.BARCODE_EAN8);
      constants.put("EPOS2_BARCODE_JAN8", Printer.BARCODE_JAN8);
      constants.put("EPOS2_BARCODE_CODE39", Printer.BARCODE_CODE39);
      constants.put("EPOS2_BARCODE_ITF", Printer.BARCODE_ITF);
      constants.put("EPOS2_BARCODE_CODABAR", Printer.BARCODE_CODABAR);
      constants.put("EPOS2_BARCODE_CODE93", Printer.BARCODE_CODE93);
      constants.put("EPOS2_BARCODE_CODE128", Printer.BARCODE_CODE128);
      constants.put("EPOS2_BARCODE_GS1_128", Printer.BARCODE_GS1_128);
      constants.put("EPOS2_BARCODE_GS1_DATABAR_OMNIDIRECTIONAL", Printer.BARCODE_GS1_DATABAR_OMNIDIRECTIONAL);
      constants.put("EPOS2_BARCODE_GS1_DATABAR_TRUNCATED", Printer.BARCODE_GS1_DATABAR_TRUNCATED);
      constants.put("EPOS2_BARCODE_GS1_DATABAR_LIMITED", Printer.BARCODE_GS1_DATABAR_LIMITED);
      constants.put("EPOS2_BARCODE_GS1_DATABAR_EXPANDED", Printer.BARCODE_GS1_DATABAR_EXPANDED);
      constants.put("EPOS2_BARCODE_CODE128_AUTO", Printer.BARCODE_CODE128_AUTO);
      constants.put("EPOS2_HRI_NONE", Printer.HRI_NONE);
      constants.put("EPOS2_HRI_ABOVE", Printer.HRI_ABOVE);
      constants.put("EPOS2_HRI_BELOW", Printer.HRI_BELOW);
      constants.put("EPOS2_HRI_BOTH", Printer.HRI_BOTH);
      constants.put("EPOS2_LEVEL_L", Printer.LEVEL_L);
      constants.put("EPOS2_LEVEL_M", Printer.LEVEL_M);
      constants.put("EPOS2_LEVEL_Q", Printer.LEVEL_Q);
      constants.put("EPOS2_LEVEL_H", Printer.LEVEL_H);
      constants.put("EPOS2_SYMBOL_QRCODE_MODEL_1", Printer.SYMBOL_QRCODE_MODEL_1);
      constants.put("EPOS2_SYMBOL_QRCODE_MODEL_2", Printer.SYMBOL_QRCODE_MODEL_2);
      constants.put("EPOS2_SYMBOL_QRCODE_MICRO", Printer.SYMBOL_QRCODE_MICRO);
      // Print image settings
      constants.put("EPOS2_COLOR_1", Printer.COLOR_1);
      constants.put("EPOS2_COLOR_2", Printer.COLOR_2);
      constants.put("EPOS2_COLOR_3", Printer.COLOR_3);
      constants.put("EPOS2_COLOR_4", Printer.COLOR_4);

      constants.put("EPOS2_MODE_MONO", Printer.MODE_MONO);
      constants.put("EPOS2_MODE_GRAY16", Printer.MODE_GRAY16);
      constants.put("EPOS2_MODE_MONO_HIGH_DENSITY", Printer.MODE_MONO_HIGH_DENSITY);

      constants.put("EPOS2_HALFTONE_DITHER", Printer.HALFTONE_DITHER);
      constants.put("EPOS2_HALFTONE_ERROR_DIFFUSION", Printer.HALFTONE_ERROR_DIFFUSION);
      constants.put("EPOS2_HALFTONE_THRESHOLD", Printer.HALFTONE_THRESHOLD);

      return constants;
    }

    private void sendEvent(ReactApplicationContext reactContext,
    String eventName,
    @Nullable String params) {
      reactContext
      .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
      .emit(eventName, params);
  }

  @ReactMethod
  public void init(String target, int series, int language,Promise promise) {
    this.finalizeObject();
    this.initializeObject(series, language, new MyCallbackInterface() {
      @Override
      public void onSuccess(String result) {
        promise.resolve(result);
      }
      @Override
      public void onError(String result) {
        promise.reject(result);
      }
    });

    this.printerAddress = target;
  }

  @ReactMethod
  public void getPaperWidth(Promise promise) {

    tasksQueue.submit(new Runnable() {
      @Override
      public void run() {
        getPrinterSettings(Printer.SETTING_PAPERWIDTH, new MyCallbackInterface() {
          @Override
          public void onSuccess(String result) {
            promise.resolve(result);
          }
          @Override
          public void onError(String result) {
            promise.reject(result);
          }
        });
      }
    });

  }

    private void initializeObject(int series, int language,MyCallbackInterface callback) {
       try {
        mPrinter = new Printer(series, Printer.MODEL_ANK, mContext);
        mPrinter.addTextLang(language);
       }
        catch (Epos2Exception e) {
          int status = EscPosPrinterErrorManager.getErrorStatus(e);
          String errorString = EscPosPrinterErrorManager.getEposExceptionText(status);
          callback.onError(errorString);

        }
        mPrinter.setReceiveEventListener(this);
        callback.onSuccess("init: success");
  }

   private void finalizeObject() {
     if(mPrinter == null) {
       return;
     }

     mPrinter.clearCommandBuffer();
     mPrinter.setReceiveEventListener(null);
     mPrinter = null;
   }

   private void connectPrinter() throws Epos2Exception {

    if (mPrinter == null) {
      throw new Epos2Exception(Epos2Exception.ERR_PARAM);
    }

    mPrinter.connect(this.printerAddress, Printer.PARAM_DEFAULT);
    mPrinter.beginTransaction();
   }

   private void disconnectPrinter() {
    if (mPrinter == null) {
        return;
    }

    try {
      mPrinter.endTransaction();
    } catch(Epos2Exception e) {

    }

    while (true) {
        try {
            mPrinter.disconnect();
            System.out.println("Disconnected!");
            break;
        } catch (final Exception e) {
            if (e instanceof Epos2Exception) {
                //Note: If printer is processing such as printing and so on, the disconnect API returns ERR_PROCESSING.
                if (((Epos2Exception) e).getErrorStatus() == Epos2Exception.ERR_PROCESSING) {
                    try {
                        Thread.sleep(DISCONNECT_INTERVAL);
                    } catch (Exception ex) {
                    }
                }else{
                  break;
                }
            }else{
                break;
            }
        }
    }



      mPrinter.clearCommandBuffer();
    }

    private void printData() throws Epos2Exception {
      this.connectPrinter();
      mPrinter.sendData(Printer.PARAM_DEFAULT);

  }

  @Override
  public void onPtrReceive(final Printer printerObj, final int code, final PrinterStatusInfo status, final String printJobId) {
    UiThreadUtil.runOnUiThread(new Runnable() {
          @Override
          public synchronized void run() {
              String result = EscPosPrinterErrorManager.getCodeText(code);
              if(code == Epos2CallbackCode.CODE_SUCCESS) {
                WritableMap msg = EscPosPrinterErrorManager.makeStatusMassage(status);

                reactContext
                .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                .emit("onPrintSuccess", msg);

              } else {
                sendEvent(reactContext, "onPrintFailure", result);
              }

              new Thread(new Runnable() {
                  @Override
                  public void run() {
                      disconnectPrinter();
                  }
              }).start();
          }
      });
  }

  private void getPrinterSettings(int type, MyCallbackInterface callback) {
    if (mPrinter == null) {
      String errorString = EscPosPrinterErrorManager.getEposExceptionText(Epos2Exception.ERR_PARAM);
      callback.onError(errorString);
      return;
    }

    try {
      this.connectPrinter();
    }
    catch (Epos2Exception e) {
        int status = EscPosPrinterErrorManager.getErrorStatus(e);
        String errorString = EscPosPrinterErrorManager.getEposExceptionText(status);
        callback.onError(errorString);
        return;
    }

    try {
      mPrinter.getPrinterSetting(Printer.PARAM_DEFAULT, type, mSettingListener);
    }
    catch (Epos2Exception e) {
        mPrinter.clearCommandBuffer();
        int status = EscPosPrinterErrorManager.getErrorStatus(e);
        String errorString = EscPosPrinterErrorManager.getEposExceptionText(status);
        callback.onError(errorString);
        this.disconnectPrinter();
        return;
    }

    String successString = EscPosPrinterErrorManager.getCodeText(Epos2CallbackCode.CODE_SUCCESS);
    callback.onSuccess(successString);

  }

  private PrinterSettingListener mSettingListener = new PrinterSettingListener() {
    @Override
    public void onGetPrinterSetting(int code, int type, int value) {
           UiThreadUtil.runOnUiThread(new Runnable() {
          @Override
          public synchronized void run() {
              String result = EscPosPrinterErrorManager.getCodeText(code);
              if(code == Epos2CallbackCode.CODE_SUCCESS) {
                if(type == Printer.SETTING_PAPERWIDTH) {
                  int paperWidth = EscPosPrinterErrorManager.getEposGetWidthResult(value);
                  reactContext
                    .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                    .emit("onGetPaperWidthSuccess", paperWidth);
                }
              } else {
                if(type == Printer.SETTING_PAPERWIDTH) {
                  sendEvent(reactContext, "onGetPaperWidthFailure", result);
                }
              }
              new Thread(new Runnable() {
                  @Override
                  public void run() {
                      disconnectPrinter();
                  }
              }).start();
          }
      });

    }

    @Override public void onSetPrinterSetting(int code) {
        // do nothing
    }
  };

  private void performMonitoring(int inteval) {
    final Handler handler = new Handler();
    monitor = new Runnable(){

      @Override
      public void run() {

        if(mIsMonitoring) {
         tasksQueue.submit(new Callable<String>() {
          @Override
          public String call() {
            PrinterStatusInfo statusInfo = null;
             try {
               connectPrinter();
               statusInfo = mPrinter.getStatus();
               WritableMap msg = EscPosPrinterErrorManager.makeStatusMassage(statusInfo);

               reactContext
               .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
               .emit("onMonitorStatusUpdate", msg);
               disconnectPrinter();
               return null;
             } catch(Epos2Exception e) {
               int errorStatus = ((Epos2Exception) e).getErrorStatus();

              if (errorStatus != Epos2Exception.ERR_PROCESSING && errorStatus != Epos2Exception.ERR_ILLEGAL) {

                WritableMap msg = EscPosPrinterErrorManager.getOfflineStatusMessage();

                reactContext
                .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                .emit("onMonitorStatusUpdate", msg);
               }
               return null;
             } finally {
               handler.postDelayed(monitor, inteval);
             }

          }
      });
    }
      }
    };


    monitor.run();
  }

  @ReactMethod
  public void startMonitorPrinter(int interval, Promise promise) {

    if (mIsMonitoring){
      promise.reject("Already monitoring!");
      return;
    }

    if (mPrinter == null) {
      String errorString = EscPosPrinterErrorManager.getEposExceptionText(Epos2Exception.ERR_PARAM);
      promise.reject(errorString);
      return;
    }

    mIsMonitoring = true;
    this.performMonitoring(interval * 1000);


    String successString = EscPosPrinterErrorManager.getCodeText(Epos2CallbackCode.CODE_SUCCESS);
    promise.resolve(successString);
  }

  @ReactMethod
  public void stopMonitorPrinter(Promise promise) {
    if(!mIsMonitoring) {
      promise.reject("Printer is not monitorring!");
      return;
    }

    mIsMonitoring = false;
    monitor = null;
    String successString = EscPosPrinterErrorManager.getCodeText(Epos2CallbackCode.CODE_SUCCESS);
    promise.resolve(successString);
  }

  @ReactMethod
  public void printBuffer(ReadableArray printBuffer, Promise promise) {
    tasksQueue.submit(new Runnable() {
      @Override
      public void run() {
        printFromBuffer(printBuffer, new MyCallbackInterface() {
          @Override
          public void onSuccess(String result) {
            promise.resolve(result);
          }

          @Override
          public void onError(String result) {
            promise.reject(result);
          }
        });
      }
    });
  }

  public void printFromBuffer(ReadableArray printBuffer, MyCallbackInterface callback) {
    if (mPrinter == null) {
      String errorString = EscPosPrinterErrorManager.getEposExceptionText(Epos2Exception.ERR_PARAM);
      callback.onError(errorString);
      return;
    }

    try {
      int bufferLength = printBuffer.size();
      for (int curr = 0; curr < bufferLength; curr++) {
        ReadableArray command = printBuffer.getArray(curr);
        handleCommand(command.getInt(0), command.getArray(1));
      }
    } catch (Epos2Exception e) {
      mPrinter.clearCommandBuffer();
      int status = EscPosPrinterErrorManager.getErrorStatus(e);
      String errorString = EscPosPrinterErrorManager.getEposExceptionText(status);
      callback.onError(errorString);
      return;
    } catch (IOException e){
      mPrinter.clearCommandBuffer();
      callback.onError(e.getMessage());
      return;
    }
    try {
      this.printData();
      String successString = EscPosPrinterErrorManager.getCodeText(Epos2CallbackCode.CODE_SUCCESS);
      callback.onSuccess(successString);
    } catch (Epos2Exception e) {
      int status = EscPosPrinterErrorManager.getErrorStatus(e);
      String errorString = EscPosPrinterErrorManager.getEposExceptionText(status);
      callback.onError(errorString);
    }
  }

  @ReactMethod
  public void addListener(String eventName) {
    // Keep: Required for RN built in Event Emitter Calls.
  }

  @ReactMethod
  public void removeListeners(Integer count) {
    // Keep: Required for RN built in Event Emitter Calls.
  }

  private Bitmap getBitmapFromSource(ReadableMap source) throws Exception {
    String uriString = source.getString("uri");

    if(uriString.startsWith("data")) {
        final String pureBase64Encoded = uriString.substring(uriString.indexOf(",") + 1);
        byte[] decodedString = Base64.decode(pureBase64Encoded, Base64.DEFAULT);
        Bitmap image = BitmapFactory.decodeByteArray(decodedString, 0, decodedString.length);

        return image;
    }

    if(uriString.startsWith("http") || uriString.startsWith("https")) {
      URL url = new URL(uriString);
      Bitmap image = BitmapFactory.decodeStream(url.openConnection().getInputStream());
      return image;
    }

    if(uriString.startsWith("file")) {
      BitmapFactory.Options options = new BitmapFactory.Options();
      options.inPreferredConfig = Bitmap.Config.ARGB_8888;
      Bitmap image = BitmapFactory.decodeFile(uriString, options);

      return image;
    }

    int resourceId = mContext.getResources().getIdentifier(uriString, "drawable", mContext.getPackageName());
    Bitmap image = BitmapFactory.decodeResource(mContext.getResources(), resourceId);

    return image;
  }


  private void handleCommand(int command, ReadableArray params) throws Epos2Exception, IOException {
    switch (command) {
      case PrintingCommands.COMMAND_ADD_TEXT:
        mPrinter.addText(params.getString(0));
        break;
      case PrintingCommands.COMMAND_ADD_PULSE:
        String pinNumber = params.getString(0);
        mPrinter.addPulse(pinNumber, Printer.PARAM_DEFAULT);
        break;
      case PrintingCommands.COMMAND_ADD_NEW_LINE:
        mPrinter.addFeedLine(params.getInt(0));
        break;
      case PrintingCommands.COMMAND_ADD_TEXT_STYLE:
        mPrinter.addTextStyle(Printer.FALSE, params.getInt(0), params.getInt(1), Printer.COLOR_1);
        break;
      case PrintingCommands.COMMAND_ADD_TEXT_SIZE:
        mPrinter.addTextSize(params.getInt(0), params.getInt(1));
        break;
      case PrintingCommands.COMMAND_ADD_ALIGN:
        mPrinter.addTextAlign(params.getInt(0));
        break;

      case PrintingCommands.COMMAND_ADD_IMAGE:
        ReadableMap source = params.getMap(0);

        int imgWidth = params.getInt(1);
        int color = params.getInt(2);
        int mode = params.getInt(3);
        int halftone = params.getInt(4);
        double brightness = params.getDouble(5);
        try {
          Bitmap imgBitmap = getBitmapFromSource(source);
          handlePrintImage(imgBitmap, imgWidth, color, mode, halftone, brightness);
        } catch(Exception e) {
          Log.e("MYAPP", "exception", e); // TODO: fallback printing
        }


      break;
      case PrintingCommands.COMMAND_ADD_IMAGE_BASE_64:
        String uriString = params.getString(0);
        final String pureBase64Encoded = uriString.substring(uriString.indexOf(",") + 1);
        byte[] decodedString = Base64.decode(pureBase64Encoded, Base64.DEFAULT);
        Bitmap bitmap = BitmapFactory.decodeByteArray(decodedString, 0, decodedString.length);
        int inputWidth = params.getInt(1);

        handlePrintImage(bitmap, inputWidth, Printer.COLOR_1, Printer.MODE_MONO, Printer.HALFTONE_DITHER, Printer.PARAM_DEFAULT);
        break;

      case PrintingCommands.COMMAND_ADD_IMAGE_ASSET:
        String imageName = params.getString(0);
        int width = params.getInt(1);

        AssetManager assetManager = mContext.getAssets();
        InputStream inputStream = assetManager.open(params.getString(0));
        Bitmap assetBitmap = BitmapFactory.decodeStream(inputStream);
        inputStream.close();

        handlePrintImage(assetBitmap, width, Printer.COLOR_1, Printer.MODE_MONO, Printer.HALFTONE_DITHER, Printer.PARAM_DEFAULT);
        break;
      case PrintingCommands.COMMAND_ADD_CUT:
        mPrinter.addCut(Printer.CUT_FEED);
        break;
      case PrintingCommands.COMMAND_ADD_DATA:
        String base64String = params.getString(0);
        byte[] data = Base64.decode(base64String, Base64.DEFAULT);
        mPrinter.addCommand(data);
        break;
      case PrintingCommands.COMMAND_ADD_TEXT_SMOOTH:
        mPrinter.addTextSmooth(params.getInt(0));
        break;
      case PrintingCommands.COMMAND_ADD_BARCODE:
        mPrinter.addBarcode(params.getString(0), params.getInt(1), params.getInt(2), Printer.FONT_A, params.getInt(3), params.getInt(4));
        break;
      case PrintingCommands.COMMAND_ADD_QRCODE:
        mPrinter.addSymbol(params.getString(0), params.getInt(1), params.getInt(2), params.getInt(3), params.getInt(3), params.getInt(3));
        break;
      default:
        throw new IllegalArgumentException("Invalid Printing Command");
    }
  }

  private void handlePrintImage(Bitmap bitmap, int width, int color, int mode, int halftone, double brightness) throws Epos2Exception {
    float aspectRatio = bitmap.getWidth() / (float) bitmap.getHeight();
    int newHeight = Math.round(width / aspectRatio);
    bitmap = Bitmap.createScaledBitmap(bitmap, width, newHeight, false);

    mPrinter.addImage(
      bitmap,
      0,
      0,
      width,
      newHeight,
      color,
      mode,
      halftone,
      brightness,
      Printer.COMPRESS_AUTO
    );
  }
}
