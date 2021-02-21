package com.reactnativeescposprinter;

import androidx.annotation.NonNull;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.module.annotations.ReactModule;

import android.content.Context;

import com.epson.epos2.printer.Printer;
import com.epson.epos2.Epos2Exception;
import com.epson.epos2.printer.ReceiveListener;
import com.epson.epos2.printer.PrinterStatusInfo;

@ReactModule(name = EscPosPrinterModule.NAME)
public class EscPosPrinterModule extends ReactContextBaseJavaModule implements ReceiveListener {

    private Context mContext;
    public static Printer  mPrinter = null;

    public static final String NAME = "EscPosPrinter";

    public EscPosPrinterModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    @NonNull
    public String getName() {
        return NAME;
    }

    private boolean initializeObject() {
      System.out.println("LOG: initializeObject!");
       try {
        mPrinter = new Printer(Printer.TM_T20, Printer.MODEL_ANK, mContext);
        System.out.println("LOG: initializeObject success!");
       }
        catch (Epos2Exception e) {
          return false;
        }
        mPrinter.setReceiveEventListener(this);
        return true;
  }

    private boolean connectPrinter() {
      if (mPrinter == null) {
          return false;
      }

      try {
        System.out.println("LOG: start connectPrinter!");
          mPrinter.connect("TCP:192.168.0.110", Printer.PARAM_DEFAULT);
          System.out.println("LOG: connectPrinter success!");
      }
      catch (Exception e) {
          int status = ((Epos2Exception) e).getErrorStatus();
          System.out.println("LOG: error!");
          System.out.println(status);

          return false;
      }
      return true;
    }

    private boolean printData() {
      if (mPrinter == null) {
          return false;
      }
      System.out.println("LOG: printData");
      if (!connectPrinter()) {
        System.out.println("LOG: clearCommandBuffer");
          mPrinter.clearCommandBuffer();
          return false;
      }
      try {
          System.out.println("LOG: sending data");
          mPrinter.sendData(Printer.PARAM_DEFAULT);
      }
      catch (Exception e) {
          mPrinter.clearCommandBuffer();
          try {
              mPrinter.disconnect();
          }
          catch (Exception ex) {
              // Do nothing
          }
          return false;
      }
      System.out.println("LOG: sending data success!");
      return true;
  }

  @Override
  public void onPtrReceive(final Printer printerObj, final int code, final PrinterStatusInfo status, final String printJobId) {

    System.out.println("LOG: onPtrReceive");
    System.out.println(code);
    try {
      mPrinter.disconnect();
    } catch(Exception e){

    }
  }



    // Example method
    // See https://reactnative.dev/docs/native-modules-android
    @ReactMethod
    public void multiply(int a, int b, Promise promise) {
        promise.resolve(a * b);
    }

    @ReactMethod
    public void init() {
      this.initializeObject();
    }

    @ReactMethod
    public void test() {
      this.initializeObject();
      try {
        System.out.println("LOG: start addText");
        mPrinter.addText("test");
        mPrinter.addFeedLine(2);
        mPrinter.addCut(Printer.CUT_FEED);
        System.out.println("LOG: add text success");
      }  catch (Exception ex) {
        System.out.println("LOG: addText failure");
        // Do nothing
    }


        this.printData();
    }

    public static native int nativeMultiply(int a, int b);
}
