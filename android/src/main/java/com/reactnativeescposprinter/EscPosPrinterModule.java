package com.reactnativeescposprinter;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.module.annotations.ReactModule;
import com.facebook.react.modules.core.DeviceEventManagerModule;

import java.util.HashMap;
import java.util.Map;

import android.content.Context;

import com.epson.epos2.printer.Printer;
import com.epson.epos2.Epos2Exception;
import com.epson.epos2.Epos2CallbackCode;
import com.epson.epos2.printer.ReceiveListener;
import com.epson.epos2.printer.PrinterStatusInfo;

import com.facebook.react.bridge.UiThreadUtil;
import android.util.Base64;
@ReactModule(name = EscPosPrinterModule.NAME)
public class EscPosPrinterModule extends ReactContextBaseJavaModule implements ReceiveListener {
    private static final int DISCONNECT_INTERVAL = 500;
    private Context mContext;
    public static Printer  mPrinter = null;
    private final ReactApplicationContext reactContext;
    private String printerAddress = null;

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
      return constants;
    }

    private void sendEvent(ReactApplicationContext reactContext,
    String eventName,
    @Nullable String params) {
      reactContext
      .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
      .emit(eventName, params);
  }

    private void initializeObject(int series, MyCallbackInterface callback) {
       try {
        mPrinter = new Printer(series, Printer.MODEL_ANK, mContext);
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

   private void disconnectPrinter() {
    if (mPrinter == null) {
        return;
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
                  UiThreadUtil.runOnUiThread(new Runnable() {
                        public synchronized void run() {

                        }
                    });
                    break;
                }
            }else{
                   UiThreadUtil.runOnUiThread(new Runnable() {
                    public synchronized void run() {

                    }
                });
                break;
            }
        }
    }

      mPrinter.clearCommandBuffer();
    }

    private void printData(MyCallbackInterface callback) {
      if (mPrinter == null) {
        String errorString = EscPosPrinterErrorManager.getEposExceptionText(Epos2Exception.ERR_PARAM);
        callback.onError(errorString);
        return;
      }

      try {
        mPrinter.connect(this.printerAddress, Printer.PARAM_DEFAULT);
      }
      catch (Epos2Exception e) {
          int status = EscPosPrinterErrorManager.getErrorStatus(e);
          String errorString = EscPosPrinterErrorManager.getEposExceptionText(status);
          callback.onError(errorString);
          return;
      }

      try {
          mPrinter.beginTransaction();
      } catch(Epos2Exception e) {
          int status = EscPosPrinterErrorManager.getErrorStatus(e);
          String errorString = EscPosPrinterErrorManager.getEposExceptionText(status);
          callback.onError(errorString);
          return;
      }

      try {
          mPrinter.sendData(Printer.PARAM_DEFAULT);
      }
      catch (Epos2Exception e) {
          mPrinter.clearCommandBuffer();
          int status = EscPosPrinterErrorManager.getErrorStatus(e);
          String errorString = EscPosPrinterErrorManager.getEposExceptionText(status);
          callback.onError(errorString);
          return;
      }

      String successString = EscPosPrinterErrorManager.getCodeText(Epos2CallbackCode.CODE_SUCCESS);
      callback.onError(successString);
  }

  private void printFromBase64(String base64String, MyCallbackInterface callback) {
    if (mPrinter == null) {
      String errorString = EscPosPrinterErrorManager.getEposExceptionText(Epos2Exception.ERR_PARAM);
      callback.onError(errorString);
      return;
    }

    byte[] data = Base64.decode(base64String, Base64.DEFAULT);

    try {
      mPrinter.addCommand(data);
    }
    catch (Epos2Exception e) {
        mPrinter.clearCommandBuffer();
        int status = EscPosPrinterErrorManager.getErrorStatus(e);
        String errorString = EscPosPrinterErrorManager.getEposExceptionText(status);
        callback.onError(errorString);
        return;
    }

    this.printData(new MyCallbackInterface() {
      @Override
      public void onSuccess(String result) {
        callback.onError(result);
      }
      @Override
      public void onError(String result) {
        callback.onSuccess(result);
      }
    });

  }

  @Override
  public void onPtrReceive(final Printer printerObj, final int code, final PrinterStatusInfo status, final String printJobId) {
    UiThreadUtil.runOnUiThread(new Runnable() {
          @Override
          public synchronized void run() {
              String result = EscPosPrinterErrorManager.getCodeText(code);
              if(code == Epos2CallbackCode.CODE_SUCCESS) {
                sendEvent(reactContext, "onPrintSuccess", result);
              } else {
                sendEvent(reactContext, "onPrintFailure", result);
              }
              try {
               mPrinter.endTransaction();
              } catch(Exception e) {

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

  @ReactMethod
  public void init(String target, int series, Promise promise) {
    this.finalizeObject();
    this.initializeObject(series, new MyCallbackInterface() {
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
  public void printBase64(String base64string, Promise promise) {

    new Thread(new Runnable() {
      @Override
      public void run() {
        printFromBase64(base64string, new MyCallbackInterface() {
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
  }).start();

  }
}
