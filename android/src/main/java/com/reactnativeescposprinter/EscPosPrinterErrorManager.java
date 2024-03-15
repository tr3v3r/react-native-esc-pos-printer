package com.reactnativeescposprinter;


import org.json.JSONObject;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.ReadableMapKeySetIterator;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.bridge.Arguments;


public class EscPosPrinterErrorManager {


 public static String convertMapToString(ReadableMap readableMap) {
  try{
    JSONObject object = new JSONObject();
    ReadableMapKeySetIterator iterator = readableMap.keySetIterator();
    while (iterator.hasNextKey()) {
        String key = iterator.nextKey();
        switch (readableMap.getType(key)) {
            case Null:
                object.put(key, JSONObject.NULL);
                break;
            case Boolean:
                object.put(key, readableMap.getBoolean(key));
                break;
            case Number:
                object.put(key, readableMap.getDouble(key));
                break;
            case String:
                object.put(key, readableMap.getString(key));
                break;
        }
    }
    return object.toString();

  } catch(Exception e) {
    return "";
  }
}

  public static String getErrorTextData(int data, String type) {
      String stringData = String.valueOf(data);
      if(!type.isEmpty()) {
        WritableMap errorData = Arguments.createMap();
        errorData.putString("data", stringData);
        errorData.putString("type", type);

        return convertMapToString(errorData);
      }

      return stringData;
  }


}
