# Intraface: FilterOption

In order to filter the search result, set the filter option, specify it in the parameter of PrintersDiscovery **start** method.

The following filter options supported:

### portType

- `Optional` **portType**: `DiscoveryFilterOption.PORTTYPE_ALL | DiscoveryFilterOption.PORTTYPE_TCP | DiscoveryFilterOption.PORTTYPE_BLUETOOTH | DiscoveryFilterOption.PORTTYPE_USB | DiscoveryFilterOption.PORTTYPE_BLUETOOTH_LE`

Selects the port to search.

|**Value**|**Description**|
| - | - |
|PORTTYPE\_ALL (default)|Search for all devices which can be connected via TCP, Bluetooth, USB or BLE.|
|PORTTYPE\_TCP|Search for devices connected to the network.|
|PORTTYPE\_BLUETOOTH|Search for devices which can be connected via Blue- tooth.|
|PORTTYPE\_USB|Search for devices which can be connected via USB.|
|PORTTYPE\_BLUETOOTH\_LE|Search for devices that can be connected via Bluetooth Low Energy. (iOS only)|

### broadcast
- `Optional` **broadcast**: `string`

Specify a Broadcast Address for TCP search as a string.


|**Value**|**Description**|
| - | - |
|"255.255.255.255" (default)|-|

### deviceModel

- `Optional` **deviceModel**: `DiscoveryFilterOption.MODEL_ALL`

|**Value**|**Description**|
| - | - |
|MODEL\_ALL|Search for all models.|

### epsonFilter (Android only)

- `Optional` **epsonFilter**: `DiscoveryFilterOption.FILTER_NAME | DiscoveryFilterOption.FILTER_NONE`

Filters the search result by the Epson printers.
Search can be performed for printers connected via Bluetooth or USB.

|**Value**|**Description**|
| - | - |
|FILTER_NAME(default)|Filters the search result by the Epson printers.|
|FILTER_NONE|Does not filter the search result.|


### deviceType

- `Optional` **deviceType**: `DiscoveryFilterOption.TYPE_ALL | DiscoveryFilterOption.TYPE_PRINTER | DiscoveryFilterOption.TYPE_HYBRID_PRINTER | DiscoveryFilterOption.TYPE_DISPLAY | DiscoveryFilterOption.TYPE_KEYBOARD | DiscoveryFilterOption.TYPE_SCANNER | DiscoveryFilterOption.TYPE_SERIAL | DiscoveryFilterOption.TYPE_POS_KEYBOARD | DiscoveryFilterOption.TYPE_MSR | DiscoveryFilterOption.TYPE_GFE | DiscoveryFilterOption.TYPE_OTHER_PERIPHERAL`

Specifies the device type to search for.

The device type settings other than "TYPE\_ALL" can be used for the following systems connected using Wi-Fi or Ethernet.

- Customer Display Models (SSL/TLS communication only)
- TM Printer + DM-D + barcode scanner model
- TM Printer + barcode scanner model
- POS Terminal Model

|**Value**|**Description**|
| - | - |
|TYPE\_ALL (default)|Search for all devices.|
|TYPE\_PRINTER|Search for printers.|
|TYPE\_HYBRID\_PRINTER|Searches for hybrid model printers.|
|TYPE\_DISPLAY|Search for customer displays.|
|TYPE\_KEYBOARD|Search for keyboards.|
|TYPE\_SCANNER|Search for barcode scanners.|
|TYPE\_SERIAL|Search for serial communication devices.|
|TYPE\_POS\_KEYBOARD|Search for the POS keyboard.|
|TYPE\_MSR|Search for the MSR.|
|TYPE\_GFE|Search for the German fiscal element (TSE).|
|TYPE\_OTHER\_PERIPHERAL|Search for other peripheral devices.|

### bondedDevices (Android only)

- `Optional` **bondedDevices**: `DiscoveryFilterOption.TRUE | DiscoveryFilterOption.FALSE`

Specifies the search target when searching for a device that can be connected via Bluetooth.

|**Value**|**Description**|
| - | - |
|TRUE|Search for devices that can be connected, and devices that were previously connected.|
|FALSE (default)|Search for devices that can be connected.|


### usbDeviceName (Android only)

- `Optional` **usbDeviceName**: `DiscoveryFilterOption.TRUE | DiscoveryFilterOption.FALSE`

Specifies whether to search USB devices by their names or not.

|**Value**|**Description**|
| - | - |
|TRUE|Search for USB compatible devices by their name.|
|FALSE (default)|Does not search for USB compatible devices by their name.|
