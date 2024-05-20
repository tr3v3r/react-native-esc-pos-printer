using Epson.Epos.Epos2.Discovery;

namespace ReactNativeEscPosPrinter
{
  internal class RawDeviceInfo
  {
    private int deviceType;
    private string target;
    private string deviceName;
    private string ipAddress;
    private string macAddress;
    private string bdAddress;

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
