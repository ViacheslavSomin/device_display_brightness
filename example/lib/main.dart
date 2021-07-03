import 'package:device_display_brightness/device_display_brightness.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _brightness = 0.0;

  @override
  void initState() {
    super.initState();
    _getBrightness();
  }

  void _getBrightness() {
    DeviceDisplayBrightness.getBrightness().then((value) {
      setState(() {
        _brightness = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Device display brightness'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Brightness = $_brightness',
                style: TextStyle(color: Colors.black),
              ),
              ElevatedButton(
                onPressed: () {
                  _getBrightness();
                },
                child: Text('Get brightness value'),
              ),
              ElevatedButton(
                onPressed: () {
                  DeviceDisplayBrightness.setBrightness(0.0);
                },
                child: Text('Apply brightness 0%'),
              ),
              ElevatedButton(
                onPressed: () {
                  DeviceDisplayBrightness.setBrightness(0.25);
                },
                child: Text('Apply brightness 25%'),
              ),
              ElevatedButton(
                onPressed: () {
                  DeviceDisplayBrightness.setBrightness(0.5);
                },
                child: Text('Apply brightness 50%'),
              ),
              ElevatedButton(
                onPressed: () {
                  DeviceDisplayBrightness.setBrightness(0.75);
                },
                child: Text('Apply brightness 75%'),
              ),
              ElevatedButton(
                onPressed: () {
                  DeviceDisplayBrightness.setBrightness(1.0);
                },
                child: Text('Apply brightness 100%'),
              ),
              ElevatedButton(
                onPressed: () {
                  DeviceDisplayBrightness.resetBrightness();
                },
                child: Text('Reset to system value'),
              ),
              ElevatedButton(
                onPressed: () {
                  DeviceDisplayBrightness.keepOn(enabled: true);
                },
                child: Text('Enable keepOn'),
              ),
              ElevatedButton(
                onPressed: () {
                  DeviceDisplayBrightness.keepOn(enabled: false);
                },
                child: Text('Disable keepOn'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
