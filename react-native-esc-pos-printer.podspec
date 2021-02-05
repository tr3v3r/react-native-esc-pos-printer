require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-esc-pos-printer"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]

  s.platforms    = { :ios => "10.0" }
  s.source       = { :git => "https://github.com/tr3v3r/react-native-esc-pos-printer.git", :tag => "#{s.version}" }


  s.source_files = "ios/**/*.{h,m,mm,swift}"
  s.ios.vendored_libraries = "ios/PrinterSDK/libepos2.a"
  s.libraries = "xml2.2"
  s.framework = "ExternalAccessory"
  s.xcconfig = { 'HEADER_SEARCH_PATHS' => '"${PROJECT_DIR}/PrinterSDK"/**' }

  s.dependency "React-Core"
end
