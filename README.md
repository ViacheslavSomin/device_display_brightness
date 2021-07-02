# device_display_brightness

A Flutter plugin to manage the device's display brightness on Android and iOS.

## Usage

For Android, add this permission to AndroidManifest.xml

```
<uses-permission android:name="android.permission.WAKE_LOCK" />
```

## Example

```dart
// Import package
import 'package:device_display_brightness/device_display_brightness.dart';

// Set the brightness:
DeviceDisplayBrightness.setBrightness(0.13);

// Get the current brightness:
double brightness = await DeviceDisplayBrightness.getBrightness();

// Check if device's display is keeping turned on:
bool isKeptOn = await DeviceDisplayBrightness.isKeptOn();

// Prevent display from going into sleep mode:
DeviceDisplayBrightness.keepOn(isOn: true);
```
