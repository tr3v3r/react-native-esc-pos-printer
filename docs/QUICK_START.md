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
        language: 'EPOS2_LANG_EN',
      })

      const printing = new EscPosPrinter.printing();

      const status = await printing
        .initialize()
        .align('center')
        .size(3, 3)
        .line('DUDE!')
        .smooth()
        .line('DUDE!')
        .smooth()                
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
        .barcode({
          value:'Test123',
          type:'EPOS2_BARCODE_CODE93',
          hri:'EPOS2_HRI_BELOW',
          width:2,
          height:50,
        })
        .qrcode({
          value: 'Test123',
          level: 'EPOS2_LEVEL_M',
          width: 5,
        })
        .cut()
        .addPulse()
        .send()

        console.log('Success:', status)

  } catch(e) {
        console.log('Error:', status)
  }
}


testPrint()

```
See example folder and [API docs](./API.md) for more details.
