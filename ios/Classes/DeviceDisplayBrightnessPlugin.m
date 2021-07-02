#import "DeviceDisplayBrightnessPlugin.h"
#if __has_include(<device_display_brightness/device_display_brightness-Swift.h>)
#import <device_display_brightness/device_display_brightness-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "device_display_brightness-Swift.h"
#endif

@implementation DeviceDisplayBrightnessPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftDeviceDisplayBrightnessPlugin registerWithRegistrar:registrar];
}
@end
