using Epson.Epos.Epos2.Discovery;

namespace ReactNativeEscPosPrinter
{
  internal class RawDeviceInfo
  {
    public int deviceType {get;set;}
    public string target {get;set;}
    public string deviceName {get;set;}
    public string ipAddress {get;set;}
    public string macAddress {get;set;}
    public string bdAddress { get; set; }
    
    public RawDeviceInfo(DeviceInfo discoveredDevice)
    {
      deviceName = discoveredDevice.DeviceName;
      target = discoveredDevice.Target;
      ipAddress = discoveredDevice.IpAddress;
      macAddress = discoveredDevice.MacAddress;
      bdAddress = discoveredDevice.MacAddress;
    }
  }
}
