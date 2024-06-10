using Epson.Epos.Epos2;
using Epson.Epos.Epos2.Discovery;
using Epson.Epos.Epos2.Printer;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using Windows.Media.Casting;
using Windows.Security.Cryptography.Certificates;

namespace ReactNativeEscPosPrinter
{
  internal class EposStringHelper
  {
    private static int ERR_INIT = -1;

    public static IDictionary<string, object> ConvertStatusInfoToWritableMap(PrinterStatusInfo statusInfo)
    {
      var statusMessage = new Dictionary<string, object>();

      statusMessage["connection"] = statusInfo.Connection;
      statusMessage["online"] = statusInfo.Online;
      statusMessage["coverOpen"] = statusInfo.CoverOpen;
      statusMessage["paper"] = statusInfo.Paper;
      statusMessage["paperFeed"] = statusInfo.PaperFeed;
      statusMessage["panelSwitch"] = statusInfo.PanelSwitch;
      statusMessage["drawer"] = statusInfo.Drawer;
      statusMessage["errorStatus"] = statusInfo.ErrorStatus;
      statusMessage["autoRecoverError"] = statusInfo.AutoRecoverError;
      statusMessage["buzzer"] = statusInfo.Buzzer;
      statusMessage["adapter"] = statusInfo.Adapter;
      statusMessage["batteryLevel"] = statusInfo.BatteryLevel;
      //statusMessage["removalWaiting"] = statusInfo.RemovalWaiting;
      //statusMessage["paperTakenSensor"] = statusInfo.PaperTakenSensor;
      //statusMessage["unrecoverError"] = statusInfo.UnrecoverError;

      return statusMessage;
    }

    private static string ToUnderscoreCase(string str)
    {
      return string.Concat(str.Select((x, i) => i > 0 && char.IsUpper(x) ? "_" + x.ToString() : x.ToString())).ToLower();
    }

    private static void AddEnumToDictionary<anEnumType>(IDictionary<string,int> dictionary, string prefix) {
      var values = Enum.GetValues(typeof(anEnumType));
      foreach (var value in values)
      {
        
        string key =ToUnderscoreCase(value.ToString()).ToUpper();
        if (!string.IsNullOrWhiteSpace(prefix))
        {
          key = prefix + "_" + key;
        }
        dictionary.TryAdd(key, (int) value);
      }
    }

    public static Dictionary<string, int> getDiscoveryConstants()
    {
      Dictionary<string,int> constants = new Dictionary<string,int>();
      AddEnumToDictionary<PortType>(constants, "PORTYPE");
      AddEnumToDictionary<DeviceModel>(constants, "MODEL");
      AddEnumToDictionary<DeviceType>(constants, "TYPE");
      AddEnumToDictionary<EpsonFilter>(constants, "FILTER");
      return constants;
    }
    public static Dictionary<string, int> getPrinterConstants()
    {
      Dictionary<string, int> constants = new Dictionary<string, int>();
      AddEnumToDictionary<ModelLang>(constants, "MODEL");
      AddEnumToDictionary<Cut>(constants, "CUT");
      AddEnumToDictionary<Alignment>(constants, "ALIGN");
      AddEnumToDictionary<Paper>(constants, "PAPER");
      AddEnumToDictionary<PanelSwitch>(constants, "SWITCH");
      AddEnumToDictionary<DrawerStatus>(constants, "DRAWER");
      AddEnumToDictionary<AutoRecoverError>(constants, "");
      AddEnumToDictionary<RemovalWaiting>(constants, "REMOVAL_WAIT");
      AddEnumToDictionary<Hri>(constants, "HRI");
      AddPrinterErrorStatusConstants(constants);

      constants.Add("PARAM_DEFAULT", 0);
      constants.Add("PARAM_UNSPECIFIED", 0);
      // errors
      AddErrorStatusConstants(constants);

      // code errors
      AddCodeErrorsConstants(constants);
      AddPrinterSettingsConstants(constants);

      AddBatteryLevelConstants(constants);
      AddImageConstants(constants);
      AddBarcodeTypeConstants(constants);
      AddSymbolConstants(constants);

      constants.Add("TRUE", (int)Online.True);
      constants.Add("FALSE", (int)Online.False);
      //constants.TryAdd("UNKNOWN", (int)Online.Unknown);

      return constants;
    }

