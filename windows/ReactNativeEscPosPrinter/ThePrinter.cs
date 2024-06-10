using Epson.Epos.Epos2.Printer;
using Microsoft.ReactNative.Managed;
using System;
using System.Collections.Generic;
using System.Reflection.Metadata;
using System.Text;
using System.Threading.Tasks;
using Windows.Graphics.Imaging;
using Windows.Storage.Streams;

namespace ReactNativeEscPosPrinter
{
  internal class ThePrinter
  {
    private Printer epos2Printer = null; // Printer
    private string printerTarget = null; // the printer target
    private bool isConnected = false; // cache if printer is connected
    private bool didBeginTransaction = false; // did start Status Monitor
    private static readonly int DISCONNECT_INTERVAL = 500;//millseconds
    private PrinterCallback printCallback = null;
    private PrinterCallback getPrinterSettingCallback = null;
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

    internal async Task Connect(int timeout)
    {
      AssertPrinterNotNull();
      if (string.IsNullOrEmpty(printerTarget))
      {
        throw new Exception($"Can't connect to the printer with target: {printerTarget}");
      }

      if (isConnected)
      {
        return;
      }
      isConnected = false;
      try
      {
        await epos2Printer.ConnectAsync(printerTarget, timeout);
        isConnected = true;
      }
      catch (Exception e)
      {
        isConnected = false;
        throw e;
      }
    }

    internal async void SendDataAsync(int timeout, PrinterCallback callback)
    {
      await BeginTransaction();
      try
      {
        epos2Printer.Received += new Windows.Foundation.TypedEventHandler< Printer,ReceivedEventArgs>(callback);
        await epos2Printer.SendDataAsync(timeout);
      }
      catch (Exception e)
      {
        await EndTransactionAsync();
        throw e;
      }
    }

    private async Task EndTransactionAsync()
    {
      AssertPrinterNotNull();
      if (!didBeginTransaction) return;
      await epos2Printer.EndTransactionAsync();
      didBeginTransaction = false;
    }

    public void AssertPrinterNotNull()
    {
      if (epos2Printer == null)
      {
        throw new Exception("Printer is not initialized");
      }
    }

    private async Task BeginTransaction()
    {
      AssertPrinterNotNull();
      if (didBeginTransaction) return;
      try
      {
        await epos2Printer.BeginTransactionAsync();
        didBeginTransaction = true;
      }
      catch (Exception e)
      {
        didBeginTransaction = false;
        throw e;
      }
    }

    internal void AddTextAlign(int align)
    {
      AssertPrinterNotNull();
      epos2Printer.AddTextAlign((Alignment)align);
    }

    internal void AddTextSize(int width, int height)
    {
      AssertPrinterNotNull();
      epos2Printer.AddTextSize(width, height);
    }

    internal async Task Disconnect()
    {
      AssertPrinterNotNull();
      if (!isConnected) return;
      if (didBeginTransaction)
      {
        await EndTransactionAsync();
      }
      await epos2Printer.DisconnectAsync();
      epos2Printer.ClearCommandBuffer();
      isConnected = false;
      didBeginTransaction = false;
    }

    internal void ClearCommandBuffer()
    {
      AssertPrinterNotNull();
      epos2Printer.ClearCommandBuffer();
    }

    internal void AddText(string text)
    {
      AssertPrinterNotNull();
      epos2Printer.AddText(text);
    }

    internal void AddFeedLine(int line)
    {
      AssertPrinterNotNull();
      epos2Printer.AddFeedLine(line);
    }

    internal void AddCut(int type)
    {
      AssertPrinterNotNull();
      epos2Printer.AddCut((Cut)type);
    }

    internal void AddCommand(string command)
    {
      AssertPrinterNotNull();
      epos2Printer.AddCommand(Encoding.ASCII.GetBytes(command));
    }

    internal void AddPulse(int drawer, int time)
    {
      AssertPrinterNotNull();
      epos2Printer.AddPulse((Drawer)drawer, (Pulse)time);
    }

    internal void AddTextSmooth(int smooth)
    {
      AssertPrinterNotNull();
      epos2Printer.AddTextSmooth((Smooth)smooth);
    }

    internal void AddTextStyle(int reverse, int ul, int em, int color)
    {
      AssertPrinterNotNull();
      epos2Printer.AddTextStyle(
        (Reverse)reverse,
        (Underline)ul,
        (Emphasis)em,
        (Color)color);
    }

    internal async Task AddImage(ImageSource source, ReactContext context, int width, Color color, Mode mode, Halftone halftone, double brightness, Compression compress)
    {
      BitmapDecoder decoder;
      try
      {
        decoder = await ImageManager.GetBitmapFromSource(source, context);
        if (brightness == 0) { brightness = Printer.PARAM_DEFAULT; }
        double aspectRatio = (double)decoder.PixelHeight / (double)decoder.PixelWidth;
        int height = (int)Math.Round(width / aspectRatio);
        InMemoryRandomAccessStream ras = new InMemoryRandomAccessStream();
        BitmapEncoder enc = await BitmapEncoder.CreateForTranscodingAsync(ras, decoder);
        enc.BitmapTransform.ScaledWidth = (uint)width;
        enc.BitmapTransform.ScaledHeight = (uint)height;
        await enc.FlushAsync();
        BitmapDecoder image = await BitmapDecoder.CreateAsync(ras);
        await epos2Printer.AddImageAsync(image, 0, 0, width, height, color, mode, halftone, brightness, compress);
      }
      catch (Exception ex)
      {
        throw ex;
      }
    }

    internal void AddBarcode(string data, int type, int hri, int font, int width, int height)
    {
      AssertPrinterNotNull();
      try
      {
        epos2Printer.AddBarcode(
        data,
        (BarcodeType)type,
        (Hri)hri,
        (Font)font,
        width,
        height);
      }
      catch(Exception ex)
      {
        throw ex;
      }
      
    }

    internal async Task<PrinterStatusInfo> GetStatusAsync()
    {
      AssertPrinterNotNull();
      return await epos2Printer.GetStatusAsync();
    }

    internal void AddTextLang(int lang)
    {
      AssertPrinterNotNull();
      epos2Printer.AddTextLang((Lang)lang);
    }

    internal void AddSymbol(string data, int type, int level, int width, int height, int size)
    {
      AssertPrinterNotNull();
      epos2Printer.AddSymbol(data, (SymbolType)type, (Level)level, level, width, height, size);
    }
  }
}
