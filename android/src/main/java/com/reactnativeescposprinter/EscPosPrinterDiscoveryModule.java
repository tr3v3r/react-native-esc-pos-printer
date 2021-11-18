package com.reactnativeescposprinter;

import android.app.Activity;
import android.content.Intent;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ActivityEventListener;
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
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.bridge.WritableArray;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Promise;

import com.google.android.gms.location.*;
import com.google.android.gms.tasks.*;
import android.content.IntentSender;
import com.google.android.gms.common.api.ResolvableApiException;
import com.google.android.gms.common.api.CommonStatusCodes;

import android.hardware.usb.UsbDevice;
import android.hardware.usb.UsbManager;

@ReactModule(name = EscPosPrinterDiscoveryModule.NAME)
public class EscPosPrinterDiscoveryModule extends ReactContextBaseJavaModule implements ActivityEventListener {

  private Context mContext;
  private ArrayList<DeviceInfo> mPrinterList = null;
  private UsbManager mUsbManager = null;
  private final ReactApplicationContext reactContext;
  private boolean mExtractUsbSerialNumber = false;

  public static final String NAME = "EscPosPrinterDiscovery";

  interface MyCallbackInterface {
    void onDone(String result);
  }

  public EscPosPrinterDiscoveryModule(ReactApplicationContext reactContext) {
    super(reactContext);
    this.reactContext = reactContext;
    mContext = reactContext;
    mPrinterList = new ArrayList<DeviceInfo>();
    mUsbManager = (UsbManager) reactContext.getSystemService(Context.USB_SERVICE);
    reactContext.addActivityEventListener(this);
  }

  @Override
  @NonNull
  public String getName() {
    return NAME;
  }

  @Override
  public void onActivityResult(Activity activity, int requestCode, int resultCode, Intent data) {
    if (data != null && resultCode == Activity.RESULT_OK) {
      reactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
          .emit("enableLocationSettingSuccess", "Success");
    } else {
      reactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
          .emit("enableLocationSettingFailure", "Failure");
    }
  }

  @Override
  public void onNewIntent(Intent intent) {

  }

  @ReactMethod
  public void enableLocationSetting(Promise promise) {
    Activity currentActivity = getCurrentActivity();
    if (currentActivity == null) {
      promise.reject("Activity doesn't exist");
      return;
    }

    LocationRequest locationRequest = LocationRequest.create();
    locationRequest.setInterval(10000);
    locationRequest.setFastestInterval(5000);
    locationRequest.setPriority(LocationRequest.PRIORITY_HIGH_ACCURACY);
    LocationSettingsRequest.Builder builder = new LocationSettingsRequest.Builder().addLocationRequest(locationRequest);

    SettingsClient client = LocationServices.getSettingsClient(reactContext);
    Task<LocationSettingsResponse> task = client.checkLocationSettings(builder.build());

    task.addOnSuccessListener(new OnSuccessListener<LocationSettingsResponse>() {
      @Override
      public void onSuccess(LocationSettingsResponse locationSettingsResponse) {
        // All location settings are satisfied. The client can initialize
        // location requests here.
        // ...
        promise.resolve("SUCCESS");
      }
    });

    task.addOnFailureListener(new OnFailureListener() {
      @Override
      public void onFailure(@NonNull Exception e) {
        if (e instanceof ResolvableApiException) {

          // Location settings are not satisfied, but this can be fixed
          // by showing the user a dialog.
          try {
            // Show the dialog by calling startResolutionForResult(),
            // and check the result in onActivityResult().

            ResolvableApiException resolvable = (ResolvableApiException) e;
            resolvable.startResolutionForResult(currentActivity, CommonStatusCodes.RESOLUTION_REQUIRED);

          } catch (IntentSender.SendIntentException sendEx) {
            promise.reject("ERROR");
          }
        }
      }
    });
  }

