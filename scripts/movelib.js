const mv = require('mv');
const path = require('path');
var fs = require('fs');

var dir = path.join(__dirname, '../ios/PrinterSDK');

if (!fs.existsSync(dir)) {
  fs.mkdirSync(dir);
}

const libCurrentPath = path.join(
  __dirname,
  '../node_modules/react-native-esc-pos-printer-ios-sdk',
  'libepos2.a'
);
const libDestPath = path.join(__dirname, '../ios/PrinterSDK', 'libepos2.a');

const headerCurrentPath = path.join(
  __dirname,
  '../node_modules/react-native-esc-pos-printer-ios-sdk',
  'ePOS2.h'
);
const headerDestPath = path.join(__dirname, '../ios/PrinterSDK', 'ePOS2.h');

mv(libCurrentPath, libDestPath, function (err) {
  if (err) {
    throw err;
  } else {
    console.log('Lib Successfully moved!');
  }
});

mv(headerCurrentPath, headerDestPath, function (err) {
  if (err) {
    throw err;
  } else {
    console.log('Header Successfully moved!');
  }
});
