package com.escposprinter;

import com.facebook.react.bridge.ReadableMap;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.util.Base64;
import android.content.Context;

import java.net.URL;


public class ImageManager {
  public static Bitmap getBitmapFromSource(ReadableMap source, Context mContext) throws Exception {
    String uriString = source.getString("uri");

    if(uriString.startsWith("data")) {
        final String pureBase64Encoded = uriString.substring(uriString.indexOf(",") + 1);
        byte[] decodedString = Base64.decode(pureBase64Encoded, Base64.DEFAULT);
        Bitmap image = BitmapFactory.decodeByteArray(decodedString, 0, decodedString.length);

        return image;
    }

    if(uriString.startsWith("http") || uriString.startsWith("https")) {
      URL url = new URL(uriString);
      Bitmap image = BitmapFactory.decodeStream(url.openConnection().getInputStream());
      return image;
    }

    if(uriString.startsWith("file")) {
      String cleanUrl = uriString.replaceAll("file://", "");
      BitmapFactory.Options options = new BitmapFactory.Options();
      options.inPreferredConfig = Bitmap.Config.ARGB_8888;
      Bitmap image = BitmapFactory.decodeFile(cleanUrl, options);

      return image;
    }

    int resourceId = mContext.getResources().getIdentifier(uriString, "drawable", mContext.getPackageName());
    Bitmap image = BitmapFactory.decodeResource(mContext.getResources(), resourceId);

    return image;
  }
}



