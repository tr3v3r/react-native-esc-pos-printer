# React Hook: usePrintersDiscovery

Controls the device discovery function.

`usePrintersDiscovery()` returns discovery printers props


### Discovery printers props


### start

*start(`params`): `void`*

Starts searching for the specified device type. An event is generated for each device detected.

*By default search will be stopped after 5 seconds. To change this behavior, use the `timeout` parameter.*

##### Parameters

| **Name** | **Type** | **Description** |
| --- | --- | --- |
| params | [`DiscoveryStartParams`](../interfaces/discoveryStartParams.md) | The search params. |

##### Example

```typescript
const { start } = usePrintersDiscovery()

start({
  timeout: 2000,
  filterOption: {
    deviceModel: DiscoveryFilterOption.MODEL_ALL,
  },
});
```

---

### stop

*stop(): `void`*

Stops search.

##### Returns

`void`

##### Example

```typescript
const { stop } = usePrintersDiscovery()

stop();
```

---

### printers

*printers: [DeviceInfo](../interfaces/deviceInfo.md)[]*

Returns the list of discovered devices.
Will be update when every new printer is discovered

```typescript
const { printers, start } = usePrintersDiscovery()

start()
console.log(printers)  // will be update when every new printer is discovered
```
---
### isDiscovering

*isDiscovering: `boolean`*

Returns the status of discovering process as boolean
Resets to true when the search process is started again.

```typescript
const { isDiscovering, start, stop } = usePrintersDiscovery()

start() // isDiscovering -> true
...
stop() // isDiscovering -> false
```

---

### printerError

*printerError: [PrinterDiscoveryError](../interfaces/printerDiscoveryError.md) | `null`*

Returns the error message if an error occurred during the search process. If no error occurred, returns `null`. Resets to null when the search process is started again.

```typescript

const { printerError, start } = usePrintersDiscovery()

start()
console.log(printerError)  // will be update if an error occurred during the search process
```


### pairBluetoothDevice *(iOS only)*

*pairBluetoothDevice(`macAddress?: string`): `void`*

Controls pairing connection with a Bluetooth device. If macAddress is not provided, a list of available devices will be shown in native dialog.

##### Parameters

| **Name** | **Type** | **Description** |
| --- | --- | --- |
| macAddress | string | The BD address of the printer newly paired is returned. Format: BT:00:11:22:33:44:55 |

##### Returns

`void`

#### Example

```typescript
const { pairBluetoothDevice } = usePrintersDiscovery()

pairBluetoothDevice();
```
