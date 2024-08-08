using Epson.Epos.Epos2.Printer;
using Microsoft.ReactNative.Managed;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace ReactNativeEscPosPrinter
{
  [ReactModule("EscPosPrinter")]
  internal class EscPosPrinterModule
  {
    private ReactContext _reactContext;
    private static string NAME = "EscPosPrinter";
    private ThePrinterManager thePrinterManager_ = ThePrinterManager.getInstance();
    private readonly int ERR_INIT = EposStringHelper.getInitErrorResultCode();


    [ReactInitializer]
    public void Initialize(ReactContext reactContext)
    {
      _reactContext = reactContext;
    }
    [ReactGetConstants]
    public Dictionary<string, int> getConstants() { return EposStringHelper.getPrinterConstants(); }

    [ReactMethod("initWithPrinterDeviceName")]
    public void InitWithPrinterDeviceName(string target, string deviceName, ModelLang language)
    {
      ThePrinter thePrinter = thePrinterManager_.getObject(target);

      if (thePrinter is null)
      {
        thePrinter = new ThePrinter();
        thePrinterManager_.add(thePrinter, target);
        Series series = EposStringHelper.getPrinterSeries(deviceName);
        thePrinter.SetupWith(target, series, language);
      }
      thePrinter.AssertPrinterNotNull();
    }

    [ReactMethod("connect")]
    public async Task Connect(string target, int timeout)
    {
      ThePrinter thePrinter = thePrinterManager_.getObject(target);
      AssertThePrinterNotNull(thePrinter);
      await thePrinter.Connect(timeout);
    }

    [ReactMethod("disconnect")]
    public async Task Disconnect(string target)
    {
      ThePrinter thePrinter = thePrinterManager_.getObject(target);
      AssertThePrinterNotNull(thePrinter);
      await thePrinter.Disconnect();
    }

    [ReactMethod("clearCommandBuffer")]
    public void ClearCommandBuffer(string target)
    {
      SafeExcecute(target, (ThePrinter ThePrinter) =>
      {
        ThePrinter.ClearCommandBuffer();
      });
    }

    [ReactMethod("addText")]
    public void AddText(string target, string text)
    {
      SafeExcecute(target, (ThePrinter thePrinter) =>
      {
        thePrinter.AddText(text);
      });
    }

    [ReactMethod("addTextLang")]
    public void AddTextLang(string target, int lang)
    {
      SafeExcecute(target, (ThePrinter thePrinter) =>
      {
        thePrinter.AddTextLang(lang);
      });
    }

    [ReactMethod("addFeedLine")]
    public void AddFeedLine(string target, int line)
    {
      SafeExcecute(target, (ThePrinter thePrinter) =>
      {
        thePrinter.AddFeedLine(line);
      });
    }

    [ReactMethod("addCut")]
    public void AddCut(string target, int type)
    {
      SafeExcecute(target, (ThePrinter thePrinter) =>
      {
        thePrinter.AddCut(type);
      });
    }

    [ReactMethod("addCommand")]
    public void AddCommand(string target, string command)
    {
      SafeExcecute(target, (ThePrinter thePrinter) =>
      {
        thePrinter.AddCommand(command);
      });
    }

    [ReactMethod("addPulse")]
    public void AddPulse(string target, int drawer, int time)
    {
      SafeExcecute(target, (ThePrinter thePrinter) =>
      {
        thePrinter.AddPulse(drawer, time);
      });
    }

    [ReactMethod("addTextAlign")]
    public void AddTextAlign(string target, int align)
    {
      SafeExcecute(target, (ThePrinter thePrinter) =>
      {
        thePrinter.AddTextAlign(align);
      });
    }

    [ReactMethod("addTextSize")]
    public void AddTextSize(string target, int width, int height)
    {
      SafeExcecute(target, (ThePrinter thePrinter) =>
      {
        thePrinter.AddTextSize(width, height);
      });
    }

    [ReactMethod("addTextSmooth")]
    public void AddTextSmooth(string target, int smooth)
    {
      SafeExcecute(target, (ThePrinter thePrinter) =>
      {
        thePrinter.AddTextSmooth(smooth);
      });
    }

    [ReactMethod("addTextStyle")]
    public void AddTextStyle(string target, int reverse, int ul, int em, int color)
    {
      SafeExcecute(target, (ThePrinter thePrinter) =>
      {
        thePrinter.AddTextStyle(reverse, ul, em, color);
      });
    }

    [ReactMethod("addImageWindows")]
    public async Task AddImage(string target, JSValue args)
    {
      ThePrinter thePrinter = thePrinterManager_.getObject(target);
      AssertThePrinterNotNull(thePrinter);
      try
      {
        var dictionaryArgs = args.AsObject();
        int width = dictionaryArgs["width"].AsInt32();
        int color = dictionaryArgs["color"].AsInt32();
        int mode = dictionaryArgs["mode"].AsInt32();
        int halftone = dictionaryArgs["halftone"].AsInt32();
        int brightness = dictionaryArgs["brightness"].AsInt32();
        int compress = dictionaryArgs["compress"].AsInt32();
        var resolvedSource = dictionaryArgs["resolvedSource"].AsObject();
        ImageSource source;
        source.uri = (string)resolvedSource["uri"];
        //source.height = (int)resolvedSource["height"];
        //source.width = (int)resolvedSource["width"];
        //source.scale = (int)resolvedSource["scale"];
        await thePrinter.AddImage(source, _reactContext, width, (Color)color, (Mode)mode, (Halftone)halftone, brightness, (Compression)compress);
      }
      catch (Exception e)
      {
        Console.WriteLine($"Exception in AddImage: {e.Message}");
        Console.WriteLine(e.StackTrace);
        throw e;
      }
    }

    [ReactMethod("addBarcode")]
    public void AddBarcode(string target, string data, int type, int hri, int font, int width, int height)
    {
      SafeExcecute(target, (ThePrinter thePrinter) =>
      {
        thePrinter.AddBarcode(data, type, hri, font, width, height);
      });
    }

    [ReactMethod("addSymbol")]
    public void AddSymbol(string target, string data, int type, int level, int width, int height, int size)
    {
      SafeExcecute(target, (ThePrinter thePrinter) =>
      {
        thePrinter.AddSymbol(data, type, level, width, height, size);
      });
    }

    [ReactMethod("getStatus")]
    public async Task<printerStatusStruct> GetStatus(string target)
    {
      ThePrinter thePrinter = thePrinterManager_.getObject(target);
      AssertThePrinterNotNull(thePrinter);
      var status = await thePrinter.GetStatusAsync();
      return new printerStatusStruct(status);
    }

    [ReactMethod("sendData")]
    public async void SendData(string target, int timeout, IReactPromise<IDictionary<string,object>> promise)
    {
      ThePrinter thePrinter = thePrinterManager_.getObject(target);
      AssertThePrinterNotNull(thePrinter);
      try
      {
        PrinterCallback callback = (Printer sender, ReceivedEventArgs args) =>
        {
          if( args.Code == Epson.Epos.Epos2.CallbackCode.Success)
          {
            var result = EposStringHelper.ConvertStatusInfoToWritableMap(args.Status);
            promise.Resolve(result);
          }
          else
          {
            promise.Reject(new ReactError(args.Code.ToString()));
          }
        };
        thePrinter.SendDataAsync(timeout, callback);
      }
      catch (Exception e)
      {
        // remove receiver
        throw e;
      }
    }

    private void SafeExcecute(string target, Action<ThePrinter> method)
    {
      ThePrinter thePrinter = thePrinterManager_.getObject(target);
      AssertThePrinterNotNull(thePrinter);
      method.DynamicInvoke(thePrinter);
    }

    private void AssertThePrinterNotNull(ThePrinter thePrinter)
    {
      if (thePrinter == null)
      {
        throw new Exception("Can't find the current target");
      }
    }
  }
}
