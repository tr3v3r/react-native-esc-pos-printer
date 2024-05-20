using Epson.Epos.Epos2.Printer;
using System;

namespace ReactNativeEscPosPrinter
{
  internal class ThePrinter
  {
    private Printer epos2Printer = null; // Printer
    private string printerTarget = null; // the printer target
    private bool isConnected = false; // cache if printer is connected
    private bool didBeginTransaction = false; // did start Status Monitor
    private static readonly int DISCONNECT_INTERVAL = 500;//millseconds
    private IPrinterCallback printCallback = null;
    private IPrinterCallback getPrinterSettingCallback = null;
    public ThePrinter() { }
    ~ThePrinter() { printerTarget = null; }

    public void SetupWith(String printerTarget, Series series, ModelLang lang) 
    {
      this.printerTarget = printerTarget;
      epos2Printer = new Printer(series, lang);
    }

    internal Printer getEpos2Printer()
    {
      return epos2Printer;
    }

    internal void Connect(int timeout)
    {
      throw new NotImplementedException();
    }
  }
}
