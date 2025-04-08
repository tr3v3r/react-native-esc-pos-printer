package com.escposprinter;

import android.content.Context;

import androidx.annotation.NonNull;

import org.json.JSONObject;

public interface PrinterDelegate {
    void onGetPrinterSetting(@NonNull final String objectid, final int code, final int type, final int value);
    void onPtrReceive(@NonNull final String objectid, final JSONObject data);
    Context getContext();
}
