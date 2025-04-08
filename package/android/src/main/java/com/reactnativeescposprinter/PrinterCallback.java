package com.escposprinter;

import com.facebook.react.bridge.WritableMap;

public interface PrinterCallback {
      void onSuccess(WritableMap data);
      void onError(String data);
}
