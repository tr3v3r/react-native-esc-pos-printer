const fs = require('fs');
const path = require('path');

let dir = '../../react-native-esc-pos-printer-sdk';

if (!fs.existsSync(path.join(__dirname, dir))) {
  dir = '../node_modules/react-native-esc-pos-printer-sdk';
}

const libCurrentPath = path.join(__dirname, dir, 'ios');
const libDestPath = path.join(__dirname, '../ios/PrinterSDK');

const libAndroidCurrentPath = path.join(__dirname, dir, 'android/libs');
const libAndroidDestPath = path.join(__dirname, '../android/libs');

const jnilibAndroidCurrentPath = path.join(__dirname, dir, 'android/jniLibs');
const jnilibAndroidDestPath = path.join(
  __dirname,
  '../android/src/main/jniLibs'
);

// Helper to recursively copy directory
function copyDirSync(src, dest) {
  if (!fs.existsSync(src)) return;

  if (!fs.existsSync(dest)) {
    fs.mkdirSync(dest, { recursive: true });
  }

  const entries = fs.readdirSync(src, { withFileTypes: true });

  for (const entry of entries) {
    const srcPath = path.join(src, entry.name);
    const destPath = path.join(dest, entry.name);

    if (entry.isDirectory()) {
      copyDirSync(srcPath, destPath);
    } else {
      fs.copyFileSync(srcPath, destPath);
    }
  }
}

// Copy iOS SDK
try {
  copyDirSync(libCurrentPath, libDestPath);
  console.log('iOS SDK copied!');
} catch (err) {
  console.error(err);
}

// Copy Android libs
try {
  copyDirSync(libAndroidCurrentPath, libAndroidDestPath);
  console.log('Android lib copied!');
} catch (err) {
  console.error(err);
}

// Copy Android jniLibs
try {
  copyDirSync(jnilibAndroidCurrentPath, jnilibAndroidDestPath);
  console.log('Android jniLibs copied!');
} catch (err) {
  console.error(err);
}
