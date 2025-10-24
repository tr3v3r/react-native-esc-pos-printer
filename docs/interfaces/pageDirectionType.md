# PageDirectionType

Enum that defines the direction for printing in page mode.

## Values

| **Value** | **Description** |
| --- | --- |
| `DIRECTION_LEFT_TO_RIGHT` | Left to right direction (default horizontal text). Value: 0 |
| `DIRECTION_BOTTOM_TO_TOP` | Bottom to top direction (90° counter-clockwise rotation). Value: 1 |
| `DIRECTION_RIGHT_TO_LEFT` | Right to left direction (180° rotation). Value: 2 |
| `DIRECTION_TOP_TO_BOTTOM` | Top to bottom direction (90° clockwise rotation). Value: 3 |

## Usage

The `PageDirectionType` is used with the [`addPageDirection()`](../printer/addPageDirection.md) method to control the orientation of text and graphics in page mode.

### Example

```typescript
import { PrinterConstants } from 'react-native-esc-pos-printer';

// Normal horizontal text (left to right)
await printer.addPageDirection(PrinterConstants.DIRECTION_LEFT_TO_RIGHT);

// Vertical text (90° counter-clockwise)
await printer.addPageDirection(PrinterConstants.DIRECTION_BOTTOM_TO_TOP);

// Upside-down text (180° rotation)
await printer.addPageDirection(PrinterConstants.DIRECTION_RIGHT_TO_LEFT);

// Vertical text (90° clockwise)
await printer.addPageDirection(PrinterConstants.DIRECTION_TOP_TO_BOTTOM);
```

## Visual Representation

```
DIRECTION_LEFT_TO_RIGHT (0)    DIRECTION_BOTTOM_TO_TOP (1)
Text →                         T
                               e
                               x
                               t
                               ↑

DIRECTION_RIGHT_TO_LEFT (2)    DIRECTION_TOP_TO_BOTTOM (3)
                        ← txeT                          ↓
                                                        T
                                                        e
                                                        x
                                                        t
```

## Notes

- Direction changes affect all subsequent content added in page mode
- The direction setting remains active until changed or page mode is ended
- Different printers may have varying support for all direction modes
- Test with your specific printer model to ensure proper functionality