# iOS real device flipper workaround

Issue - https://github.com/tr3v3r/react-native-esc-pos-printer/issues/44

1) `yarn add patch-package postinstall-postinstall`. Details [here](https://www.npmjs.com/package/patch-package)
2) Put [this file](https://github.com/tr3v3r/react-native-esc-pos-printer/blob/main/example/Flipper-Folly.podspec) to the root folder of your app.
3) In the root dir create `patches` folder and create file `react-native+{you RN version}.patch`. With the [this content.](https://github.com/tr3v3r/react-native-esc-pos-printer/blob/main/example/patches/react-native%2B0.72.6.patch)
4) in package.json in the `scripts` section add:
```
 "scripts": {
   "postinstall": "patch-package"
 }
 ```
 Now you can run `yarn` or `npm` and re-run `pods` installation.

 I've added this workaround to the example folder. Corresponding [commit here](https://github.com/tr3v3r/react-native-esc-pos-printer/commit/13f4ceefa11cd29ab98a2b83d9196a80e2847576).

 **Explanation**:
 Since the crash was caused by the conflict between versions of the OpenSSL lib in the Flipper_Folly dependencies and iOS ESC POS SDK dependencies, I've tried to apply the version from the SDK to Flipper_Folly. For that, I had to modify Flipper_Folly podspec and specify manually the needed version for OpenSSL lib.

For me, it works. I've tried to run the app on a real device and tried to debug using Flipper.
I'd really appreciate it if someone could share the feedback if the workaround works for them also.

P.S.
And finally, we're trying to reach DEV team of EPSON iOS SDK to ask them to help with this also. Probably bump the version of the OpenSSL or at least provide a bit less "hacky" solution.
