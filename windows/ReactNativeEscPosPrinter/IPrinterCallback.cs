using System;
using System.Collections.Generic;

namespace ReactNativeEscPosPrinter
{
  internal interface IPrinterCallback
  {
    void onSuccess(Dictionary<string, object> data);
    void onError(String data);
  }
}
