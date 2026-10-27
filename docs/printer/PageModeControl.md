# Page Mode Control

Page mode provides advanced layout control for ESC/POS printers, allowing precise positioning of text and graphics on a page. This mode is particularly useful for creating complex receipts, labels, and formatted documents.

## Overview

Page mode operates differently from the standard line mode:

- **Line Mode**: Content is printed sequentially line by line
- **Page Mode**: Content is positioned freely within a defined area and printed all at once

## Workflow

The typical workflow for using page mode is:

1. **Define Page Area**: Set the printable area coordinates and dimensions
2. **Set Direction**: Configure text/graphics orientation (optional)
3. **Begin Page Mode**: Start page mode session
4. **Position and Add Content**: Place text, graphics, etc. at specific positions
5. **End Page Mode**: Render and print all positioned content

## Example Usage

```typescript
import { Printer, PrinterConstants } from 'react-native-esc-pos-printer';

const printer = new Printer({
  target: 'BT:00:01:90:5E:AD:13',
  deviceName: 'TM-m10',
});

async function printPageModeReceipt() {
  try {
    // Connect to printer
    await printer.connect();
    
    // 1. Define page area (x, y, width, height in dots)
    await printer.addPageArea(0, 0, 400, 600);
    
    // 2. Set direction (optional)
    await printer.addPageDirection(PrinterConstants.DIRECTION_LEFT_TO_RIGHT);
    
    // 3. Begin page mode
    await printer.addPageBegin();
    
    // 4. Position content and add it
    
    // Header
    await printer.addPagePosition(100, 50);
    await printer.addTextSize({ width: 2, height: 2 });
    await printer.addText('RECEIPT');
    
    // Reset text size
    await printer.addTextSize({ width: 1, height: 1 });
    
    // Item 1
    await printer.addPagePosition(10, 150);
    await printer.addText('Item 1');
    await printer.addPagePosition(300, 150);
    await printer.addText('$10.00');
    
    // Item 2
    await printer.addPagePosition(10, 200);
    await printer.addText('Item 2');
    await printer.addPagePosition(300, 200);
    await printer.addText('$15.00');
    
    // Total
    await printer.addPagePosition(10, 300);
    await printer.addTextStyle({ em: PrinterConstants.TRUE });
    await printer.addText('TOTAL');
    await printer.addPagePosition(300, 300);
    await printer.addText('$25.00');
    
    // 5. End page mode and print
    await printer.addPageEnd();
    
    // Send to printer
    await printer.sendData();
    
  } catch (error) {
    console.error('Printing failed:', error);
  } finally {
    await printer.disconnect();
  }
}
```

## Available Functions

| Function | Purpose |
|----------|---------|
| [`addPageArea()`](./addPageArea.md) | Define the printable area coordinates and dimensions |
| [`addPageDirection()`](./addPageDirection.md) | Set the print direction (orientation) |
| [`addPagePosition()`](./addPagePosition.md) | Position the cursor at specific coordinates |
| [`addPageBegin()`](./addPageBegin.md) | Start page mode session |
| [`addPageEnd()`](./addPageEnd.md) | End page mode and print content |

## Page Direction Constants

| Constant | Value | Description |
|----------|-------|-------------|
| `DIRECTION_LEFT_TO_RIGHT` | 0 | Normal horizontal text (default) |
| `DIRECTION_BOTTOM_TO_TOP` | 1 | 90° counter-clockwise rotation |
| `DIRECTION_RIGHT_TO_LEFT` | 2 | 180° rotation |
| `DIRECTION_TOP_TO_BOTTOM` | 3 | 90° clockwise rotation |

## Best Practices

### 1. Plan Your Layout
- Calculate positions based on your content and printer resolution
- Consider printer paper width and margins
- Test with different content lengths

### 2. Error Handling
```typescript
try {
  await printer.addPageArea(0, 0, 400, 600);
  await printer.addPageBegin();
  // ... add content
  await printer.addPageEnd();
} catch (error) {
  // Handle page mode errors
  console.error('Page mode error:', error);
}
```

### 3. Coordinate System
- Origin (0,0) is typically at the top-left corner
- All measurements are in dots/pixels
- Check your printer's resolution (typically 203 DPI for thermal printers)

### 4. Content Boundaries
- Ensure all content fits within the defined page area
- Position coordinates must be within the page area bounds
- Consider text size when calculating positions

## Limitations

- Not all printers support all page mode features
- Some standard formatting commands may not work in page mode
- Performance may be slower than line mode for simple content
- Memory limitations may restrict complex layouts

## Troubleshooting

### Common Issues

1. **Content Not Printing**: Ensure `addPageEnd()` is called
2. **Text Cut Off**: Check page area dimensions and text positions
3. **Wrong Orientation**: Verify page direction setting
4. **Memory Errors**: Reduce content complexity or page area size

### Testing

Always test page mode layouts with your specific printer model, as behavior may vary between different ESC/POS printer implementations.