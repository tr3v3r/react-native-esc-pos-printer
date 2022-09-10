package com.reactnativeescposprinter;

import androidx.annotation.NonNull;

import org.json.JSONObject;

public interface ThePrinterWrapperDelegate {

    void onMemoryError(@NonNull final String objectid, @NonNull final String error);
    void onPrinterStatusChange(@NonNull final String objectid, final int status);
    void onPrinterStartStatusMonitorResult(@NonNull final String objectid, final boolean hasError,  final String error);
    void onPrinterStopStatusMonitorResult(@NonNull final String objectid, final boolean hasError, final String error);
    void onGetPrinterSetting(@NonNull final String objectid, final int code, final int type, final int value);
    void onPtrReceive(@NonNull final String objectid, final JSONObject data);
}
