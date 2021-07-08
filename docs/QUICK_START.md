# Quick Start Example

```javascript
import EscPosPrinter, { getPrinterSeriesByName } from 'react-native-esc-pos-printer';


async function testPrint() {
  try {
      const printers = await EscPosPrinter.discovery()

      const printer = printers[0]

      await EscPosPrinter.init({
        target: printer.target,
        seriesName: getPrinterSeriesByName(printer.name),
      })

      const printing = new EscPosPrinter.printing();

      const status = await printing
        .initialize()
        .align('center')printing
        .initialize()
        .align('center')
        .size(6, 6)
        .line('DUDE!')
        .size(1, 1)
        .text('is that a ')
        .bold()
        .underline()
        .text('printer?')
        .bold()
        .underline()
        .newline(2)
        .align('center')
        .image(image, 200)
        .cut()
        .send()

        console.log('Success:', status)

  } catch(e) {
        console.log('Error:', status)
  }
}


testPrint()

```
See example folder and [API docs](./API.md) for more details.
