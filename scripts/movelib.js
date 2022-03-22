const fs = require('fs-extra');
const path = require('path');

const libCurrentPath = path.join(
  __dirname,
  '../node_modules/react-native-esc-pos-printer-sdk/ios'
);

const libDestPath = path.join(__dirname, '../ios/PrinterSDK');

// copy iOS sdk
fs.copy(libCurrentPath, libDestPath, (err) => {
  if (err) return console.error(err);
  console.log('iOS SDK copied!');
});

const libAndroidCurrentPath = path.join(
  __dirname,
  '../node_modules/react-native-esc-pos-printer-sdk/android/libs'
);

const libAndroidDestPath = path.join(__dirname, '../android/libs');

const jnilibAndroidCurrentPath = path.join(
  __dirname,
  '../node_modules/react-native-esc-pos-printer-sdk/android/jniLibs'
);

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
