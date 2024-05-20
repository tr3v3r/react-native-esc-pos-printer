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
        string key = prefix + "_" + ToUnderscoreCase(value.ToString());
        dictionary.Add(key, (int) value);
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

      // errors
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

      // code errors
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

      // get printer settings

      //constants.Add("PRINTER_SETTING_PAPERWIDTH", Printer.SETTING_PAPERWIDTH);
      //constants.Add("PRINTER_SETTING_PRINTDENSITY", Printer.SETTING_PRINTDENSITY);
      //constants.Add("PRINTER_SETTING_PRINTSPEED", Printer.SETTING_PRINTSPEED);

      return constants;
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


  }
}