    private static void AddBarcodeTypeConstants(Dictionary<string, int> constants)
    {
      constants.Add("BARCODE_UPC_A", (int)BarcodeType.UPC_A);
      constants.Add("BARCODE_UPC_E", (int)BarcodeType.UPC_E);
      constants.Add("BARCODE_EAN13", (int)BarcodeType.EAN13);
      constants.Add("BARCODE_JAN13", (int)BarcodeType.JAN13);
      constants.Add("BARCODE_EAN8", (int)BarcodeType.EAN8);
      constants.Add("BARCODE_JAN8", (int)BarcodeType.JAN8);
      constants.Add("BARCODE_CODE39", (int)BarcodeType.Code39);
      constants.Add("BARCODE_ITF", (int)BarcodeType.ITF);
      constants.Add("BARCODE_CODABAR", (int)BarcodeType.Codabar);
      constants.Add("BARCODE_CODE93", (int)BarcodeType.Code93);
      constants.Add("BARCODE_CODE128", (int)BarcodeType.Code128);
      constants.Add("BARCODE_GS1_128", (int)BarcodeType.GS1_128);
      constants.Add("BARCODE_GS1_DATABAR_OMNIDIRECTIONAL", (int)BarcodeType.GS1DatabarOmnidirectional);
      constants.Add("BARCODE_GS1_DATABAR_TRUNCATED", (int)BarcodeType.GS1DatabarTruncated);
      constants.Add("BARCODE_GS1_DATABAR_LIMITED", (int)BarcodeType.GS1DatabarLimited);
      constants.Add("BARCODE_GS1_DATABAR_EXPANDED", (int)BarcodeType.GS1DatabarExpanded);
    }

    private static void AddImageConstants(Dictionary<string, int> constants)
    {
      constants.Add("COLOR_NONE", (int)Color.None);
      constants.Add("COLOR_1", (int)Color.Color1);
      constants.Add("COLOR_2", (int)Color.Color2);
      constants.Add("COLOR_3", (int)Color.Color3);
      constants.Add("COLOR_4", (int)Color.Color4);
      constants.Add("MODE_MONO", (int)Mode.Mono);
      constants.Add("MODE_GRAY16", (int)Mode.Gray16);
      constants.Add("MODE_MONO_HIGH_DENSITY", (int)Mode.HighDensity);
      constants.Add("HALFTONE_DITHER", (int)Halftone.Dither);
      constants.Add("HALFTONE_ERROR_DIFFUSION", (int)Halftone.ErrorDiffusion);
      constants.Add("HALFTONE_THRESHOLD", (int)Halftone.Threshold);
      constants.Add("COMPRESS_DEFLATE", (int)Compression.Deflate);
      constants.Add("COMPRESS_NONE", (int)Compression.None);
      constants.Add("COMPRESS_AUTO", (int)Compression.Auto);
    }

