using Microsoft.ReactNative.Managed;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using Windows.Graphics.Imaging;

namespace ReactNativeEscPosPrinter
{
  internal class ImageManager
  {
    public static async Task<BitmapDecoder> GetBitmapFromSource(ImageSource source, ReactContext context)
    {
      string uriString = source.uri;

      if (uriString.StartsWith("data"))
      {
        return await GetBitmapFromBase64(uriString);
      }

      if (uriString.StartsWith("http") || uriString.StartsWith("https"))
      {
        return await GetBitmapFromWeb(uriString);
      }
      if (uriString.StartsWith("file"))
      {
        return await getBitmapFromFileSystem(uriString);
      }
      throw new Exception("Tipo de uri no soportada");
    }

    private static async Task<BitmapDecoder> getBitmapFromFileSystem(string uriString)
    {
      string cleanUrl = uriString.Replace("file://", "");
      Stream stream = new MemoryStream(Encoding.UTF8.GetBytes(cleanUrl));
      return await BitmapDecoder.CreateAsync(stream.AsRandomAccessStream());
    }

    private static async Task<BitmapDecoder> GetBitmapFromWeb(string uriString)
    {
      Uri uri = new Uri(uriString);
      using (WebClient webClient = new WebClient())
      {
        byte[] imageData = webClient.DownloadData(uri);

        BitmapDecoder decoder;
        using (Windows.Storage.Streams.IRandomAccessStream stream = new MemoryStream(imageData).AsRandomAccessStream())
        {
          decoder = await BitmapDecoder.CreateAsync(stream);
        }
        return decoder;
      }
    }

    private static async Task<BitmapDecoder> GetBitmapFromBase64(string uriString)
    {
      string pureBase64Encoded = uriString.Substring(uriString.IndexOf(",") + 1);
      byte[] decodedString = Convert.FromBase64String(pureBase64Encoded);
      return await BitmapDecoder.CreateAsync(new MemoryStream(decodedString).AsRandomAccessStream());
    }
  }
}
