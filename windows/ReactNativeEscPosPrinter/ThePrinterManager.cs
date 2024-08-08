using System;
using System.Collections.Generic;

namespace ReactNativeEscPosPrinter
{
  internal class ThePrinterManager
  {
    private static Dictionary<string, ThePrinter> objectDict = new Dictionary<string, ThePrinter>();
    private static ThePrinterManager instance = null;
    public static ThePrinterManager getInstance()
    {
      if (instance is null)
      {
        instance = new ThePrinterManager();
      }
      return instance;
    }

    internal void add(ThePrinter thePrinter, string target)
    {
      objectDict.Add(target, thePrinter);
    }

    internal ThePrinter getObject(string target)
    {
      objectDict.TryGetValue(target, out var thePrinter);
      return thePrinter;
    }
  }
}