  private void sendEvent(ReactApplicationContext reactContext, String eventName, @Nullable WritableArray params) {
    reactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class).emit(eventName, params);
  }

  private void stopDiscovery() {
    while (true) {
      try {
        Discovery.stop();
        break;
      } catch (Epos2Exception e) {
        if (e.getErrorStatus() != Epos2Exception.ERR_PROCESSING) {
          return;
        }
      }
    }
  }

  private void startDiscovery(MyCallbackInterface callback, ReadableMap paramsMap) {
    this.stopDiscovery();

    if (paramsMap != null) {
      if (paramsMap.hasKey("usbSerialNumber")) {
        mExtractUsbSerialNumber = paramsMap.getBoolean("usbSerialNumber");
      }
    }

    FilterOption mFilterOption = new FilterOption();

    mFilterOption.setDeviceType(Discovery.TYPE_PRINTER);

    mPrinterList.clear();

    try {
      Discovery.start(mContext, mFilterOption, mDiscoveryListener);
    } catch (Exception e) {
      int status = ((Epos2Exception) e).getErrorStatus();
      callback.onDone("discover error! Status: " + String.valueOf(status));
      //
    }
  }

  private void performDiscovery(MyCallbackInterface callback, ReadableMap paramsMap) {
    final Handler handler = new Handler();

    // Default to 5000 if the value is not passed.
    int scanningTimeout = 5000;

    if (paramsMap != null) {
      if (paramsMap.hasKey("scanningTimeoutAndroid")) {
        scanningTimeout = paramsMap.getInt("scanningTimeoutAndroid");
      }
    }
    final Runnable r = new Runnable() {
      public void run() {
        stopDiscovery();
        if (mPrinterList.size() > 0) {
          sendDiscoveredDataToJS(); // will be invoked after {scanningTimeout / 1000} sec with acc. results
        }
        callback.onDone("Search completed");
      }
    };

    handler.postDelayed(r, scanningTimeout);
  }

  private String getUSBAddress(String target) {
    if (target.contains("USB:")) {
      return target.substring(4, target.length());
    } else {
      return "";
    }
  }

  private String getUsbSerialNumber(String usbAddress) {
    if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.LOLLIPOP) {
      UsbDevice device = mUsbManager.getDeviceList().get(usbAddress);
      if (device != null) {
        return device.getSerialNumber();
      }
    }
    return "";
  }

  private DiscoveryListener mDiscoveryListener = new DiscoveryListener() {
    @Override
    public void onDiscovery(final DeviceInfo deviceInfo) {

      UiThreadUtil.runOnUiThread(new Runnable() {
        @Override
        public synchronized void run() {
          mPrinterList.add(deviceInfo);
        }
      });
    }
  };

  public void sendDiscoveredDataToJS() {
    WritableArray stringArray = Arguments.createArray();

    for (int counter = 0; counter < mPrinterList.size(); counter++) {

      final DeviceInfo info = mPrinterList.get(counter);
      WritableMap printerData = Arguments.createMap();

      String usbAddress = getUSBAddress(info.getTarget());

      if (mExtractUsbSerialNumber && usbAddress != "") {
        String usbSerialNumber = getUsbSerialNumber(usbAddress);
        printerData.putString("usbSerialNumber", usbSerialNumber);
      }

      printerData.putString("name", info.getDeviceName());
      printerData.putString("ip", info.getIpAddress());
      printerData.putString("mac", info.getMacAddress());
      printerData.putString("target", info.getTarget());
      printerData.putString("bt", info.getBdAddress());
      printerData.putString("usb", usbAddress);
      stringArray.pushMap(printerData);
    }

    sendEvent(reactContext, "onDiscoveryDone", stringArray);
  }

  @ReactMethod
  private void discover(final ReadableMap paramsMap, Promise promise) {
    this.startDiscovery(new MyCallbackInterface() {
      @Override
      public void onDone(String result) {
        promise.reject(result);
      }
    }, paramsMap);

    this.performDiscovery(new MyCallbackInterface() {
      @Override
      public void onDone(String result) {
        promise.resolve(result);
      }
    }, paramsMap);
  }
}
