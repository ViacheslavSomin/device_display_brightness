# device_display_brightness

[pub_badge]

A Flutter plugin to manage the device's display brightness on Android and iOS.

## Usage


## Android setup
Add this permission to AndroidManifest.xml

```xml
<uses-permission android:name="android.permission.WAKE_LOCK" />
```

## iOS setup

No setup needed.


## Install

In the `pubspec.yaml` of your flutter project, add the following dependency:

```yaml
dependencies:
  device_display_brightness: <latest_version>
```

In your library add the following import:

```dart
import 'package:device_display_brightness/device_display_brightness.dart';
```

## Example

```dart
// Set the brightness:
DeviceDisplayBrightness.setBrightness(0.13);

// Get the current brightness:
double brightness = await DeviceDisplayBrightness.getBrightness();

// Check if device's display is keeping turned on:
bool isKeptOn = await DeviceDisplayBrightness.isKeptOn();

// Prevent display from going into sleep mode:
DeviceDisplayBrightness.keepOn(isOn: true);

// Android only
// Resets brightness to system value.
DeviceDisplayBrightness.resetBrightness();
```


<!-- Links -->
[pub_badge]: https://img.shields.io/pub/v/device_display_brightness.svg
