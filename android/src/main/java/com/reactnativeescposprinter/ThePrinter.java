package com.escposprinter;

import com.epson.epos2.Epos2Exception;
import com.epson.epos2.printer.Printer;
import com.epson.epos2.printer.PrinterSettingListener;
import com.epson.epos2.printer.PrinterStatusInfo;
import com.epson.epos2.printer.ReceiveListener;
import com.epson.epos2.printer.StatusChangeListener;
import com.epson.epos2.Epos2CallbackCode;

import com.escposprinter.PrinterDelegate;
import com.escposprinter.EposStringHelper;
import com.escposprinter.PrinterCallback;
import com.escposprinter.ImageManager;

import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.bridge.Arguments;

import android.content.Context;
import android.graphics.Bitmap;
import android.util.Base64;

public class ThePrinter implements PrinterSettingListener, ReceiveListener {

    private Printer epos2Printer_ = null; // Printer
    private volatile String printerTarget_ = null; // the printer target
    private boolean isConnected_ = false; // cache if printer is connected
    private boolean didBeginTransaction_ = false; // did start Status Monitor
    private static final int DISCONNECT_INTERVAL = 500;//millseconds

    private PrinterCallback printCallback_ = null; // callback
    private PrinterCallback getPrinterSettingCallback_ = null; // callback

    /**
     * Returns ThePrinter
     * Use to create ThePrinter object
     */
    public ThePrinter() {

    }

    /**
     * Dealloc ThePrinter
     */
    public void finalize() {
        printerTarget_ = null;
    }

    /**
     Returns void
     function initWith Will create a new printer with settings given
     @param printerTarget the target for the printer  -- deviceInfo.target
     @param series the printer series -- EPOS2_TM_M30II
     @param lang the printer language -- EPOS2_MODEL_ANK
     @param callback delegate callbacks
     returns void
     */
    synchronized public void setupWith(final String printerTarget, final int series, final int lang, Context context) throws Epos2Exception {
        printerTarget_ = printerTarget;
        epos2Printer_ = new Printer(series, lang, context);
        epos2Printer_.setReceiveEventListener(this);
    }


    /**
     Returns String
     Function getPrinterTarget retrieves the printer target set from initWith.
     @return String containing printer target
     */
    public String getPrinterTarget() {
        return printerTarget_;
    }

    /**
     Returns BOOL
     Function isConnected uses getStatus to understand if it is connected or not.
     @return bool -- returns true if connected
     */
     synchronized public boolean isConnected()
    {
        // check to see if we are actually connected

        if (epos2Printer_ == null) return false;

        boolean isConnected = true;
        PrinterStatusInfo info = epos2Printer_.getStatus();
        if (info.getConnection() == Printer.TRUE) {
            isConnected = true;
        } else {
            isConnected = false;
        }

        return isConnected;
    }

    /**
     throws Epos2Exception if there is an error
     Function connect tries to connect selected printer
     @param timeout the amount of time before giving up -- EPOS2_PARAM_DEFAULT
     */
    public void connect(final int timeout) throws Epos2Exception {

        synchronized (this) {
            if (epos2Printer_ == null) throw new Epos2Exception(Epos2Exception.ERR_MEMORY);
            if (printerTarget_ == null || printerTarget_.isEmpty())
                throw new Epos2Exception(Epos2Exception.ERR_MEMORY);

            if (isConnected_) {
                return;
            }

            isConnected_ = false;

            try {
                epos2Printer_.connect(printerTarget_, timeout);
                isConnected_ = true;
            } catch (Epos2Exception e) {
                e.printStackTrace();
                isConnected_ = false;
                throw e;
            }
        }
    }

    /**
     throws Epos2Exception if there is an error
     Function disconnect tries to disconnect selected printer
     */
    synchronized public void disconnect() throws Epos2Exception {

        if (epos2Printer_ == null) throw new Epos2Exception(Epos2Exception.ERR_MEMORY);

        if (!isConnected_) return;

        if (didBeginTransaction_) {
            try {
                endTransaction();
            } catch (Epos2Exception e) {
                e.printStackTrace();
            }
        }

        int count = 20;
        while (true) {
            try {
                epos2Printer_.disconnect();
                break;
            } catch (final Exception e) {
                if (e instanceof Epos2Exception) {
                    //Note: If printer is processing such as printing and so on, the disconnect API returns ERR_PROCESSING.
                    if (((Epos2Exception) e).getErrorStatus() == Epos2Exception.ERR_PROCESSING) {
                        count--;
                        try {
                           Thread.sleep(DISCONNECT_INTERVAL);
                        } catch (Exception ignored) {
                        }
                    } else {
                      if(((Epos2Exception) e).getErrorStatus() != Epos2Exception.ERR_ILLEGAL) {
                         throw e;
                      }
                    }
                }
            }
            if (count == 0) {
                throw new Epos2Exception(Epos2Exception.ERR_DISCONNECT);
            }
        }

        epos2Printer_.clearCommandBuffer();
        isConnected_ = false;
        didBeginTransaction_ = false;

    }

