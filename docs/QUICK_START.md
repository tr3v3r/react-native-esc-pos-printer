# Quick Start Example

<img src="../assets/quickprint.png"
     alt="Receipt`"
     height="300"
/>

```javascript
import EscPosPrinter, { getPrinterSeriesByName } from 'react-native-esc-pos-printer';


async function testPrint() {
  try {
      const printers = await EscPosPrinter.discover()

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
          .smooth(true)
          .line('DUDE!')
          .smooth(false)
          .size(1, 1)
          .text('is that a ')
          .bold()
          .underline()
          .text('printer?')
          .newline()
          .bold()
          .underline()
          .align('left')
          .text('Left')
          .newline()
          .align('right')
          .text('Right')
          .newline()
          .size(1, 1)
          .textLine(48, {
            left: 'Cheesburger',
            right: '3 EUR',
            gapSymbol: '_',
          })
          .newline()
          .textLine(48, {
            left: 'Chickenburger',
            right: '1.5 EUR',
            gapSymbol: '.',
          })
          .newline()
          .size(2, 2)
          .textLine(48, { left: 'Happy Meal', right: '7 EUR' })
          .newline()
          .align('left')
          .text('Left')
          .newline()

          .align('right')
          .text('Right')
          .newline()

          .align('center')
          .image(require('./store.png'), {
            width: 75,
            halftone: 'EPOS2_HALFTONE_THRESHOLD',
          })

          .image({ uri: base64Image }, { width: 75 })
          .image(
            {
              uri:
                'https://raw.githubusercontent.com/tr3v3r/react-native-esc-pos-printer/main/ios/store.png',
            },
            { width: 75 }
          )
          .barcode({
            value: 'Test123',
            type: 'EPOS2_BARCODE_CODE93',
            width: 2,
            height: 50,
            hri: 'EPOS2_HRI_BELOW',
          })
          .qrcode({
            value: 'Test123',
            level: 'EPOS2_LEVEL_M',
            width: 5,
          })
          .cut()
          .send();

        console.log('Success:', status)

  } catch(e) {
        console.log('Error:', status)
  }
}


testPrint()

```
See example folder and [API docs](./API.md) for more details.
