// @ts-check

/** @type {import('@docusaurus/plugin-content-docs').SidebarsConfig} */
const sidebars = {
  docs: [
    {
      type: 'category',
      label: 'Getting Started',
      collapsed: false,
      items: ['INSTALLATION', 'QUICK_START'],
    },
    {
      type: 'category',
      label: 'API Reference',
      collapsed: false,
      items: [
        {
          type: 'category',
          label: 'Discovery',
          items: [
            { type: 'doc', id: 'discovery/discovery', label: 'Overview' },
            { type: 'doc', id: 'discovery/usePrintersDiscovery', label: 'usePrintersDiscovery' },
            { type: 'doc', id: 'discovery/PrintersDiscovery', label: 'PrintersDiscovery' },
          ],
        },
        {
          type: 'category',
          label: 'Printer',
          items: [
            { type: 'doc', id: 'printer/Printer', label: 'Overview' },
            { type: 'doc', id: 'printer/constructor', label: 'Constructor' },
            {
              type: 'category',
              label: 'Connection',
              items: [
                { type: 'doc', id: 'printer/connect', label: 'connect()' },
                { type: 'doc', id: 'printer/disconnect', label: 'disconnect()' },
              ],
            },
            {
              type: 'category',
              label: 'Print Commands',
              items: [
                { type: 'doc', id: 'printer/addText', label: 'addText()' },
                { type: 'doc', id: 'printer/addFeedLine', label: 'addFeedLine()' },
                { type: 'doc', id: 'printer/addLineSpace', label: 'addLineSpace()' },
                { type: 'doc', id: 'printer/addCut', label: 'addCut()' },
                { type: 'doc', id: 'printer/addTextAlign', label: 'addTextAlign()' },
                { type: 'doc', id: 'printer/addTextSize', label: 'addTextSize()' },
                { type: 'doc', id: 'printer/addTextStyle', label: 'addTextStyle()' },
                { type: 'doc', id: 'printer/addTextSmooth', label: 'addTextSmooth()' },
                { type: 'doc', id: 'printer/addTextLang', label: 'addTextLang()' },
                { type: 'doc', id: 'printer/addImage', label: 'addImage()' },
                { type: 'doc', id: 'printer/addBarcode', label: 'addBarcode()' },
                { type: 'doc', id: 'printer/addSymbol', label: 'addSymbol()' },
                { type: 'doc', id: 'printer/addCommand', label: 'addCommand()' },
                { type: 'doc', id: 'printer/addPulse', label: 'addPulse()' },
                { type: 'doc', id: 'printer/sendData', label: 'sendData()' },
              ],
            },
            {
              type: 'category',
              label: 'Status',
              items: [
                { type: 'doc', id: 'printer/getStatus', label: 'getStatus()' },
                { type: 'doc', id: 'printer/getPrinterSetting', label: 'getPrinterSetting()' },
              ],
            },
            {
              type: 'category',
              label: 'Static Methods',
              items: [
                { type: 'doc', id: 'printer/addTextLine', label: 'addTextLine()' },
                { type: 'doc', id: 'printer/addViewShot', label: 'addViewShot()' },
                { type: 'doc', id: 'printer/monitorPrinter', label: 'monitorPrinter()' },
                { type: 'doc', id: 'printer/tryToConnectUntil', label: 'tryToConnectUntil()' },
              ],
            },
          ],
        },
        {
          type: 'category',
          label: 'Interfaces',
          items: [
            { type: 'doc', id: 'interfaces/deviceInfo', label: 'DeviceInfo' },
            { type: 'doc', id: 'interfaces/printerSettings', label: 'PrinterSettingsResponse' },
            { type: 'doc', id: 'interfaces/printerStatus', label: 'PrinterStatusResponse' },
            { type: 'doc', id: 'interfaces/printerDiscoveryError', label: 'PrinterDiscoveryError' },
            { type: 'doc', id: 'interfaces/discoveryStartParams', label: 'DiscoveryStartParams' },
            { type: 'doc', id: 'interfaces/filterOption', label: 'FilterOption' },
            { type: 'doc', id: 'interfaces/addBarcodeParams', label: 'AddBarcodeParams' },
            { type: 'doc', id: 'interfaces/addImageParams', label: 'AddImageParams' },
            { type: 'doc', id: 'interfaces/addSymbolParams', label: 'AddSymbolParams' },
            { type: 'doc', id: 'interfaces/addTextLineParams', label: 'AddTextLineParams' },
            { type: 'doc', id: 'interfaces/addTextSizeParams', label: 'AddTextSizeParams' },
            { type: 'doc', id: 'interfaces/addTextStyleParams', label: 'AddTextStyleParams' },
            { type: 'doc', id: 'interfaces/addPulseParams', label: 'AddPulseParams' },
            { type: 'doc', id: 'interfaces/addViewShotParams', label: 'AddViewShotParams' },
          ],
        },
      ],
    },
    {
      type: 'category',
      label: 'Guides',
      items: [
        { type: 'doc', id: 'androidPermissions', label: 'Android Permissions' },
        { type: 'doc', id: 'flipperWorkaround', label: 'Flipper Workaround (iOS)' },
      ],
    },
    {
      type: 'category',
      label: 'Reference',
      items: [
        { type: 'doc', id: 'SUPPORTED_DEVICES', label: 'Supported Devices' },
        { type: 'doc', id: 'SDK', label: 'SDK Info' },
      ],
    },
  ],
};

module.exports = sidebars;
