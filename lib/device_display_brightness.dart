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

  /// [brightness] can be used to override the user's preferred brightness of
  /// the screen. 0 to 1 adjusts the brightness from
  /// dark to full bright.
  static Future<void> setBrightness(double brightness) async {
    if (Platform.isIOS || Platform.isAndroid) {
      return _channel.invokeMethod(
        'setBrightness',
        {'brightness': brightness.clamp(0.0, 1.0)},
      );
    }
  }

  /// Resets brightness to system value.
  /// Has no effect on iOS.
  static Future<void> resetBrightness() async {
    if (Platform.isAndroid) {
      return await _channel.invokeMethod('resetBrightness');
    }
  }

  /// Returns `true` if the device's screen is keeping turned on.
  static Future<bool> isKeptOn() async {
    return await _channel.invokeMethod<bool>('isKeptOn') ?? false;
  }

  /// If [isOn] == `true`, the device's screen will be keeping turned on.
  static Future<void> keepOn({required bool isOn}) async {
    return _channel.invokeMethod(
      'keepOn',
      {'on': isOn},
    );
  }
}