    private static void AddPrinterSettingsConstants(Dictionary<string, int> constants)
    {
      AddUnsupportedParam(constants, "PRINTER_SETTING_PAPERWIDTH");
      AddUnsupportedParam(constants, "PRINTER_SETTING_PRINTDENSITY");
      AddUnsupportedParam(constants, "PRINTER_SETTING_PRINTSPEED");
      AddUnsupportedParam(constants, "PRINTER_SETTING_PAPERWIDTH58_0");
      AddUnsupportedParam(constants, "PRINTER_SETTING_PAPERWIDTH60_0");
      AddUnsupportedParam(constants, "PRINTER_SETTING_PAPERWIDTH70_0");
      AddUnsupportedParam(constants, "PRINTER_SETTING_PAPERWIDTH76_0");
      AddUnsupportedParam(constants, "PRINTER_SETTING_PAPERWIDTH80_0");
      AddUnsupportedParam(constants, "PRINTER_SETTING_PRINTDENSITYDIP");
      AddUnsupportedParam(constants, "PRINTER_SETTING_PRINTDENSITY70");
      AddUnsupportedParam(constants, "PRINTER_SETTING_PRINTDENSITY75");
      AddUnsupportedParam(constants, "PRINTER_SETTING_PRINTDENSITY80");
      AddUnsupportedParam(constants, "PRINTER_SETTING_PRINTDENSITY85");
      AddUnsupportedParam(constants, "PRINTER_SETTING_PRINTDENSITY90");
      AddUnsupportedParam(constants, "PRINTER_SETTING_PRINTDENSITY95");
      AddUnsupportedParam(constants, "PRINTER_SETTING_PRINTDENSITY100");
      AddUnsupportedParam(constants, "PRINTER_SETTING_PRINTDENSITY105");
      AddUnsupportedParam(constants, "PRINTER_SETTING_PRINTDENSITY110");
      AddUnsupportedParam(constants, "PRINTER_SETTING_PRINTDENSITY115");
      AddUnsupportedParam(constants, "PRINTER_SETTING_PRINTDENSITY120");
      AddUnsupportedParam(constants, "PRINTER_SETTING_PRINTDENSITY125");
      AddUnsupportedParam(constants, "PRINTER_SETTING_PRINTDENSITY130");
      AddUnsupportedParam(constants, "PRINTER_SETTING_PRINTSPEED1");
      AddUnsupportedParam(constants, "PRINTER_SETTING_PRINTSPEED2");
      AddUnsupportedParam(constants, "PRINTER_SETTING_PRINTSPEED3");
      AddUnsupportedParam(constants, "PRINTER_SETTING_PRINTSPEED4");
      AddUnsupportedParam(constants, "PRINTER_SETTING_PRINTSPEED5");
      AddUnsupportedParam(constants, "PRINTER_SETTING_PRINTSPEED6");
      AddUnsupportedParam(constants, "PRINTER_SETTING_PRINTSPEED7");
      AddUnsupportedParam(constants, "PRINTER_SETTING_PRINTSPEED8");
      AddUnsupportedParam(constants, "PRINTER_SETTING_PRINTSPEED9");
      AddUnsupportedParam(constants, "PRINTER_SETTING_PRINTSPEED10");
      AddUnsupportedParam(constants, "PRINTER_SETTING_PRINTSPEED11");
      AddUnsupportedParam(constants, "PRINTER_SETTING_PRINTSPEED12");
      AddUnsupportedParam(constants, "PRINTER_SETTING_PRINTSPEED13");
      AddUnsupportedParam(constants, "PRINTER_SETTING_PRINTSPEED14");
      AddUnsupportedParam(constants, "PRINTER_SETTING_PRINTSPEED15");
      AddUnsupportedParam(constants, "PRINTER_SETTING_PRINTSPEED16");
      AddUnsupportedParam(constants, "PRINTER_SETTING_PRINTSPEED17");
    }

    private static void AddSymbolConstants(Dictionary<string, int> constants)
    {
      constants.Add("SYMBOL_PDF417_STANDARD", (int)SymbolType.Pdf417Standard);
      constants.Add("SYMBOL_PDF417_TRUNCATED", (int)SymbolType.Pdf417Truncated);
      constants.Add("SYMBOL_QRCODE_MODEL_1", (int)SymbolType.QRCodeModel1);
      constants.Add("SYMBOL_QRCODE_MODEL_2", (int)SymbolType.QRCodeModel2);
      constants.Add("SYMBOL_QRCODE_MICRO", (int)SymbolType.QRCodeMicro);
      constants.Add("SYMBOL_MAXICODE_MODE_2", (int)SymbolType.MaxiCodeMode2);
      constants.Add("SYMBOL_MAXICODE_MODE_3", (int)SymbolType.MaxiCodeMode3);
      constants.Add("SYMBOL_MAXICODE_MODE_4", (int)SymbolType.MaxiCodeMode4);
      constants.Add("SYMBOL_MAXICODE_MODE_5", (int)SymbolType.MaxiCodeMode5);
      constants.Add("SYMBOL_MAXICODE_MODE_6", (int)SymbolType.MaxiCodeMode6);
      constants.Add("SYMBOL_GS1_DATABAR_STACKED", (int)SymbolType.GS1DataBarStacked);
      constants.Add("SYMBOL_GS1_DATABAR_STACKED_OMNIDIRECTIONAL", (int)SymbolType.GS1DataBarStackedOmnidirectional);
      constants.Add("SYMBOL_GS1_DATABAR_EXPANDED_STACKED", (int)SymbolType.GS1DataBarExpandedStacked);
      constants.Add("SYMBOL_AZTECCODE_FULLRANGE", (int)SymbolType.AztecCodeFullRange);
      constants.Add("SYMBOL_AZTECCODE_COMPACT", (int)SymbolType.AztecCodeCompact);
      constants.Add("SYMBOL_DATAMATRIX_SQUARE", (int)SymbolType.DataMatrixSquare);
      constants.Add("SYMBOL_DATAMATRIX_RECTANGLE_8", (int)SymbolType.DataMatrixRectangle8);
      constants.Add("SYMBOL_DATAMATRIX_RECTANGLE_12", (int)SymbolType.DataMatrixRectangle12);
      constants.Add("SYMBOL_DATAMATRIX_RECTANGLE_16", (int)SymbolType.DataMatrixRectangle16);
      constants.Add("LEVEL_0", (int)Level.Level0);
      constants.Add("LEVEL_1", (int)Level.Level1);
      constants.Add("LEVEL_2", (int)Level.Level2);
      constants.Add("LEVEL_3", (int)Level.Level3);
      constants.Add("LEVEL_4", (int)Level.Level4);
      constants.Add("LEVEL_5", (int)Level.Level5);
      constants.Add("LEVEL_6", (int)Level.Level6);
      constants.Add("LEVEL_7", (int)Level.Level7);
      constants.Add("LEVEL_8", (int)Level.Level8);
      constants.Add("LEVEL_L", (int)Level.LevelL);
      constants.Add("LEVEL_M", (int)Level.LevelM);
      constants.Add("LEVEL_Q", (int)Level.LevelQ);
      constants.Add("LEVEL_H", (int)Level.LevelH);
    }

