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

import java.util.HashMap;
import java.util.Map;
import android.content.Context;

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

@ReactModule(name = EscPosPrinterDiscoveryModule.NAME)
public class EscPosPrinterDiscoveryModule extends ReactContextBaseJavaModule implements ActivityEventListener {

  private Context mContext;
  private WritableArray mPrinterList = null;
  private final ReactApplicationContext reactContext;

  public static final String NAME = "EscPosPrinterDiscovery";

  public EscPosPrinterDiscoveryModule(ReactApplicationContext reactContext) {
    super(reactContext);
    this.reactContext = reactContext;
    mContext = reactContext;
    reactContext.addActivityEventListener(this);
  }

    @Override
    public Map<String, Object> getConstants() {
      final Map<String, Object> constants = new HashMap<>();
      // filter options
      constants.put("PORTTYPE_ALL", Discovery.PORTTYPE_ALL);
      constants.put("PORTTYPE_TCP", Discovery.PORTTYPE_TCP);
      constants.put("PORTTYPE_BLUETOOTH", Discovery.PORTTYPE_BLUETOOTH);
      constants.put("PORTTYPE_USB", Discovery.PORTTYPE_USB);
      constants.put("MODEL_ALL", Discovery.MODEL_ALL);
      constants.put("TYPE_ALL", Discovery.TYPE_ALL);
      constants.put("TYPE_PRINTER", Discovery.TYPE_PRINTER);
      constants.put("TYPE_HYBRID_PRINTER", Discovery.TYPE_HYBRID_PRINTER);
      constants.put("TYPE_DISPLAY", Discovery.TYPE_DISPLAY);
      constants.put("TYPE_KEYBOARD", Discovery.TYPE_KEYBOARD);
      constants.put("TYPE_SCANNER", Discovery.TYPE_SCANNER);
      constants.put("TYPE_SERIAL", Discovery.TYPE_SERIAL);
      constants.put("TYPE_POS_KEYBOARD", Discovery.TYPE_POS_KEYBOARD);
      constants.put("TYPE_MSR", Discovery.TYPE_MSR);
      constants.put("TYPE_GFE", Discovery.TYPE_GFE);
      constants.put("TYPE_OTHER_PERIPHERAL", Discovery.TYPE_OTHER_PERIPHERAL);
      constants.put("FILTER_NAME", Discovery.FILTER_NAME);
      constants.put("FILTER_NONE", Discovery.FILTER_NONE);
      constants.put("TRUE", Discovery.TRUE);
      constants.put("FALSE", Discovery.FALSE);
      // return values
      constants.put("ERR_PARAM", Epos2Exception.ERR_PARAM);
      constants.put("ERR_ILLEGAL", Epos2Exception.ERR_ILLEGAL);
      constants.put("ERR_MEMORY", Epos2Exception.ERR_MEMORY);
      constants.put("ERR_FAILURE", Epos2Exception.ERR_FAILURE);
      constants.put("ERR_PROCESSING", Epos2Exception.ERR_PROCESSING);

      return constants;
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
      promise.reject("Activity doesn't exist", "");
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
            promise.reject("ERROR", "");
          }
        }
      }
    });
  }

  private void sendEvent(ReactApplicationContext reactContext, String eventName, @Nullable WritableArray params) {
    reactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class).emit(eventName, params);
  }

  @ReactMethod
  private void startDiscovery(final ReadableMap paramsMap, Promise promise) {
    FilterOption mFilterOption = getFilterOptionsFromParams(paramsMap);
    mPrinterList = Arguments.createArray();

    try {
      Discovery.start(mContext, mFilterOption, mDiscoveryListener);

      promise.resolve(null);

    } catch (Epos2Exception e) {
      int status = ((Epos2Exception) e).getErrorStatus();
      promise.reject("event_failure", String.valueOf(status));
    }
  }

  @ReactMethod
  private void stopDiscovery(Promise promise) {
      try {
        Discovery.stop();
        promise.resolve(null);
      } catch (Epos2Exception e) {
        int status = ((Epos2Exception) e).getErrorStatus();
        promise.reject("event_failure", String.valueOf(status));
      }
  }

  private FilterOption getFilterOptionsFromParams(final ReadableMap paramsMap) {
    FilterOption mFilterOption = new FilterOption();

    if(paramsMap.hasKey("portType")) {
      mFilterOption.setPortType(paramsMap.getInt("portType"));
    }

    if(paramsMap.hasKey("broadcast")) {
      mFilterOption.setBroadcast(paramsMap.getString("broadcast"));
    }

    if(paramsMap.hasKey("deviceModel")) {
      mFilterOption.setDeviceModel(paramsMap.getInt("deviceModel"));
    }

    if(paramsMap.hasKey("epsonFilter")) {
      mFilterOption.setEpsonFilter(paramsMap.getInt("epsonFilter"));
    }

    if(paramsMap.hasKey("deviceType")) {
      mFilterOption.setDeviceType(paramsMap.getInt("deviceType"));
    }

    if(paramsMap.hasKey("bondedDevices")) {
      mFilterOption.setBondedDevices(paramsMap.getInt("bondedDevices"));
    }

    if(paramsMap.hasKey("usbDeviceName")) {
      mFilterOption.setUsbDeviceName(paramsMap.getInt("usbDeviceName"));
    }
    return mFilterOption;
  }

  private DiscoveryListener mDiscoveryListener = new DiscoveryListener() {
    @Override
    public void onDiscovery(final DeviceInfo deviceInfo) {

      UiThreadUtil.runOnUiThread(new Runnable() {
        @Override
        public synchronized void run() {
          WritableMap printerData = Arguments.createMap();


          printerData.putString("target", deviceInfo.getTarget());
          printerData.putString("deviceName", deviceInfo.getDeviceName());
          printerData.putString("ipAddress", deviceInfo.getIpAddress());
          printerData.putString("macAddress", deviceInfo.getMacAddress());
          printerData.putString("bdAddress", deviceInfo.getBdAddress());

          mPrinterList.pushMap(printerData);

          sendEvent(reactContext, "onDiscovery", mPrinterList);
        }
      });
    }
  };
}
