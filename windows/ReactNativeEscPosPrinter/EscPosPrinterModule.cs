using Epson.Epos.Epos2.Printer;
using Microsoft.ReactNative.Managed;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace ReactNativeEscPosPrinter
{
  [ReactModule("EscPosPrinter")]
  internal class EscPosPrinterModule
  {
    private ReactContext _reactContext;
    private static string NAME = "EscPosPrinter";
    private ThePrinterManager thePrinterManager_ = ThePrinterManager.getInstance();

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
      try
      {
        if(thePrinter is null)
        {
          thePrinter = new ThePrinter();
          thePrinterManager_.add(thePrinter, target);
          Series series = EposStringHelper.getPrinterSeries(deviceName);
          thePrinter.SetupWith(target, series, language);
        }
        Printer mPrinter = thePrinter.getEpos2Printer();
        if(mPrinter is null)
        {
          throw new Exception(EposStringHelper.getErrorTextData(Epos2CallbackCode.CODE_ERR_MEMORY, ""));
        }
      }
      catch (Exception e)
      {
        throw e;
      }
    }
    [ReactMethod("connect")]
    public void Connect(string target, int timeout)
    {
      new Thread(() =>
      {
        lock (this)
        {
          ThePrinter thePrinter = thePrinterManager_.getObject(target);
          if (thePrinter == null)
          {
            throw new Exception(EposStringHelper.getErrorTextData(Epos2CallbackCode.CODE_ERR_CONNECT, ""));
          }
          else
          {
            try
            {
              thePrinter.Connect(timeout);
            }
            catch (Exception e)
            {
              ProcessError(e, "");
            }
          }
        }
      }).Start();
    }

    private void ProcessError(Exception e, string v)
    {
      throw new NotImplementedException();
    }
  }
}
