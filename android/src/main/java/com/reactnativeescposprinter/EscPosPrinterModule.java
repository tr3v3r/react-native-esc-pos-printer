package com.escposprinter;

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

import com.facebook.react.bridge.WritableMap;
import com.facebook.react.bridge.ReadableMap;

import com.escposprinter.ThePrinterManager;
import com.escposprinter.ThePrinter;
import com.escposprinter.EposStringHelper;
import com.escposprinter.PrinterCallback;


@ReactModule(name = EscPosPrinterModule.NAME)
public class EscPosPrinterModule extends ReactContextBaseJavaModule {
    private Context mContext;
    private final ReactApplicationContext reactContext;
    private ThePrinterManager thePrinterManager_ = ThePrinterManager.getInstance();
    private int ERR_INIT = EposStringHelper.getInitErrorResultCode();
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
     return EposStringHelper.getPrinterConstants();
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
          promise.reject(EposStringHelper.getErrorTextData(Epos2Exception.ERR_MEMORY, ""));
        } else {
          promise.resolve(null);
        }
        } catch(Exception e) {
          processError(promise,e, "");
        }
    }

    @ReactMethod
    synchronized public void connect(String target, int timeout, Promise promise) {
       new Thread(new Runnable() {
            @Override
            synchronized public void run() {
                ThePrinter thePrinter = thePrinterManager_.getObject(target);
                if (thePrinter == null) {
                  promise.reject(EposStringHelper.getErrorTextData(ERR_INIT, ""));
                } else {
                  try {
                    thePrinter.connect(timeout);
                    promise.resolve(null);
                  } catch(Exception e) {
                    processError(promise,e, "");
                  }
                }
            }
        }).start();
    }

   @ReactMethod
    synchronized public void disconnect(String target, Promise promise) {
      new Thread(new Runnable() {
        @Override
        synchronized public void run() {
          ThePrinter thePrinter = thePrinterManager_.getObject(target);
          if (thePrinter == null) {
            promise.reject(EposStringHelper.getErrorTextData(ERR_INIT, ""));
          } else {
            try {
              thePrinter.disconnect();
              promise.resolve(null);
            } catch(Exception e) {
              processError(promise,e, "");
            }
          }
        }
      }).start();
    }

    @ReactMethod
    synchronized public void clearCommandBuffer(String target, Promise promise){
      ThePrinter thePrinter = thePrinterManager_.getObject(target);
      if (thePrinter == null) {
        promise.reject(EposStringHelper.getErrorTextData(ERR_INIT, ""));
      } else {
        try {
          thePrinter.clearCommandBuffer();
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
        promise.reject(EposStringHelper.getErrorTextData(ERR_INIT, ""));
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
        promise.reject(EposStringHelper.getErrorTextData(ERR_INIT, ""));
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
        promise.reject(EposStringHelper.getErrorTextData(ERR_INIT, ""));
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
    synchronized public void addLineSpace(String target, int linespc, Promise promise) {
      ThePrinter thePrinter = thePrinterManager_.getObject(target);
      if (thePrinter == null) {
        promise.reject(EposStringHelper.getErrorTextData(ERR_INIT, ""));
      } else {
        try {
          thePrinter.addLineSpace(linespc);
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
        promise.reject(EposStringHelper.getErrorTextData(ERR_INIT, ""));
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
        promise.reject(EposStringHelper.getErrorTextData(ERR_INIT, ""));
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
        promise.reject(EposStringHelper.getErrorTextData(ERR_INIT, ""));
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
        promise.reject(EposStringHelper.getErrorTextData(ERR_INIT, ""));
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
        promise.reject(EposStringHelper.getErrorTextData(ERR_INIT, ""));
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
        promise.reject(EposStringHelper.getErrorTextData(ERR_INIT, ""));
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
        promise.reject(EposStringHelper.getErrorTextData(ERR_INIT, ""));
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
        promise.reject(EposStringHelper.getErrorTextData(ERR_INIT, ""));
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
        promise.reject(EposStringHelper.getErrorTextData(ERR_INIT, ""));
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
        promise.reject(EposStringHelper.getErrorTextData(ERR_INIT, ""));
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
      new Thread(new Runnable() {
          @Override
          synchronized public void run() {
            ThePrinter thePrinter = thePrinterManager_.getObject(target);
            if (thePrinter == null) {
              promise.reject(EposStringHelper.getErrorTextData(ERR_INIT, ""));
            } else {
              try {
                WritableMap data = thePrinter.getStatus();
                promise.resolve(data);
              } catch(Exception e) {
                processError(promise, e, "");
              }
            }
        }
      }).start();
    }

    @ReactMethod
    synchronized public void sendData(String target, int timeout, Promise promise) {
      ThePrinter thePrinter = thePrinterManager_.getObject(target);
      if (thePrinter == null) {
        promise.reject(EposStringHelper.getErrorTextData(ERR_INIT, "result"));
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
        new Thread(new Runnable() {
      @Override
      synchronized public void run() {
          ThePrinter thePrinter = thePrinterManager_.getObject(target);
          if (thePrinter == null) {
            promise.reject(EposStringHelper.getErrorTextData(ERR_INIT, "result"));
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
        }).start();
    }

    private void  processError(Promise promise, Exception e, String errorType) {
      int errorCode;
      if (e instanceof Epos2Exception) {
        errorCode = ((Epos2Exception) e).getErrorStatus();
      } else {
        errorCode = Epos2Exception.ERR_FAILURE;
      }
      promise.reject(EposStringHelper.getErrorTextData(errorCode, errorType));
    }
}
