package com.reactnativeescposprinter;

import com.epson.epos2.Epos2Exception;
import com.epson.epos2.printer.Printer;
import com.epson.epos2.printer.PrinterSettingListener;
import com.epson.epos2.printer.PrinterStatusInfo;
import com.epson.epos2.printer.ReceiveListener;
import com.epson.epos2.printer.StatusChangeListener;

import com.reactnativeescposprinter.ThePrinterState;
import com.reactnativeescposprinter.PrinterDelegate;
import com.reactnativeescposprinter.EposStringHelper;

import org.json.JSONException;
import org.json.JSONObject;

public class ThePrinter implements StatusChangeListener, PrinterSettingListener, ReceiveListener {

    private Printer epos2Printer_ = null; // Printer
    private volatile String printerTarget_ = null; // the printer target
    private boolean isConnected_ = false; // cache if printer is connected
    private boolean didStartMonitor_ = false;  // did start transactions
    private boolean didBeginTransaction_ = false; // did start Status Monitor
    private boolean isWaitingForPrinterSettings_ = false; // Printer Settings requested
    private boolean shutdown_ = false; // removing printer object
    private static final int DISCONNECT_INTERVAL = 500;//millseconds
    private final Object shutdownLock_ = new Object(); // removing printer object
    final private Object delegateSync_ = new Object(); //. delegate sync

    private ThePrinterState connectingState_ = ThePrinterState.PRINTER_IDLE; // state of connection

