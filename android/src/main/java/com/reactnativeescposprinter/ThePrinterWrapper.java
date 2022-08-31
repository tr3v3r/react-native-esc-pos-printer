package com.reactnativeescposprinter;

import static com.reactnativeescposprinter.ePOSCmd.POS_SUCCESS;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.module.annotations.ReactModule;

import android.content.Context;
import android.content.res.AssetManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.util.Base64;

import androidx.annotation.NonNull;

import com.epson.epos2.Epos2Exception;
import com.epson.epos2.printer.Printer;
import com.epson.epos2.printer.PrinterSettingListener;
import com.epson.epos2.printer.PrinterStatusInfo;
import com.epson.epos2.Epos2CallbackCode;
import com.reactnativeescposprinter.ThePrinter;
import com.reactnativeescposprinter.ThePrinterState;
import com.reactnativeescposprinter.PrinterDelegate;
import com.reactnativeescposprinter.ThePrinterWrapperDelegate;
import com.reactnativeescposprinter.EscPosPrinterErrorManager;
import com.reactnativeescposprinter.ThePrinterManager;

import org.json.JSONObject;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

@ReactModule(name = ThePrinterWrapper.NAME)
public class ThePrinterWrapper extends ReactContextBaseJavaModule implements PrinterDelegate {

    private Context context_ = null;   // Activity object
    private final ReactApplicationContext reactContext;
    private ThePrinterManager thePrinterManager_ = ThePrinterManager.getInstance(); // manage the ThePrinter objects
    ExecutorService tasksQueue = Executors.newSingleThreadExecutor();
    final private Object delegateSync_ = new Object(); // delegate sync lock

    public static final String NAME = "ThePrinterWrapper";

    interface MyCallbackInterface {
      void onSuccess(String result);
      void onError(String result);
    }

    public ThePrinterWrapperDelegate delegate_ = null;  // delegate callback

    public ThePrinterWrapper(ReactApplicationContext reactContext) {
        super(reactContext);
        context_ = reactContext;
        this.reactContext = reactContext;
    }

    @Override
    @NonNull
    public String getName() {
        return NAME;
    }


    private void handleNoObject(final String objectid, final String printerTarget)
    {
        synchronized (delegateSync_) {
            if (delegate_ != null) {
                delegate_.onMemoryError(objectid, "NoObject Created for: " + printerTarget);
            }
        }
    }

