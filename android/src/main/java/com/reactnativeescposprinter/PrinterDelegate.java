package com.reactnativeescposprinter;

import android.content.Context;

import androidx.annotation.NonNull;

import org.json.JSONObject;

public interface PrinterDelegate {
    void onPrinterStartStatusMonitorResult(@NonNull final String objectid, final boolean hasError,  final String error);
    void onPrinterStopStatusMonitorResult(@NonNull final String objectid, final boolean hasError, final String error);
    void onPrinterStatusChange(@NonNull final String objectid, final int status);
    void onGetPrinterSetting(@NonNull final String objectid, final int code, final int type, final int value);
    void onPtrReceive(@NonNull final String objectid, final JSONObject data);
    Context getContext();
}