    private static void AddBatteryLevelConstants(Dictionary<string, int> constants)
    {
      constants.Add("EPOS2_BATTERY_LEVEL_6", (int)BatteryLevel.Level6);
      constants.Add("EPOS2_BATTERY_LEVEL_5", (int)BatteryLevel.Level5);
      constants.Add("EPOS2_BATTERY_LEVEL_4", (int)BatteryLevel.Level4);
      constants.Add("EPOS2_BATTERY_LEVEL_3", (int)BatteryLevel.Level3);
      constants.Add("EPOS2_BATTERY_LEVEL_2", (int)BatteryLevel.Level2);
      constants.Add("EPOS2_BATTERY_LEVEL_1", (int)BatteryLevel.Level1);
      constants.Add("EPOS2_BATTERY_LEVEL_0", (int)BatteryLevel.Level0);
    }

    private static void AddCodeErrorsConstants(Dictionary<string, int> constants)
    {
      constants.Add("CODE_ERR_AUTORECOVER", Epos2CallbackCode.CODE_ERR_AUTORECOVER);
      constants.Add("CODE_ERR_COVER_OPEN", Epos2CallbackCode.CODE_ERR_COVER_OPEN);
      constants.Add("CODE_ERR_CUTTER", Epos2CallbackCode.CODE_ERR_CUTTER);
      constants.Add("CODE_ERR_MECHANICAL", Epos2CallbackCode.CODE_ERR_MECHANICAL);
      constants.Add("CODE_ERR_EMPTY", Epos2CallbackCode.CODE_ERR_EMPTY);
      constants.Add("CODE_ERR_UNRECOVERABLE", Epos2CallbackCode.CODE_ERR_UNRECOVERABLE);
      constants.Add("CODE_ERR_FAILURE", Epos2CallbackCode.CODE_ERR_FAILURE);
      constants.Add("CODE_ERR_NOT_FOUND", Epos2CallbackCode.CODE_ERR_NOT_FOUND);
      constants.Add("CODE_ERR_SYSTEM", Epos2CallbackCode.CODE_ERR_SYSTEM);
      constants.Add("CODE_ERR_PORT", Epos2CallbackCode.CODE_ERR_PORT);
      constants.Add("CODE_ERR_TIMEOUT", Epos2CallbackCode.CODE_ERR_TIMEOUT);
      constants.Add("CODE_ERR_JOB_NOT_FOUND", Epos2CallbackCode.CODE_ERR_JOB_NOT_FOUND);
      constants.Add("CODE_ERR_SPOOLER", Epos2CallbackCode.CODE_ERR_SPOOLER);
      constants.Add("CODE_ERR_BATTERY_LOW", Epos2CallbackCode.CODE_ERR_BATTERY_LOW);
      constants.Add("CODE_ERR_TOO_MANY_REQUESTS", Epos2CallbackCode.CODE_ERR_TOO_MANY_REQUESTS);
      constants.Add("CODE_ERR_REQUEST_ENTITY_TOO_LARGE", Epos2CallbackCode.CODE_ERR_REQUEST_ENTITY_TOO_LARGE);
      constants.Add("CODE_ERR_WAIT_REMOVAL", Epos2CallbackCode.CODE_ERR_WAIT_REMOVAL);
      constants.Add("CODE_PRINTING", Epos2CallbackCode.CODE_PRINTING);
      constants.Add("CODE_ERR_MEMORY", Epos2CallbackCode.CODE_ERR_MEMORY);
      constants.Add("CODE_ERR_PROCESSING", Epos2CallbackCode.CODE_ERR_PROCESSING);
      constants.Add("CODE_ERR_ILLEGAL", Epos2CallbackCode.CODE_ERR_ILLEGAL);
      constants.Add("CODE_ERR_DEVICE_BUSY", Epos2CallbackCode.CODE_ERR_DEVICE_BUSY);
    }

