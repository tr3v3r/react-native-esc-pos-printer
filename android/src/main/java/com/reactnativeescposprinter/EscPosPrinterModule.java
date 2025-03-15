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

import com.escposprinter.NativeEscPosPrinterSpec;


@ReactModule(name = EscPosPrinterModule.NAME)
public class EscPosPrinterModule extends NativeEscPosPrinterSpec {
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

    protected Map<String, Object> getTypedExportedConstants() {
      return EposStringHelper.getPrinterConstants();
    }

    @ReactMethod
    synchronized public void initWithPrinterDeviceName(String target, String deviceName, double lang, Promise promise) {
      ThePrinter thePrinter = thePrinterManager_.getObject(target);

      try {
        if (thePrinter == null) {
          thePrinter = new ThePrinter();
          thePrinterManager_.add(thePrinter, target);
          int series = EposStringHelper.getPrinterSeries(deviceName);
          thePrinter.setupWith(target, series, (int) lang, mContext);
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
    synchronized public void connect(String target, double timeout, Promise promise) {
       new Thread(new Runnable() {
            @Override
            synchronized public void run() {
                ThePrinter thePrinter = thePrinterManager_.getObject(target);
                if (thePrinter == null) {
                  promise.reject(EposStringHelper.getErrorTextData(ERR_INIT, ""));
                } else {
                  try {
                    thePrinter.connect((int) timeout);
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
    synchronized public void addTextLang(String target, double lang, Promise promise) {
      ThePrinter thePrinter = thePrinterManager_.getObject(target);
      if (thePrinter == null) {
        promise.reject(EposStringHelper.getErrorTextData(ERR_INIT, ""));
      } else {
          try {
            thePrinter.addTextLang((int) lang);
            promise.resolve(null);
          } catch(Exception e) {
            processError(promise, e, "");
          }
      }
    }

    @ReactMethod
    synchronized public void addFeedLine(String target, double line, Promise promise) {
      ThePrinter thePrinter = thePrinterManager_.getObject(target);
      if (thePrinter == null) {
        promise.reject(EposStringHelper.getErrorTextData(ERR_INIT, ""));
      } else {
        try {
          thePrinter.addFeedLine((int) line);
          promise.resolve(null);
        } catch(Exception e) {
          processError(promise, e, "");
        }
      }
    }

    @ReactMethod
    synchronized public void addLineSpace(String target, double linespc, Promise promise) {
      ThePrinter thePrinter = thePrinterManager_.getObject(target);
      if (thePrinter == null) {
        promise.reject(EposStringHelper.getErrorTextData(ERR_INIT, ""));
      } else {
        try {
          thePrinter.addLineSpace((int) linespc);
          promise.resolve(null);
        } catch(Exception e) {
          processError(promise, e, "");
        }
      }
    }

    @ReactMethod
    synchronized public void addCut(String target, double type, Promise promise) {
      ThePrinter thePrinter = thePrinterManager_.getObject(target);
      if (thePrinter == null) {
        promise.reject(EposStringHelper.getErrorTextData(ERR_INIT, ""));
      } else {
        try {
          thePrinter.addCut((int) type);
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
    synchronized public void addPulse(String target, double drawer, double time, Promise promise) {
      ThePrinter thePrinter = thePrinterManager_.getObject(target);
      if (thePrinter == null) {
        promise.reject(EposStringHelper.getErrorTextData(ERR_INIT, ""));
      } else {
        try {
          thePrinter.addPulse((int) drawer, (int) time);
          promise.resolve(null);
        } catch(Exception e) {
          processError(promise, e, "");
        }
      }
    }

    @ReactMethod
    synchronized public void addTextAlign(String target, double align, Promise promise) {
      ThePrinter thePrinter = thePrinterManager_.getObject(target);
      if (thePrinter == null) {
        promise.reject(EposStringHelper.getErrorTextData(ERR_INIT, ""));
      } else {
        try {
          thePrinter.addTextAlign((int) align);
          promise.resolve(null);
        } catch(Exception e) {
          processError(promise, e, "");
        }
      }
    }

    @ReactMethod
    synchronized public void addTextSize(String target, double width, double height, Promise promise) {
      ThePrinter thePrinter = thePrinterManager_.getObject(target);
      if (thePrinter == null) {
        promise.reject(EposStringHelper.getErrorTextData(ERR_INIT, ""));
      } else {
        try {
          thePrinter.addTextSize((int) width, (int) height);
          promise.resolve(null);
        } catch(Exception e) {
          processError(promise, e, "");
        }
      }
    }

    @ReactMethod
    synchronized public void addTextSmooth(String target, double smooth, Promise promise) {
      ThePrinter thePrinter = thePrinterManager_.getObject(target);
      if (thePrinter == null) {
        promise.reject(EposStringHelper.getErrorTextData(ERR_INIT, ""));
      } else {
        try {
          thePrinter.addTextSmooth((int) smooth);
          promise.resolve(null);
        } catch(Exception e) {
          processError(promise, e, "");
        }
      }
    }

    @ReactMethod
    synchronized public void addTextStyle(String target, double reverse, double ul, double em, double color, Promise promise) {
      ThePrinter thePrinter = thePrinterManager_.getObject(target);
      if (thePrinter == null) {
        promise.reject(EposStringHelper.getErrorTextData(ERR_INIT, ""));
      } else {
        try {
          thePrinter.addTextStyle((int) reverse, (int) ul, (int) em, (int) color);
          promise.resolve(null);
        } catch(Exception e) {
          processError(promise, e, "");
        }
      }
    }


    @ReactMethod
    synchronized public void addImage(String target, ReadableMap source, double width, double color,
                                      double mode, double halftone, double brightness, double compress, Promise promise) {
      ThePrinter thePrinter = thePrinterManager_.getObject(target);
      if (thePrinter == null) {
        promise.reject(EposStringHelper.getErrorTextData(ERR_INIT, ""));
      } else {
        try {
          thePrinter.addImage(source, mContext, (int) width, (int) color, (int) mode, (int) halftone, (int) brightness, (int) compress);
          promise.resolve(null);
        } catch(Exception e) {
          processError(promise, e, "");
        }
      }
    }

    @ReactMethod
    synchronized public void addBarcode(String target, String data, double type, double hri, double font, double width, double height, Promise promise) {
      ThePrinter thePrinter = thePrinterManager_.getObject(target);
      if (thePrinter == null) {
        promise.reject(EposStringHelper.getErrorTextData(ERR_INIT, ""));
      } else {
        try {
          thePrinter.addBarcode(data, (int) type, (int) hri, (int) font, (int) width, (int) height);
          promise.resolve(null);
        } catch(Exception e) {
          processError(promise, e, "");
        }
      }
    }

    @ReactMethod
    synchronized public void addSymbol(String target, String data, double type, double level, double width, double height, double size, Promise promise) {
      ThePrinter thePrinter = thePrinterManager_.getObject(target);
      if (thePrinter == null) {
        promise.reject(EposStringHelper.getErrorTextData(ERR_INIT, ""));
      } else {
        try {
          thePrinter.addSymbol(data, (int) type, (int) level, (int) width, (int) height, (int) size);
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
    synchronized public void sendData(String target, double timeout, Promise promise) {
      ThePrinter thePrinter = thePrinterManager_.getObject(target);
      if (thePrinter == null) {
        promise.reject(EposStringHelper.getErrorTextData(ERR_INIT, "result"));
      } else {
          try {
            thePrinter.sendData((int) timeout, new PrinterCallback() {
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
    synchronized public void getPrinterSetting(String target, double timeout, double type, Promise promise) {
        new Thread(new Runnable() {
      @Override
      synchronized public void run() {
          ThePrinter thePrinter = thePrinterManager_.getObject(target);
          if (thePrinter == null) {
            promise.reject(EposStringHelper.getErrorTextData(ERR_INIT, "result"));
          } else {
              try {
                thePrinter.getPrinterSetting((int) timeout, (int) type, new PrinterCallback() {
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