    @ReactMethod
    public void init(String target, int series, int language, Promise promise) {
        this.initializeObject(target, series, language, new MyCallbackInterface() {
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

    private void initializeObject(String target, int series, int language, MyCallbackInterface callback) {
        ThePrinter thePrinter = thePrinterManager_.getObject(target);
        try {
            if (thePrinter == null) {
                try {
                    ThePrinter newPrinter = new ThePrinter();
                    thePrinterManager_.add(newPrinter, target);
                    newPrinter.setupWith(target, series, language, this);
                } catch (Epos2Exception e) {
                    callback.onError("The printer object couldn't be created");
                }
            }
            connectPrinter(target, callback);
        } catch (Exception e) {
          callback.onError(e.getMessage());
        }
    }

    @ReactMethod
    public void disconnectAndDeallocate(String target, Promise promise) {
      this.deallocPrinter(target, new MyCallbackInterface() {
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
    /**
     Function deallocPrinter tries to delete selected printer from memory and disconnect if connected.
     @param printerTarget the printer target
     */
    public void deallocPrinter(@NonNull final String printerTarget, MyCallbackInterface callback) {

        try {
          ThePrinter thePrinter = null;
          synchronized (this) {

            thePrinter = thePrinterManager_.getObject(printerTarget);
            if (thePrinter == null) {
              String errorString = EscPosPrinterErrorManager.getEposExceptionText(Epos2Exception.ERR_MEMORY);
              callback.onError(errorString);
            }

            if (thePrinter.isPrinterBusy()) {
              String errorString = EscPosPrinterErrorManager.getEposExceptionText(Epos2Exception.ERR_IN_USE);
              callback.onError(errorString);
            }

            thePrinter.setBusy(ThePrinterState.PRINTER_REMOVING);

            thePrinter.removeDelegates();

            thePrinterManager_.remove(printerTarget);
          }

          thePrinter.shutdown(true);

          try {
            Thread.sleep(1000); // give time for any callbacks to finish
          } catch (InterruptedException e) {
            callback.onError("Interrupted");
          }
          thePrinter = null;
          callback.onSuccess(EscPosPrinterErrorManager.getCodeText(POS_SUCCESS));
        } catch (Exception e) {
          callback.onSuccess(e.getMessage());
        }
    }

    @ReactMethod
    public void connect(String target, Promise promise) {
        this.connectPrinter(target, new MyCallbackInterface() {
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
    /**
     Function connectPrinter tries to connect selected printer
     @param printerTarget the printer target
     */
    public void connectPrinter(@NonNull String printerTarget, MyCallbackInterface callback)  {

        try {
          ThePrinter thePrinter = null;
          synchronized (this) {
            thePrinter = thePrinterManager_.getObject(printerTarget);
            if (thePrinter == null) {
              String errorString = EscPosPrinterErrorManager.getEposExceptionText(Epos2Exception.ERR_MEMORY);
              callback.onError(errorString);
            }
            thePrinter.setBusy(ThePrinterState.PRINTER_CONNECTING);
          }
          try {
            thePrinter.connect(Printer.PARAM_DEFAULT, true);
            callback.onSuccess(EscPosPrinterErrorManager.getCodeText(POS_SUCCESS));
          } catch (Epos2Exception e) {
            String errorString = EscPosPrinterErrorManager.getEposExceptionText(e.getErrorStatus());
            callback.onError(errorString);
          }
        } catch (Exception e) {
          callback.onError(e.getMessage());
        }
    }

    @ReactMethod
    public void disconnect(String target, Promise promise) {
        this.disconnectPrinter(target, new MyCallbackInterface() {
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
    /**
     Function disconnectPrinter tries to disconnect selected printer
     @param printerTarget the printer target
     */
    public void disconnectPrinter(@NonNull final String printerTarget, MyCallbackInterface callback)  {

        try {
          ThePrinter thePrinter = null;
          synchronized (this) {
            thePrinter = thePrinterManager_.getObject(printerTarget);
            if (thePrinter == null) {
              String errorString = EscPosPrinterErrorManager.getEposExceptionText(Epos2Exception.ERR_MEMORY);
              callback.onError(errorString);
            }

            if (thePrinter.isPrinterBusy()) {
              String errorString = EscPosPrinterErrorManager.getEposExceptionText(Epos2Exception.ERR_IN_USE);
              callback.onError(errorString);
            }
            thePrinter.setBusy(ThePrinterState.PRINTER_DISCONNECTING);
          }

          try {
            thePrinter.disconnect();
            callback.onSuccess(EscPosPrinterErrorManager.getCodeText(POS_SUCCESS));
          } catch (Epos2Exception e) {
            String errorString = EscPosPrinterErrorManager.getEposExceptionText(e.getErrorStatus());
            callback.onError(errorString);
          }
        } catch(Exception e) {
          callback.onError(e.getMessage());
        }
    }

    synchronized public void setBusy(@NonNull final String objectid, ThePrinterState state) {
        ThePrinter thePrinter = thePrinterManager_.getObject(objectid);

        if (thePrinter == null) {
            return;
        }

        thePrinter.setBusy(state);
    }

    synchronized public boolean isPrinterBusy(@NonNull final String objectid) {

        ThePrinter thePrinter = thePrinterManager_.getObject(objectid);

        if (thePrinter == null) {
            return false;
        }

        return thePrinter.isPrinterBusy();
    }


    /**
     Returns void
     Function handleStatusMonitorResult is used to inform the UI that the Status real time monitor has started/stop success/failed
     please handle in your app
     @param printerTarget String the object hash key
     @param method String the method that called function
     @param hasError boolean if failer has happened will be true
     @param error String the error message
     */
    void handleStatusMonitorResult(String printerTarget, String method, boolean hasError, String error)
    {

        if (method.startsWith("onPrinterStartStatusMonitorResult")) { // Status Monitor Start success/failer

            new Thread (() -> {
                synchronized (delegateSync_) {
                    if (delegate_ != null) delegate_.onPrinterStartStatusMonitorResult(printerTarget, hasError, error);
                }
            }).start();

            return;
        }

        if (method.startsWith("onPrinterStopStatusMonitorResult")) { // Status Monitor Stop success/failer
            new Thread (() -> {
                synchronized (delegateSync_) {
                    if (delegate_ != null) delegate_.onPrinterStopStatusMonitorResult(printerTarget, hasError, error);
                }
            }).start();
        }
    }

    // region Printer Object API
    /**
     Returns ePOS result int
     @param printerTarget the printer target
     @return int ePOS result
     */
    synchronized public int beginTransaction(@NonNull final String printerTarget) {

        ThePrinter thePrinter = thePrinterManager_.getObject(printerTarget);
       if (thePrinter == null)  return Epos2Exception.ERR_MEMORY;

        try {
            thePrinter.beginTransaction();
        } catch (Epos2Exception e) {
            e.printStackTrace();
            return ((Epos2Exception) e).getErrorStatus();
        }

        return POS_SUCCESS;

    }

    synchronized public int addTextAlign(@NonNull final String printerTarget, final int align)  {

        ThePrinter thePrinter = thePrinterManager_.getObject(printerTarget);
        if (thePrinter == null) return Epos2Exception.ERR_MEMORY;

        Printer printer = thePrinter.getEpos2Printer();
        if (printer == null) return Epos2Exception.ERR_MEMORY;

        try {
            printer.addTextAlign(align);
        } catch (Epos2Exception e) {
            e.printStackTrace();
            return ((Epos2Exception) e).getErrorStatus();
        }

        return POS_SUCCESS;

    }

    synchronized public int addImage(@NonNull final String printerTarget, @NonNull Bitmap data, int x, int y, int width, int height, int color, int mode, int halftone, double brightness, int compress) {

        ThePrinter thePrinter = thePrinterManager_.getObject(printerTarget);
        if (thePrinter == null) return Epos2Exception.ERR_MEMORY;

        Printer printer = thePrinter.getEpos2Printer();
        if (printer == null) return Epos2Exception.ERR_MEMORY;

        try {
            printer.addImage(data, x, y, width, height, color, mode, halftone, brightness, compress);
        } catch (Epos2Exception e) {
            e.printStackTrace();
            return ((Epos2Exception) e).getErrorStatus();
        }

        return POS_SUCCESS;

    }

    synchronized public int addFeedLine(@NonNull final String printerTarget, int line) {

        ThePrinter thePrinter = thePrinterManager_.getObject(printerTarget);
        if (thePrinter == null) return Epos2Exception.ERR_MEMORY;

        Printer printer = thePrinter.getEpos2Printer();
        if (printer == null) return Epos2Exception.ERR_MEMORY;

        try {
            printer.addFeedLine(line);
        } catch (Epos2Exception e) {
            e.printStackTrace();
            return ((Epos2Exception) e).getErrorStatus();
        }

        return POS_SUCCESS;

    }

    synchronized public int addText(@NonNull final String printerTarget, @NonNull String data)  {
        ThePrinter thePrinter = thePrinterManager_.getObject(printerTarget);
        if (thePrinter == null) return Epos2Exception.ERR_MEMORY;

        Printer printer = thePrinter.getEpos2Printer();
        if (printer == null) return Epos2Exception.ERR_MEMORY;

        try {
            printer.addText(data);
        } catch (Epos2Exception e) {
            e.printStackTrace();
            return ((Epos2Exception) e).getErrorStatus();
        }

        return POS_SUCCESS;

    }

    synchronized public int addTextSize(@NonNull final String printerTarget, int width, int height) {
        ThePrinter thePrinter = thePrinterManager_.getObject(printerTarget);
        if (thePrinter == null) return Epos2Exception.ERR_MEMORY;

        Printer printer = thePrinter.getEpos2Printer();
        if (printer == null) return Epos2Exception.ERR_MEMORY;

        try {
            printer.addTextSize(width, height);
        } catch (Epos2Exception e) {
            e.printStackTrace();
            return ((Epos2Exception) e).getErrorStatus();
        }

        return POS_SUCCESS;
    }

    synchronized public int addBarcode(@NonNull final String printerTarget, String data, int type, int hri, int font, int width, int height)  {

        ThePrinter thePrinter = thePrinterManager_.getObject(printerTarget);
        if (thePrinter == null) return Epos2Exception.ERR_MEMORY;

        Printer printer = thePrinter.getEpos2Printer();
        if (printer == null) return Epos2Exception.ERR_MEMORY;

        try {
            printer.addBarcode(data, type, hri, font, width, height);
        } catch (Epos2Exception e) {
            e.printStackTrace();
            return ((Epos2Exception) e).getErrorStatus();
        }

        return POS_SUCCESS;

    }

    synchronized public int addCut(@NonNull final String printerTarget, int type) {

        ThePrinter thePrinter = thePrinterManager_.getObject(printerTarget);
        if (thePrinter == null) return Epos2Exception.ERR_MEMORY;

        Printer printer = thePrinter.getEpos2Printer();
        if (printer == null) return Epos2Exception.ERR_MEMORY;

        try {
            printer.addCut(type);
        } catch (Epos2Exception e) {
            e.printStackTrace();
            return ((Epos2Exception) e).getErrorStatus();
        }

        return POS_SUCCESS;
    }

    synchronized public int clearCommandBuffer(@NonNull final String printerTarget)  {

        ThePrinter thePrinter = thePrinterManager_.getObject(printerTarget);
        if (thePrinter == null) return Epos2Exception.ERR_MEMORY;

        Printer printer = thePrinter.getEpos2Printer();
        if (printer == null) return Epos2Exception.ERR_MEMORY;

        printer.clearCommandBuffer();

        return POS_SUCCESS;
    }

    synchronized public int endTransaction(@NonNull final String printerTarget)  {
        ThePrinter thePrinter = thePrinterManager_.getObject(printerTarget);
        if (thePrinter == null) return Epos2Exception.ERR_MEMORY;

        try {
            thePrinter.endTransaction();
        } catch (Epos2Exception e) {
            e.printStackTrace();
            return ((Epos2Exception) e).getErrorStatus();
        }

        return POS_SUCCESS;

    }

    public PrinterStatusInfo getPrinterStatus(@NonNull final String printerTarget) {

        PrinterStatusInfo dummyInfo = new PrinterStatusInfo();
        Printer eposPrinter = null;

        synchronized (this) {
            ThePrinter thePrinter = thePrinterManager_.getObject(printerTarget);
            if (thePrinter == null) return dummyInfo;

            eposPrinter = thePrinter.getEpos2Printer();

            if (eposPrinter == null) return dummyInfo;
        }

        return eposPrinter.getStatus();

    }

    synchronized public int getPrinterSetting(@NonNull final String printerTarget, int timeout, int type)  {
        ThePrinter thePrinter = thePrinterManager_.getObject(printerTarget);
        if (thePrinter == null) return Epos2Exception.ERR_MEMORY;

        try {
            thePrinter.getPrinterSetting(timeout, type);
        } catch (Epos2Exception e) {
            e.printStackTrace();
            return ((Epos2Exception) e).getErrorStatus();
        }

        return POS_SUCCESS;

    }

    @ReactMethod
    public void printBuffer(ReadableArray printBuffer, final String target, final ReadableMap paramsMap, Promise promise) {
        tasksQueue.submit(new Runnable() {
        @Override
        public void run() {
            printFromBuffer(printBuffer, target, paramsMap, new MyCallbackInterface() {
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

    public void printFromBuffer(ReadableArray printBuffer, final String target, final ReadableMap paramsMap, MyCallbackInterface callback) {
        try {
          ThePrinter thePrinter = thePrinterManager_.getObject(target);
          if (thePrinter == null) {
            String errorString = EscPosPrinterErrorManager.getEposExceptionText(Epos2Exception.ERR_MEMORY);
            callback.onError(errorString);
            return;
          }

          Printer printer = thePrinter.getEpos2Printer();
          if (printer == null) {
            String errorString = EscPosPrinterErrorManager.getEposExceptionText(Epos2Exception.ERR_MEMORY);
            callback.onError(errorString);
            return;
          }

          try {
            printer.clearCommandBuffer();
            int bufferLength = printBuffer.size();
            for (int curr = 0; curr < bufferLength; curr++) {
              ReadableArray command = printBuffer.getArray(curr);
              handleCommand(command.getInt(0), command.getArray(1), target);
            }
          } catch (Epos2Exception e) {
            printer.clearCommandBuffer();
            int status = EscPosPrinterErrorManager.getErrorStatus(e);
            String errorString = EscPosPrinterErrorManager.getEposExceptionText(status);
            callback.onError(errorString);
            return;
          } catch (IOException e) {
            printer.clearCommandBuffer();
            callback.onError(e.getMessage());
            return;
          }

          try {
            this.printData(paramsMap, target);
            String successString = EscPosPrinterErrorManager.getCodeText(Epos2CallbackCode.CODE_SUCCESS);
            callback.onSuccess(successString);
          } catch (Epos2Exception e) {
            int status = EscPosPrinterErrorManager.getErrorStatus(e);
            String errorString = EscPosPrinterErrorManager.getEposExceptionText(status);
            callback.onError(errorString);
          }

        } catch (Exception e) {
          callback.onError(e.getMessage());
        }
  }
    synchronized public int sendData(@NonNull final String objectid, int timeout) {
        ThePrinter thePrinter = thePrinterManager_.getObject(objectid);
        if (thePrinter == null) return Epos2Exception.ERR_MEMORY;

        Printer printer = thePrinter.getEpos2Printer();
        if (printer == null) return Epos2Exception.ERR_MEMORY;

        thePrinter.setBusy(ThePrinterState.PRINTER_PRINTING);

        try {
            printer.sendData(timeout);
        } catch (Epos2Exception e) {
            e.printStackTrace();
            return ((Epos2Exception) e).getErrorStatus();
        }

        return POS_SUCCESS;

    }
    // endregion

    // region PrinterDelegate


    /**
     Returns void
     Function onPrinterStartStatusMonitorResult informs that Start Status monitor has been successfull/failed.
     @param printerTarget String the printer target
     @param hasError boolean if the status has failed will be false
     @param error String contains why start failed
     */
    @Override
    public void onPrinterStartStatusMonitorResult(@NonNull String printerTarget, boolean hasError, String error) {
        handleStatusMonitorResult(printerTarget, "onPrinterStartStatusMonitorResult", hasError, error);
    }

    /**
     Returns void
     Function onPrinterStopStatusMonitorResult informs that Stop Status monitor has been successful/failed.
     @param printerTarget String the object hash key
     @param hasError boolean if the status has failed will be false
     @param error String contains why stop failed
     */
    @Override
    public void onPrinterStopStatusMonitorResult(@NonNull String printerTarget, boolean hasError, String error) {
        handleStatusMonitorResult(printerTarget, "onPrinterStopStatusMonitorResult", hasError, error);
    }

    /**
     Returns void
     Function onPrinterStatusChange informs the UI that the printer status has changed
     @param printerTarget String the printer target
     @param status int new status
     */
    @Override
    public void onPrinterStatusChange(@NonNull String printerTarget, int status) {

        new Thread (() -> {
            synchronized (delegateSync_) {
                if (delegate_ != null) delegate_.onPrinterStatusChange(printerTarget, status);
            }
        }).start();
    }

    /**
     Returns void
     Function onGetPrinterSetting informs the UI of the printer settings that where requested
     @param printerTarget String the printer target
     @param code int ePOS result
     @param type int ePOS Settings Type -- EPOS2_PRINTER_SETTING_PAPERWIDTH
     @param value int ePOS value -- Printer.SETTING_PAPERWIDTH_58_0
     */
    @Override
    public void onGetPrinterSetting(@NonNull String printerTarget, int code, int type, int value) {

        new Thread (() -> {
            synchronized (delegateSync_) {
                if (delegate_ != null) delegate_.onGetPrinterSetting(printerTarget, code, type, value);
            }
        }).start();

    }

    /**
     Returns void
     Function onPtrReceive informs the UI of the status of the print job that was received
     @param printerTarget String the printer target
     @param data JSONObject storing the result
     */
    @Override
    public void onPtrReceive(@NonNull String printerTarget, @NonNull JSONObject data) {
        new Thread (() -> {
            synchronized (delegateSync_) {
                if (delegate_ != null) delegate_.onPtrReceive(printerTarget, data);
            }
        }).start();
    }

    @Override
    synchronized public Context getContext() {
        return context_;
    }

    private void handleCommand(int command, ReadableArray params, String target) throws Exception {
        Printer printer = thePrinterManager_.getObject(target).getEpos2Printer();
        switch (command) {
            case PrintingCommands.COMMAND_ADD_TEXT:
                printer.addText(params.getString(0));
                break;
            case PrintingCommands.COMMAND_ADD_PULSE:
                printer.addPulse(params.getInt(0), Printer.PARAM_DEFAULT);
                break;
            case PrintingCommands.COMMAND_ADD_NEW_LINE:
                printer.addFeedLine(params.getInt(0));
                break;
            case PrintingCommands.COMMAND_ADD_TEXT_STYLE:
                printer.addTextStyle(Printer.FALSE, params.getInt(0), params.getInt(1), Printer.COLOR_1);
                break;
            case PrintingCommands.COMMAND_ADD_TEXT_SIZE:
                printer.addTextSize(params.getInt(0), params.getInt(1));
                break;
            case PrintingCommands.COMMAND_ADD_ALIGN:
                printer.addTextAlign(params.getInt(0));
                break;

            case PrintingCommands.COMMAND_ADD_IMAGE:
                ReadableMap source = params.getMap(0);

                int imgWidth = params.getInt(1);
                int color = params.getInt(2);
                int mode = params.getInt(3);
                int halftone = params.getInt(4);
                double brightness = params.getDouble(5);
                Bitmap imgBitmap = getBitmapFromSource(source);
                handlePrintImage(imgBitmap, imgWidth, color, mode, halftone, brightness, printer);

            break;
            case PrintingCommands.COMMAND_ADD_IMAGE_BASE_64:
                String uriString = params.getString(0);
                final String pureBase64Encoded = uriString.substring(uriString.indexOf(",") + 1);
                byte[] decodedString = Base64.decode(pureBase64Encoded, Base64.DEFAULT);
                Bitmap bitmap = BitmapFactory.decodeByteArray(decodedString, 0, decodedString.length);
                int inputWidth = params.getInt(1);

                handlePrintImage(bitmap, inputWidth, Printer.COLOR_1, Printer.MODE_MONO, Printer.HALFTONE_DITHER, Printer.PARAM_DEFAULT, printer);
                break;

            case PrintingCommands.COMMAND_ADD_IMAGE_ASSET:
                String imageName = params.getString(0);
                int width = params.getInt(1);

                AssetManager assetManager = context_.getAssets();
                InputStream inputStream = assetManager.open(params.getString(0));
                Bitmap assetBitmap = BitmapFactory.decodeStream(inputStream);
                inputStream.close();
                handlePrintImage(assetBitmap, width, Printer.COLOR_1, Printer.MODE_MONO, Printer.HALFTONE_DITHER, Printer.PARAM_DEFAULT, printer);
                break;
            case PrintingCommands.COMMAND_ADD_CUT:
                printer.addCut(Printer.CUT_FEED);
                break;
            case PrintingCommands.COMMAND_ADD_DATA:
                String base64String = params.getString(0);
                byte[] data = Base64.decode(base64String, Base64.DEFAULT);
                printer.addCommand(data);
                break;
            case PrintingCommands.COMMAND_ADD_TEXT_SMOOTH:
                printer.addTextSmooth(params.getInt(0));
                break;
            case PrintingCommands.COMMAND_ADD_BARCODE:
                printer.addBarcode(params.getString(0), params.getInt(1), params.getInt(2), Printer.FONT_A, params.getInt(3), params.getInt(4));
                break;
            case PrintingCommands.COMMAND_ADD_QRCODE:
                printer.addSymbol(params.getString(0), params.getInt(1), params.getInt(2), params.getInt(3), params.getInt(3), params.getInt(3));
                break;
            default:
                throw new IllegalArgumentException("Invalid Printing Command");
        }
  }

  private void handlePrintImage(Bitmap bitmap, int width, int color, int mode, int halftone, double brightness, Printer printer) throws Epos2Exception {
    float aspectRatio = bitmap.getWidth() / (float) bitmap.getHeight();
    int newHeight = Math.round(width / aspectRatio);
    bitmap = Bitmap.createScaledBitmap(bitmap, width, newHeight, false);

    printer.addImage(
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

        int resourceId = context_.getResources().getIdentifier(uriString, "drawable", context_.getPackageName());
        Bitmap image = BitmapFactory.decodeResource(context_.getResources(), resourceId);

        return image;
    }

    private void printData(final ReadableMap paramsMap, final String target) throws Epos2Exception {
        int timeout = Printer.PARAM_DEFAULT;
        if(paramsMap != null && paramsMap.hasKey("timeout")) {
            timeout = paramsMap.getInt("timeout");
        }
        Printer printer = thePrinterManager_.getObject(target).getEpos2Printer();
        printer.sendData(timeout);
    }

}
