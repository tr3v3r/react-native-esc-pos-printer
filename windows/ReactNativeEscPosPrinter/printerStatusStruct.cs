using Epson.Epos.Epos2.Printer;

namespace ReactNativeEscPosPrinter
{
  internal struct printerStatusStruct
  {
    public Connection connection;
    public Online online;
    public CoverOpen coverOpen;
    public Paper paper;
    public PaperFeed paperFeed;
    public PanelSwitch panelSwitch;
    public DrawerStatus drawer;
    public PrinterErrorStatus errorStatus;
    public AutoRecoverError autoRecoverError;
    public Buzzer buzzer;
    public Adapter adapter;
    public BatteryLevel batteryLevel;

    public printerStatusStruct(PrinterStatusInfo status)
    {
      this.connection = status.Connection;
      this.online = status.Online;
      this.coverOpen = status.CoverOpen;
      this.paper = status.Paper;
      this.paperFeed = status.PaperFeed;
      this.panelSwitch = status.PanelSwitch;
      this.drawer = status.Drawer;
      this.errorStatus = status.ErrorStatus;
      this.autoRecoverError = status.AutoRecoverError;
      this.buzzer = status.Buzzer;
      this.adapter = status.Adapter;
      this.batteryLevel = status.BatteryLevel;
    }
  }
}
