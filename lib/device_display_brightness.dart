import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

class DeviceDisplayBrightness {
  static const MethodChannel _channel =
      const MethodChannel('github.com/SVD13/device_display_brightness');

  /// Returns the display backlight brightness between 0 and 1.
  static Future<double> getBrightness() async {
    return await _channel.invokeMethod<double>('getBrightness') ?? 0;
  }

  /// The value of [brightness] should be a number between 0.0 and 1.0, inclusive.
  ///
  /// In iOS:
  /// Brightness changes made by an app remain in effect until
  /// the device is locked, regardless of whether the app is closed.
  /// The system brightness (which the user can set in Settings or Control Center)
  /// is restored the next time the display is turned on.
  ///
  /// In Android:
  /// This method overrides system brightness while the app is in the foreground.
  static Future<void> setBrightness(double brightness) async {
    if (Platform.isIOS || Platform.isAndroid) {
      return _channel.invokeMethod(
        'setBrightness',
        {'brightness': brightness.clamp(0.0, 1.0)},
      );
    }
  }

  /// In iOS:
  /// Resets brightness to last known system value.
  /// System value is fetched, when app starts.
  ///
  /// In Android:
  /// Resets brightness to system value.
  static Future<void> resetBrightness() async {
    if (Platform.isIOS || Platform.isAndroid) {
      return await _channel.invokeMethod('resetBrightness');
    }
  }

  /// Returns `true` if the device's screen is keeping turned on.
  static Future<bool> isKeptOn() async {
    return await _channel.invokeMethod<bool>('isKeptOn') ?? false;
  }

  /// If [enabled] == `true`, the device's screen will be keeping turned on.
  static Future<void> keepOn({required bool enabled}) async {
    return _channel.invokeMethod(
      'keepOn',
      {'enabled': enabled},
    );
  }
}
