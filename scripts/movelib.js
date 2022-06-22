const fs = require('fs-extra');
const path = require('path');
const fsNative = require('fs');

let dir = '../../react-native-esc-pos-printer-sdk';

if (!fsNative.existsSync(path.join(__dirname, dir))) {
  dir = '../node_modules/react-native-esc-pos-printer-sdk';
}

const libCurrentPath = path.join(__dirname, dir, 'ios');

const libDestPath = path.join(__dirname, '../ios/PrinterSDK');

// copy iOS sdk
fs.copy(libCurrentPath, libDestPath, (err) => {
  if (err) return console.error(err);
  console.log('iOS SDK copied!');
});

const libAndroidCurrentPath = path.join(__dirname, dir, 'android/libs');

const libAndroidDestPath = path.join(__dirname, '../android/libs');

const jnilibAndroidCurrentPath = path.join(__dirname, dir, 'android/jniLibs');

const jnilibAndroidDestPath = path.join(
  __dirname,
  '../android/src/main/jniLibs'
);

// copy Android sdk
fs.copy(libAndroidCurrentPath, libAndroidDestPath, (err) => {
  if (err) return console.error(err);
  console.log('Android lib copied!');
});

fs.copy(jnilibAndroidCurrentPath, jnilibAndroidDestPath, (err) => {
  if (err) return console.error(err);
  console.log('Android jniLibs copied!');
});
