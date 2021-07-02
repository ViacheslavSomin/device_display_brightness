#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint device_display_brightness.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'device_display_brightness'
  s.version          = '0.0.1'
  s.summary          = 'A Flutter plugin to manage the device\'s display brightness on Android and iOS.'
  s.homepage         = 'https://github.com/SVD13/device_display_brightness'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Somin Viacheslav' => 'somin.viacheslav@gmail.com' }
  s.source           = { :path => 'https://github.com/SVD13/device_display_brightness' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
