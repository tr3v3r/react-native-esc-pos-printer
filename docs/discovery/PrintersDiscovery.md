# Class: PrintersDiscovery
Controls the device discovery function.

## Methods
### start

*start(`params`): `void`*

Starts searching for the specified device type. An event is generated for each device detected.

*By default search will be stopped after 5 seconds. To change this behavior, use the `timeout` parameter.*

##### Parameters

| **Name** | **Type** | **Description** |
| --- | --- | --- |
| params | [`DiscoveryStartParams`](../interfaces/discoveryStartParams.md) | The search params. |

##### Returns

`void`

##### Example

```typescript
PrintersDiscovery.start({
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
PrintersDiscovery.stop();
```

---

### onDiscovery

*onDiscovery(`listener`): `remove()`*

Adds a listener for the `discovery` event.

##### Parameters

| **Name** | **Type** | **Description** |
| --- | --- | --- |
| listener | (printers: [DeviceInfo](../interfaces/deviceInfo.md)[] ) => `void` | The listener function. |

##### Returns

`remove()`

Function to remove listener.


##### Example

```typescript
PrintersDiscovery.onDiscovery((printers) => {
  console.log(printers); // will be called when every new printer is discovered
});
```

---

### onStatusChange

*onStatusChange(`listener`): `remove()`*

Adds a listener for the `statusChange` event.

##### Parameters

| **Name** | **Type** | **Description** |
| --- | --- | --- |
| listener | (status: 'discovering' | 'inactive' ) => `void` | The listener function. |

##### Returns

`remove()`

Function to remove listener.

#### Example

```typescript
PrintersDiscovery.onStatusChange((status) => {
  console.log(status); // will be called when the discovery status changes
});
```
---

### onError

*onError(`listener`): `remove()`*

Adds a listener for the `error` event.

##### Parameters

| **Name** | **Type** | **Description** |
| --- | --- | --- |
| listener | (error: [PrinterDiscoveryError](../interfaces/printerDiscoveryError.md) ) => `void` | The listener function. |

##### Returns

`remove()`

Function to remove listener.

#### Example

```typescript
PrintersDiscovery.onError((error) => {
  console.log(error); // will be called when an error occurs
});
```

### pairBluetoothDevice *(iOS only)*

*pairBluetoothDevice(`macAddress?: string`): `Promise<void>`*

Controls pairing connection with a Bluetooth device. If macAddress is not provided, a list of available devices will be shown in native dialog.

##### Parameters

| **Name** | **Type** | **Description** |
| --- | --- | --- |
| macAddress | string | The BD address of the printer newly paired is returned. Format: BT:00:11:22:33:44:55 |

##### Returns

`Promise<void>`

#### Example

```typescript
PrintersDiscovery.pairBluetoothDevice().the;
```
