import Flutter
import UIKit

public class SwiftDeviceDisplayBrightnessPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "github.com/SVD13/device_display_brightness", binaryMessenger: registrar.messenger())
        let instance = SwiftDeviceDisplayBrightnessPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getBrightness":
            result(UIScreen.main.brightness)
            break
        case "setBrightness":
            if let arguments = call.arguments as? [String:Any] {
                let brightness: Double = arguments["brightness"] as! Double
                UIScreen.main.brightness = CGFloat(brightness)
            }
            break
        case "isKeptOn":
            let isIdleTimerDisabled: Bool = UIApplication.shared.isIdleTimerDisabled
            result(isIdleTimerDisabled)
            break
        case "keepOn":
            if let arguments = call.arguments as? [String:Any] {
                let isOn: Bool = arguments["on"] as! Bool
                UIApplication.shared.isIdleTimerDisabled = isOn
            }
            break
        default:
            result("Flutter method not imlemented")
            break
            
        }
    }
}