    synchronized public void clearCommandBuffer() throws Epos2Exception {
      if (epos2Printer_ == null) throw new Epos2Exception(Epos2Exception.ERR_MEMORY);

      epos2Printer_.clearCommandBuffer();
    }

    synchronized public void sendData(int timeout, PrinterCallback handler) throws Epos2Exception {
        if (epos2Printer_ == null) throw new Epos2Exception(Epos2Exception.ERR_MEMORY);

        beginTransaction();
        try {
           epos2Printer_.sendData(timeout);
           printCallback_ = handler;
        } catch (Epos2Exception e) {
           endTransaction();
           throw e;
        }

    }

    /**
     throws Epos2Exception if there is an error
     Function beginTransaction see ePOS SDK
     */
    synchronized public void beginTransaction() throws Epos2Exception {
        if (epos2Printer_ == null) throw new Epos2Exception(Epos2Exception.ERR_MEMORY);

        if (didBeginTransaction_) return;

        try {
            epos2Printer_.beginTransaction();
            didBeginTransaction_  = true;
        } catch (Epos2Exception e) {
            didBeginTransaction_ = false;
            e.printStackTrace();
            throw e;
        }
    }

    /**
     throws Epos2Exception if there is an error
     Function endTransaction see ePOS SDK
     */
    synchronized public void endTransaction() throws Epos2Exception {

        if (epos2Printer_ == null) throw new Epos2Exception(Epos2Exception.ERR_MEMORY);

        if (!didBeginTransaction_) return;

        try {
            epos2Printer_.endTransaction();
            didBeginTransaction_  = false;
        } catch (Epos2Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    synchronized public void addText(String data) throws Epos2Exception {
        if (epos2Printer_ == null) throw new Epos2Exception(Epos2Exception.ERR_MEMORY);

        epos2Printer_.addText(data);
    }


    synchronized public void addTextLang(int lang) throws Epos2Exception {
        if (epos2Printer_ == null) throw new Epos2Exception(Epos2Exception.ERR_MEMORY);

        epos2Printer_.addTextLang(lang);
    }

    synchronized public void addFeedLine(int line) throws Epos2Exception {
      if (epos2Printer_ == null) throw new Epos2Exception(Epos2Exception.ERR_MEMORY);

      epos2Printer_.addFeedLine(line);
    }

    synchronized public void addLineSpace(int linespc) throws Epos2Exception {
      if (epos2Printer_ == null) throw new Epos2Exception(Epos2Exception.ERR_MEMORY);

      epos2Printer_.addLineSpace(linespc);
    }

    synchronized public void addCut(int type) throws Epos2Exception {
      if (epos2Printer_ == null) throw new Epos2Exception(Epos2Exception.ERR_MEMORY);

      epos2Printer_.addCut(type);
    }

    synchronized public void addCommand(String base64string) throws Epos2Exception {
      if (epos2Printer_ == null) throw new Epos2Exception(Epos2Exception.ERR_MEMORY);

      byte[] data = Base64.decode(base64string, Base64.DEFAULT);
      epos2Printer_.addCommand(data);
    }

    synchronized public void addPulse(int drawer, int time) throws Epos2Exception {
      if (epos2Printer_ == null) throw new Epos2Exception(Epos2Exception.ERR_MEMORY);

      epos2Printer_.addPulse(drawer, time);
    }

    synchronized public void addTextAlign(int align) throws Epos2Exception {
      if (epos2Printer_ == null) throw new Epos2Exception(Epos2Exception.ERR_MEMORY);

      epos2Printer_.addTextAlign(align);
    }

    synchronized public void addTextSize(int width, int height) throws Epos2Exception {
      if (epos2Printer_ == null) throw new Epos2Exception(Epos2Exception.ERR_MEMORY);

      epos2Printer_.addTextSize(width, height);
    }

    synchronized public void addTextSmooth(int smooth) throws Epos2Exception {
      if (epos2Printer_ == null) throw new Epos2Exception(Epos2Exception.ERR_MEMORY);

      epos2Printer_.addTextSmooth(smooth);
    }

    synchronized public void addTextStyle(int reverse, int ul, int em, int color) throws Epos2Exception {
      if (epos2Printer_ == null) throw new Epos2Exception(Epos2Exception.ERR_MEMORY);

      epos2Printer_.addTextStyle(reverse, ul, em, color);
    }

    synchronized public void addImage(ReadableMap source, Context mContext, int width, int color,
                                      int mode, int halftone, double brightness, int compress) throws Epos2Exception {
      if (epos2Printer_ == null) throw new Epos2Exception(Epos2Exception.ERR_MEMORY);

      Bitmap bitmap = null;

      try {
        bitmap = ImageManager.getBitmapFromSource(source, mContext);
      } catch (Exception e) {
        throw new Epos2Exception(Epos2Exception.ERR_MEMORY);
      }

      float aspectRatio = bitmap.getWidth() / (float) bitmap.getHeight();
      int newHeight = Math.round(width / aspectRatio);
      bitmap = Bitmap.createScaledBitmap(bitmap, width, newHeight, false);

      epos2Printer_.addImage(bitmap, 0, 0, width, newHeight, color, mode, halftone, brightness, compress);

    }

    synchronized public void addBarcode(String data, int type, int hri, int font, int width, int height) throws Epos2Exception {
      if (epos2Printer_ == null) throw new Epos2Exception(Epos2Exception.ERR_MEMORY);

      epos2Printer_.addBarcode(data, type, hri, font, width, height);
    }

    synchronized public void addSymbol(String data, int type, int level, int width, int height, int size) throws Epos2Exception {
      if (epos2Printer_ == null) throw new Epos2Exception(Epos2Exception.ERR_MEMORY);

      epos2Printer_.addSymbol(data, type, level, width, height, size);
    }

    synchronized public WritableMap getStatus() throws Epos2Exception {
      if (epos2Printer_ == null) throw new Epos2Exception(Epos2Exception.ERR_MEMORY);
      PrinterStatusInfo status = epos2Printer_.getStatus();
      WritableMap statusMap = EposStringHelper.convertStatusInfoToWritableMap(status);
      return statusMap;
    }

  /**
     throws Epos2Exception if there is an error
     Function getPrinterSetting see ePOS SDK
     */
    synchronized public void getPrinterSetting(int timeout, int type, PrinterCallback handler) throws Epos2Exception {
        if (epos2Printer_ == null) throw new Epos2Exception(Epos2Exception.ERR_MEMORY);

        beginTransaction();
        try {
            epos2Printer_.getPrinterSetting(timeout, type, this);
            getPrinterSettingCallback_ = handler;
        } catch (Epos2Exception e) {
            endTransaction();
            throw e;
        }
    }

    /**
     returns Printer
     Function getEpos2Printer
     */
    synchronized public Printer getEpos2Printer()
    {
        return epos2Printer_;
    }

    @Override
    public void onGetPrinterSetting(int code, int type, int value) {

        new Thread(new Runnable() {
            @Override
            synchronized public void run() {
                try {
                    endTransaction();
                } catch (Exception e) {
                    e.printStackTrace();
                }
                if (getPrinterSettingCallback_ != null) {
                  if(code == Epos2CallbackCode.CODE_SUCCESS) {
                   WritableMap returnData = Arguments.createMap();
                    returnData.putInt("type", type);
                    returnData.putInt("value",value);

                    getPrinterSettingCallback_.onSuccess(returnData);
                  } else {
                    getPrinterSettingCallback_.onError(EposStringHelper.getErrorTextData(code, "code"));
                  }
                  getPrinterSettingCallback_ = null;
                }
            }
        }).start();
    }

    // region ReceiveListener
    @Override
    public void onPtrReceive(Printer printer, int code, PrinterStatusInfo status, String printJobId) {

        new Thread(new Runnable() {
            @Override
            synchronized public void run() {
                try {
                    endTransaction();
                } catch (Exception e) {
                    e.printStackTrace();
                }
                if (printCallback_ != null) {
                  if(code == Epos2CallbackCode.CODE_SUCCESS) {
                    WritableMap returnData = EposStringHelper.convertStatusInfoToWritableMap(status);
                    printCallback_.onSuccess(returnData);
                  } else {
                    printCallback_.onError(EposStringHelper.getErrorTextData(code, "code"));
                  }
                  printCallback_ = null;
                }
            }
        }).start();

    }


    @Override
    public void onSetPrinterSetting(int code) {

    }

}