    private static void AddErrorStatusConstants(Dictionary<string, int> constants)
    {
      constants.Add("ERR_PARAM", ErrorStatus.ERR_PARAM);
      constants.Add("ERR_MEMORY", ErrorStatus.ERR_MEMORY);
      constants.Add("ERR_UNSUPPORTED", ErrorStatus.ERR_UNSUPPORTED);
      constants.Add("ERR_FAILURE", ErrorStatus.ERR_FAILURE);
      constants.Add("ERR_PROCESSING", ErrorStatus.ERR_PROCESSING);
      constants.Add("ERR_CONNECT", ErrorStatus.ERR_CONNECT);
      constants.Add("ERR_TIMEOUT", ErrorStatus.ERR_TIMEOUT);
      constants.Add("ERR_ILLEGAL", ErrorStatus.ERR_ILLEGAL);
      constants.Add("ERR_NOT_FOUND", ErrorStatus.ERR_NOT_FOUND);
      constants.Add("ERR_IN_USE", ErrorStatus.ERR_IN_USE);
      constants.Add("ERR_TYPE_INVALID", ErrorStatus.ERR_TYPE_INVALID);
      constants.Add("ERR_DISCONNECT", ErrorStatus.ERR_DISCONNECT);
      constants.Add("ERR_INIT", ERR_INIT);
    }

    private static void AddPrinterErrorStatusConstants(Dictionary<string, int> constants)
    {
      constants.Add("NO_ERR", (int)PrinterErrorStatus.NoErr);
      constants.Add("AUTOCUTTER_ERR", (int)PrinterErrorStatus.AutoCutterErr);
      constants.Add("MECHANICAL_ERR", (int)PrinterErrorStatus.MechanicalErr);
      constants.Add("AUTORECOVER_ERR", (int)PrinterErrorStatus.AutoRecoverErr);
      constants.Add("UNRECOVER_ERR", (int)PrinterErrorStatus.UnrecoverErr);
    }

    //Params required by javascript but not supported in current sdk version
    private static void AddUnsupportedParam(Dictionary<string, int> constants, string param)
    {
      constants.Add(param, Printer.PARAM_UNSPECIFIED);
    }

    internal static Series getPrinterSeries(string deviceName)
    {
      if ( deviceName is null) return Series.TM_T88;

      if (deviceName.StartsWith("TM-m10")) return Series.TM_M10;
      if (deviceName.StartsWith("TM-m30")) return Series.TM_M30;
      if (deviceName.StartsWith("TM-P20")) return Series.TM_P20;
      if (deviceName.StartsWith("TM-P60II")) return Series.TM_P60II;
      if (deviceName.StartsWith("TM-P60")) return Series.TM_P60;
      if (deviceName.StartsWith("TM-P80")) return Series.TM_P80;
      if (deviceName.StartsWith("TM-T20")) return Series.TM_T20;
      if (deviceName.StartsWith("TM-T60")) return Series.TM_T60;
      if (deviceName.StartsWith("TM-T70")) return Series.TM_T70;
      if (deviceName.StartsWith("TM-T81")) return Series.TM_T81;
      if (deviceName.StartsWith("TM-T82")) return Series.TM_T82;
      if (deviceName.StartsWith("TM-T83")) return Series.TM_T83;
      if (deviceName.StartsWith("TM-T88")) return Series.TM_T88;
      if (deviceName.StartsWith("TM-T90")) return Series.TM_T90;
      if (deviceName.StartsWith("TM-U220")) return Series.TM_U220;
      if (deviceName.StartsWith("TM-U330")) return Series.TM_U330;
      if (deviceName.StartsWith("TM-L90")) return Series.TM_L90;
      if (deviceName.StartsWith("TM-H6000")) return Series.TM_H6000;

      return Series.TM_T88;
    }

    public static string getErrorTextData(int data, string type)
    {
      string stringData = data.ToString();
      if (!string.IsNullOrEmpty(type))
      {
        var errorData = new Dictionary<string, object>
        {
            { "data", stringData },
            { "type", type }
        };

        return JsonConvert.SerializeObject(errorData);
      }

      return stringData;
    }

    internal static int getInitErrorResultCode()
    {
      return ERR_INIT;
    }
  }
}
