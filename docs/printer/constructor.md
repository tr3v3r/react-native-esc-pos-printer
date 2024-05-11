## Printer constructor

Initializes the printer object.

> [!NOTE]
> Implements singletone pattern. Return the same instance if the same target is passed.

### Parameters

#### target

- `string`

Specifies the method of connecting to the printer by a character string.
The connection method varies according to the system configuration. Can be retrieved from the [discovery](../discovery/discovery.md).

| **I/F** | **Connec-tion type** | **Identifier** | **Example** |
| --- | --- | --- | --- |
| Wi-Fi/Ethernet | "TCP" | - IP address in IPv4 format<br/>  - MAC address<br/> - Host name | "TCP:192.168.192.168" |
| Bluetooth | "BT" | BD address | "BT:00:22:15:7D:70:9C" |
| USB | "USB" | - Device node<br/> - USB Serial number<br/> - Omitted | "USB:/dev/udev/*", "USB:00000000000000000", "USB:" |

---
#### deviceName

- `string`

The name set to the device is stored.

Example: `TM-T88V`

---
#### lang

- `enum PrinterModelLang`

Specifies the language of the printer.

| **Value** | **Description** |
| --- | --- |
| `PrinterConstants.MODEL_ANK` | ANK model |
| `PrinterConstants.MODEL_CHINESE` | Simplified Chinese model |
| `PrinterConstants.MODEL_TAIWAN` | Taiwan model |
| `PrinterConstants.MODEL_KOREAN` | Korean model |
| `PrinterConstants.MODEL_THAI` | Thai model |
| `PrinterConstants.MODEL_SOUTHASIA` | South Asian model |


Note: The default value is `PrinterConstants.MODEL_ANK`.

### Example
```typescript
const printer = new Printer({
  target: "BT:00:22:15:7D:70:9C",
  deviceName: "TM-T88V",
})
```


