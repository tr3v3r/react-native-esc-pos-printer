using Epson.Epos.Epos2;
using Epson.Epos.Epos2.Discovery;
using Microsoft.ReactNative;
using Microsoft.ReactNative.Managed;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Collections.Immutable;
using System.Linq;
using System.Reflection.Metadata.Ecma335;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace ReactNativeEscPosPrinter
{
  [ReactModule("EscPosPrinterDiscovery")]
  internal sealed class EscPosPrinterDiscoveryModule
  {
    private ReactContext _reactContext;
    private static string NAME = "EscPosPrinterDiscovery";

    [ReactInitializer]
    public void Initialize(ReactContext reactContext)
    {
      _reactContext = reactContext;
    }

    [ReactGetConstants]
    public Dictionary<string, int> getConstants() { return EposStringHelper.getDiscoveryConstants(); }

    [ReactMethod("getName")]
    public String GetName()
    {
      return NAME;
    }

    [ReactMethod("startDiscovery")]
    public async Task StartDiscovery(Dictionary<string, object> paramsMap)
    {
      FilterOption filterOption = GetFilterOptionsFromParams(paramsMap);
      try
      {
        Discovery.Discovered += Discovery_Discovered;
        await Discovery.StartAsync(filterOption);
      }
      catch (Exception ex)
      {
        throw ex;
      }
    }

    [ReactMethod("stopDiscovery")]
    public async Task StopDiscovery()
    {
      try
      {
        await Discovery.StopAsync();
        Discovery.Discovered -= Discovery_Discovered;
        return;
      }
      catch (Exception ex)
      {
        throw ex;
      }
    }

    private FilterOption GetFilterOptionsFromParams(Dictionary<string, object> paramsMap)
    {
      FilterOption mFilterOption = new FilterOption();

      if (paramsMap.ContainsKey("portType"))
      {
        mFilterOption.PortType = (PortType)paramsMap["portType"];
      }

      if (paramsMap.ContainsKey("broadcast"))
      {
        mFilterOption.Broadcast = (string)paramsMap["broadcast"];
      }

      if (paramsMap.ContainsKey("deviceModel"))
      {
        mFilterOption.DeviceModel = (DeviceModel)paramsMap["deviceModel"];
      }

      if (paramsMap.ContainsKey("epsonFilter"))
      {
        mFilterOption.EpsonFilter = (EpsonFilter)paramsMap["epsonFilter"];
      }

      if (paramsMap.ContainsKey("deviceType"))
      {

        mFilterOption.DeviceType = (DeviceType)paramsMap["deviceType"];
      }

      return mFilterOption;
    }

    private void Discovery_Discovered(DiscoveredEventArgs args)
    {
      RawDeviceInfo printerData = new RawDeviceInfo(args.DiscoveredDevice);
      onDiscovery(new List<RawDeviceInfo> { printerData });
    }

    [ReactEvent]
    public Action<List<RawDeviceInfo>> onDiscovery { get; set; }
  }
}
