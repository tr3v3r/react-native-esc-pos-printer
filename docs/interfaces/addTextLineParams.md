# Interface: AddTextLineParams

### left

*left*: `string`

Left part of the text.

### right

*right*: `string`

Right part of the text.

### gapSymbol (optional)

*gapSymbol?*: `string`

Symbol used to fill the gap between left and right parts.

### textToWrap (optional)

*textToWrap?*: `"left" | "right"`

If the text part is too long, it will be wrapped to the next line. Default: `"left"`.

### textToWrapWidth (optional)

*textToWrapWidth?*: `number`

Width of the text to wrap from 0 to 1 depending on the charsPerLine. If not specified, it will be calculated automatically based on the text length.


