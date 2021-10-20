# Printing methods

### initialize

Initializes the chaining object - this must be the first call in the chain

```javascript
printing.initialize().text('printer?');
```

### text

Prints text

```javascript
printing.initialize().text('printer?');
```

### new line

Prints n numbers of newlines, defaults to 1 newline

```javascript
printing.initialize().newline(n);
```

### line

Prints text followed by a new line

```javascript
printing.initialize().line('Cats eating mangos right off the tree');
```

### underline

Sets the underline state - optional boolean parameter, if no parameter is supplied it will toggle the underline state

```javascript
printing.initialize().underline();
```

### bold

Sets the bold state - optional boolean parameter, if no parameter is supplied it will toggle the bold state

```javascript
printing.initialize().bold();
```

### smooth

Sets the smooth state - optional boolean parameter, if no parameter is supplied it will toggle the smooth state

```javascript
printing.initialize().smooth();
```

### size

Sets the text size. Text can be scaled from size 1 - 8. Optional width parameter, if not provided text will be scaled equal to the height.

```javascript
printing.initialize().size(5, 4);
```

### align

Sets the text alignment. Valid values are 'left' | 'center' | 'right'.

```javascript
printing.initialize().align('center');
```

### image

Prints an image from iOS/Android local assets folder.

- Android: Save your image file under the directory `android/app/src/main/assets`. Note that files in this directory must be lowercase.
- iOS: Open Xcode and add your image file to the project (Right-click the project and select `Add Files to [PROJECTNAME]`)
- Use file name as first argument and image width as a second (width of the image 1 to 65535)

```javascript
printing.initialize().imageAsset('logo.png', 200);
```

### base64 image

Prints an image represented by base64 data (i.e. "data:image/png;base64,...").

- Use base64 string as first argument and image width as a second (width of the image 1 to 65535)
- If image is not printing for some reason try to play with width
- See example of usage in `example` folder

```javascript
export const base64Image =
  'data:image/png;base64,....'

printing.initialize().imageBase64(base64Image, 75);
```

### data
Adds the given binary data (Uint8Array) to the print queue
See example folder for more details.

```javascript
printing.initialize().data(uint8ArrayData);
```

### cut

Adds a cut to the paper

```javascript
printing.initialize().cut();
```

### send

Is required at the end of a printer chain to send the commands to the printer

```javascript
printing.initialize().text("hello, is it me you're looking for").send();
```

##### return type

```typescript
interface IMonitorStatus {
  connection: string;
  online: string;
  coverOpen: string;
  paper: string;
  paperFeed: string;
  panelSwitch: string;
  drawer: string;
  errorStatus: string;
  autoRecoverErr: string;
  adapter: string;
  batteryLevel: string;
}
```
