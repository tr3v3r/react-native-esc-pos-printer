package com.escposprinter;

import android.util.ArrayMap;
import android.util.Log;
import com.escposprinter.ThePrinter;

public class ThePrinterManager {

    static final private ArrayMap<String, ThePrinter> objectDict_ = new ArrayMap<>();

    private static ThePrinterManager instance = null;

    private ThePrinterManager() {
        // Exists only to defeat instantiation.
    }

    synchronized public static ThePrinterManager getInstance() {
        if (instance == null) {
            instance = new ThePrinterManager();
        }

        return instance;
    }

    synchronized public String add(final ThePrinter obj, final String printerTarget) {
        if (!objectDict_.containsKey(printerTarget)) {
            objectDict_.put(printerTarget, obj);
        }

        return printerTarget;
    }

    synchronized public void remove(final String printerTarget) {
        objectDict_.remove(printerTarget);
    }

    synchronized public ThePrinter getObject(final String printerTarget) {
        return objectDict_.get(printerTarget);
    }

}
