# Interface: DeviceInfo


### target

*target*: `string`

The connection target of a device which can be specified by connectAPI is stored as a string.

##### Example
```
"TCP:192.168.192.168"
"BT:00:22:15:7D:70:9C"
"USB:/dev/udev/*"
"USB:000000000000000000"
"TCP:192.168.192.168[local_printer]"
"TCP:192.168.192.168[local_display]"
"TCP:12:34:56:78:56:78"
```


### deviceType

*deviceType*: `string`

| **Value** | **Description** |
| --- | --- |
| TYPE_PRINTER |  For a printer |
| TYPE_HYBRID_PRINTER |  For hybrid model printers |
| TYPE_DISPLAY |  For a customer display |
| TYPE_KEYBOARD |  For a keyboard |
| TYPE_SCANNER |  For a barcode scanner |
| TYPE_SERIAL |  For a serial communication device |
| TYPE_POS_KEYBOARD |  For POS keyboard |
| TYPE_MSR |  For MSR |
| TYPE_GFE |  For German fiscal element (TSE) |
| TYPE_OTHER_PERIPHERAL |  For other peripheral devices |

### deviceName

*deviceName*: `string`

The name set to the device is stored.
If it could not be acquired, "" (blank character) or "TM Printer" is stored.

##### Example
`TM-T88V`


### ipAddress

*ipAddress*: `string`

The IP address of the device is stored.
If it could not be acquired, "" (blank character) is stored.

##### Example

`TCP: "192.168.192.168"`

### macAddress

*macAddress*: `string`

The MAC address is stored.
If it could not be acquired, "" (blank character) is stored.

##### Example

`TCP: "12:34:56:78:56:78"`


### bdAddress

*bdAddress*: `string`

The Bluetooth device address is stored.
If it could not be acquired, "" (blank character) is stored.

##### Example

`BT: "00:22:15:7D:70:9C"`