    private PrinterDelegate delegate_ = null; // delegate callback

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
    synchronized public void setupWith(final String printerTarget, final int series, final int lang, final PrinterDelegate callback) throws Epos2Exception {

        connectingState_ = ThePrinterState.PRINTER_IDLE;
        synchronized (delegateSync_) {
            delegate_ = callback;
        }
        printerTarget_ = printerTarget;
        epos2Printer_ = new Printer(series, lang, callback.getContext());
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
    * Returns void
    * Function setBusy set the busy state of the printer
    * @param busy set ThePrinterState
    * * */
    synchronized public void setBusy(ThePrinterState busy)
    {
        connectingState_ = busy;
    }

    /**
     Returns void
     Function removeDelegates removes all delegate callbacks.  Used when tring to remove object
     */
    synchronized public void removeDelegates()
    {

        synchronized (delegateSync_) {
            delegate_ = null;
        }

        if (epos2Printer_ == null) return;

        epos2Printer_.setReceiveEventListener(null);
        epos2Printer_.setConnectionEventListener(null);
        epos2Printer_.setStatusChangeEventListener(null);

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
     Returns void
     Function shutdown disconnects printer and sets flag to shutdown.  Used when tring to remove object
     @param closeConnection boolean set to disconnect printer
     */
    public void shutdown(boolean closeConnection) {

        // set flag;
        synchronized (shutdownLock_) {
            if (shutdown_) return;
            shutdown_ = true;
            synchronized (delegateSync_) {
                delegate_ = null;
            }
        }

        synchronized (this) {

            // disconnect
            if (closeConnection && isConnected()) {
                try {
                    disconnect();
                } catch (Epos2Exception e) {
                    e.printStackTrace();
                }
            }
        }

    }

    /**
     Returns bool
     Function isPrinterBusy returns if printer is busy doing a long operation
     @return bool YES == printer is busy
     */
    synchronized public boolean isPrinterBusy()
    {
        boolean isBusy = false;

        // printer not in idle state
        if (connectingState_ != ThePrinterState.PRINTER_IDLE) isBusy = true;

        // waiting for printer settings to callback
        if (isWaitingForPrinterSettings_) isBusy = true;
        return isBusy;
    }

    private void handleStartStatusMonitor(final String msg, final boolean didStart) {

        synchronized (this) {
            if (epos2Printer_ == null) return;

            synchronized (delegateSync_) {
                if (delegate_ != null) {
                    delegate_.onPrinterStartStatusMonitorResult(printerTarget_, !didStart, msg);
                }
            }
        }
    }

    private void handleStopStatusMonitor(final String msg, final boolean didStop) {

        synchronized (this) {
            if (epos2Printer_ == null) return;

            synchronized (delegateSync_) {
                if (delegate_ != null) {
                    delegate_.onPrinterStopStatusMonitorResult(printerTarget_, !didStop, msg);
                }
            }
        }
    }

    /**
     throws Epos2Exception if there is an error
     Function connect tries to connect selected printer
     @param timeout the amount of time before giving up -- EPOS2_PARAM_DEFAULT
     @param startMonitor to Start the realtime statusMonitor
     */
    public void connect(final int timeout, final boolean startMonitor) throws Epos2Exception {

        synchronized (shutdownLock_) {
            if (shutdown_) throw new Epos2Exception(Epos2Exception.ERR_ILLEGAL);
        }

        synchronized (this) {
            if (epos2Printer_ == null) throw new Epos2Exception(Epos2Exception.ERR_MEMORY);
            if (printerTarget_ == null || printerTarget_.isEmpty())
                throw new Epos2Exception(Epos2Exception.ERR_MEMORY);

            if (isConnected_) {
                return;
            }

            connectingState_ = ThePrinterState.PRINTER_CONNECTING;

            isConnected_ = false;
            isWaitingForPrinterSettings_ = false;
            didStartMonitor_ = false;
            didBeginTransaction_ = false;
            try {
                epos2Printer_.connect(printerTarget_, timeout);
                isConnected_ = true;
            } catch (Epos2Exception e) {
                connectingState_ = ThePrinterState.PRINTER_IDLE;
                e.printStackTrace();
                isConnected_ = false;
                throw e;
            }

            if (!startMonitor) return;

            try {
                startMonitor();
            } catch ( Epos2Exception e) {
                e.printStackTrace();
                connectingState_ = ThePrinterState.PRINTER_IDLE;
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

        connectingState_ = ThePrinterState.PRINTER_DISCONNECTING;

        if (didBeginTransaction_) {
            try {
                endTransaction();
            } catch (Epos2Exception e) {
                e.printStackTrace();
            }
        }

        if (didStartMonitor_) {
            try {
                stopMonitor();
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
                        throw e;
                    }
                }
            }
            if (count == 0) {
                connectingState_ = ThePrinterState.PRINTER_IDLE;
                throw new Epos2Exception(Epos2Exception.ERR_DISCONNECT);
            }

            synchronized (shutdownLock_) {
                if (shutdown_) {
                    break;
                }
            }
        }

        epos2Printer_.clearCommandBuffer();
        isConnected_ = false;
        isWaitingForPrinterSettings_ = false;
        didStartMonitor_ = false;
        didBeginTransaction_ = false;
        connectingState_ = ThePrinterState.PRINTER_IDLE;

    }

    /**
     throws Epos2Exception if there is an error
     Function Start the realtime Monitor for selected printer
     */
    synchronized void startMonitor() throws Epos2Exception {

        synchronized (shutdownLock_) {
            if (shutdown_) throw new Epos2Exception(Epos2Exception.ERR_ILLEGAL);
        }

        if (didStartMonitor_) return;

        if (epos2Printer_ == null) throw new Epos2Exception(Epos2Exception.ERR_MEMORY);

        String msg = "SUCCESS";

        Epos2Exception epos2Exception = null;

        try {
            epos2Printer_.setStatusChangeEventListener(this);
            epos2Printer_.startMonitor();
            didStartMonitor_ = true;
        } catch (Epos2Exception e) {
            epos2Exception = e;
            epos2Printer_.setStatusChangeEventListener(null);
            e.printStackTrace();
            msg = EposStringHelper.getEposExceptionText(e.getErrorStatus());

            didStartMonitor_ = false;
        }

        handleStartStatusMonitor(msg, didStartMonitor_);
        if (epos2Exception != null) throw epos2Exception;

    }

    /**
     throws Epos2Exception if there is an error
     Function Stops the realtime Monitor for selected printer
     */
    synchronized void stopMonitor() throws Epos2Exception {

        if (epos2Printer_ == null) throw new Epos2Exception(Epos2Exception.ERR_MEMORY);

        if (!didStartMonitor_) return;

        Epos2Exception epos2Exception = null;

        String msg = "SUCCESS";

        try {
            epos2Printer_.setStatusChangeEventListener(null);
            epos2Printer_.stopMonitor();
            didStartMonitor_ = false;
        } catch (Epos2Exception e) {
            msg = EposStringHelper.getEposExceptionText(e.getErrorStatus());
            epos2Exception = e;
            e.printStackTrace();
        }

        handleStopStatusMonitor(msg, !didStartMonitor_);

        if (epos2Exception != null) throw epos2Exception;

    }

    /**
     throws Epos2Exception if there is an error
     Function beginTransaction see ePOS SDK
     */
    synchronized public void beginTransaction() throws Epos2Exception {

        synchronized (shutdownLock_) {
            if (shutdown_) throw new Epos2Exception(Epos2Exception.ERR_ILLEGAL);
        }

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

    /**
     throws Epos2Exception if there is an error
     Function getPrinterSetting see ePOS SDK
     */
    synchronized public void getPrinterSetting(int timeout, int type) throws Epos2Exception {

        synchronized (shutdownLock_) {
            if (shutdown_) throw new Epos2Exception(Epos2Exception.ERR_ILLEGAL);
        }

        if (epos2Printer_ == null) throw new Epos2Exception(Epos2Exception.ERR_MEMORY);

        if (!isConnected_) {
            throw new Epos2Exception(Epos2Exception.ERR_CONNECT);
        }

        // still waiting for previous attempt
        if (isWaitingForPrinterSettings_) {
            throw new Epos2Exception(Epos2Exception.ERR_PROCESSING);
        }

        if (delegate_ == null) {
            throw new Epos2Exception(Epos2Exception.ERR_PARAM);
        }

        isWaitingForPrinterSettings_ = true;
        epos2Printer_.getPrinterSetting(timeout, type, this);
    }

    /**
     returns Printer
     Function getEpos2Printer
     */
    synchronized public Printer getEpos2Printer()
    {
        return epos2Printer_;
    }


    // region StatusChangeListener
    @Override
    public void onPtrStatusChange(Printer printer, int eventType) {

        String _objID = Integer.toString(this.hashCode());
        if (connectingState_ == ThePrinterState.PRINTER_CONNECTING)
            connectingState_ = ThePrinterState.PRINTER_IDLE;

        synchronized (shutdownLock_) {
            if (shutdown_) return;
        }

        new Thread(new Runnable() {
            @Override
            public void run() {
                synchronized (delegateSync_) {
                    if (delegate_ != null) delegate_.onPrinterStatusChange(_objID, eventType);
                }
            }
        }).start();

    }
    // endregion

    // region PrinterSettingListener
    @Override
    public void onGetPrinterSetting(int code, int type, int value) {

        String _objID = Integer.toString(this.hashCode());

        synchronized (shutdownLock_) {
            if (shutdown_) {
                isWaitingForPrinterSettings_ = false;
                return;
            }
        }


        new Thread(new Runnable() {
            @Override
            public void run() {

                synchronized (delegateSync_) {
                    if (delegate_ != null) delegate_.onGetPrinterSetting(_objID , code, type, value);
                }
                isWaitingForPrinterSettings_ = false;
            }
        }).start();
    }

    @Override
    public void onSetPrinterSetting(int code) {

    }
    // endregion

    // region ReceiveListener
    @Override
    public void onPtrReceive(Printer printer, int code, PrinterStatusInfo status, String printJobId) {

        synchronized (shutdownLock_) {
            if (shutdown_) {
                connectingState_ = ThePrinterState.PRINTER_IDLE;
                return;
            }
        }

        String _objID = Integer.toString(this.hashCode());

        if (printJobId == null) {
            printJobId = "";
        }

        // store result of printing
        JSONObject returnData = new JSONObject();
        try {
            returnData.put("ResultRawCode", code);
            returnData.put("ResultCode", EposStringHelper.getEposResultText(code));
            returnData.put("ResultStatus", EposStringHelper.makeStatusMessage(status));
            returnData.put("printJobId", printJobId);

        } catch (JSONException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        new Thread(new Runnable() {
            @Override
            synchronized public void run() {
                synchronized (delegateSync_) {
                    if (delegate_ != null) {
                        delegate_.onPtrReceive(_objID, returnData);
                    } else {
                        connectingState_ = ThePrinterState.PRINTER_IDLE;
                    }
                }
            }
        }).start();

    }
    // endregion
}
