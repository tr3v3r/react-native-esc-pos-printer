package com.reactnativeescposprinter;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.module.annotations.ReactModule;

import java.util.ArrayList;
import java.util.HashMap;
import android.content.Context;
import android.os.Handler;

import com.epson.epos2.discovery.Discovery;
import com.epson.epos2.discovery.DiscoveryListener;
import com.epson.epos2.discovery.FilterOption;
import com.epson.epos2.discovery.DeviceInfo;
import com.epson.epos2.Epos2Exception;

import com.facebook.react.bridge.UiThreadUtil;
import com.facebook.react.modules.core.DeviceEventManagerModule;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.bridge.WritableArray;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Promise;

@ReactModule(name = EscPosPrinterDiscoveryModule.NAME)
public class EscPosPrinterDiscoveryModule extends ReactContextBaseJavaModule {

  private Context mContext;
  private ArrayList<DeviceInfo> mPrinterList = null;
  private final ReactApplicationContext reactContext;

  public static final String NAME = "EscPosPrinterDiscovery";

  interface MyCallbackInterface {
    void onDone(String result);
}

  public EscPosPrinterDiscoveryModule(ReactApplicationContext reactContext) {
      super(reactContext);
      this.reactContext = reactContext;
      mContext = reactContext;
      mPrinterList = new ArrayList<DeviceInfo>();
  }

    @Override
    @NonNull
    public String getName() {
        return NAME;
    }

  private void sendEvent(ReactApplicationContext reactContext,
    String eventName,
    @Nullable WritableArray params) {
      reactContext
      .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
      .emit(eventName, params);
  }

  private void stopDiscovery() {
    while (true) {
      try {
        Discovery.stop();
        break;
      }
      catch (Epos2Exception e) {
        if (e.getErrorStatus() != Epos2Exception.ERR_PROCESSING) {
          return;
        }
      }
    }
  }

  private void startDiscovery(MyCallbackInterface callback) {
     this.stopDiscovery();

     FilterOption mFilterOption = new FilterOption();

     mFilterOption.setDeviceType(Discovery.TYPE_PRINTER);

     mPrinterList.clear();

     try {
       Discovery.start(mContext, mFilterOption, mDiscoveryListener);
     }
     catch (Exception e) {
       int status = ((Epos2Exception) e).getErrorStatus();
       callback.onDone("discover error! Status: " + String.valueOf(status));
       //
     }
 }

 private void performDiscovery(MyCallbackInterface callback) {
   final Handler handler = new Handler();

   final Runnable r = new Runnable() {
     public void run() {
      stopDiscovery();
      callback.onDone("Search completed");
     }
   };

   handler.postDelayed(r, 5000);
 }

 private String getUSBAddress(String target) {
    if(target.contains("USB:")) {
      return target.substring(4, target.length());
    } else {
      return "";
    }
 }

 private DiscoveryListener mDiscoveryListener = new DiscoveryListener() {
   @Override
   public void onDiscovery(final DeviceInfo deviceInfo) {

     UiThreadUtil.runOnUiThread(new Runnable() {
       @Override
       public synchronized void run() {
          mPrinterList.add(deviceInfo);
          WritableArray stringArray = Arguments.createArray();

          for (int counter = 0; counter < mPrinterList.size(); counter++) {
            final DeviceInfo info = mPrinterList.get(counter);
            WritableMap printerData = Arguments.createMap();

            printerData.putString("name", info.getDeviceName());
            printerData.putString("ip", info.getIpAddress());
            printerData.putString("mac", info.getMacAddress());
            printerData.putString("target", info.getTarget());
            printerData.putString("bt", info.getBdAddress());
            printerData.putString("usb",  getUSBAddress(info.getTarget()));
            stringArray.pushMap(printerData);

          }

          sendEvent(reactContext, "onDiscoveryDone", stringArray);

       }
     });
   }
 };

    @ReactMethod
    private void discover(Promise promise) {
     this.startDiscovery(new MyCallbackInterface() {
        @Override
        public void onDone(String result) {
          promise.reject(result);
        }
      });

     this.performDiscovery(new MyCallbackInterface() {
        @Override
        public void onDone(String result) {
          promise.resolve(result);
        }
      });
    }
}
