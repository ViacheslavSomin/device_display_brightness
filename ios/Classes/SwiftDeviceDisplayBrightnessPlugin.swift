import Flutter
import UIKit

public class SwiftDeviceDisplayBrightnessPlugin: NSObject, FlutterPlugin {
    
    private var systemBrightness: CGFloat
    
    private var overridenBrightness: CGFloat
    
    public override init() {
        self.systemBrightness = UIScreen.main.brightness
        self.overridenBrightness = UIScreen.main.brightness
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "github.com/SVD13/device_display_brightness", binaryMessenger: registrar.messenger())
        let instance = SwiftDeviceDisplayBrightnessPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        registrar.addApplicationDelegate(instance)
        
//        NotificationCenter.default.addObserver(
//            instance,
//            selector: #selector(brightnessDidChange),
//            name: UIScreen.brightnessDidChangeNotification,
//            object: nil
//        )
    }
    
//    public func detachFromEngine(for registrar: FlutterPluginRegistrar) {
//        NotificationCenter.default.removeObserver(self)
//    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getBrightness":
            result(UIScreen.main.brightness)
            break
        case "setBrightness":
            if let arguments = call.arguments as? [String: Any] {
                let brightness: Double = arguments["brightness"] as! Double
                UIScreen.main.brightness = CGFloat(brightness)
                self.overridenBrightness = CGFloat(brightness)
            }
            break
        case "isKeptOn":
            let isIdleTimerDisabled: Bool = UIApplication.shared.isIdleTimerDisabled
            result(isIdleTimerDisabled)
            break
        case "keepOn":
            if let arguments = call.arguments as? [String: Any] {
                let enabled: Bool = arguments["enabled"] as! Bool
                UIApplication.shared.isIdleTimerDisabled = enabled
            }
            break
        case "resetBrightness":
            UIScreen.main.brightness = self.systemBrightness
            self.overridenBrightness = self.systemBrightness
            break
        default:
            result("Flutter method not imlemented")
            break
        }
    }
    
    public func applicationWillResignActive(_ application: UIApplication) {
        UIScreen.main.brightness = self.systemBrightness
    }
    
    public func applicationWillEnterForeground(_ application: UIApplication) {
        UIScreen.main.brightness = self.overridenBrightness
    }
    
    public func applicationDidBecomeActive(_ application: UIApplication) {
        UIScreen.main.brightness = self.overridenBrightness
    }
    
//    @objc func brightnessDidChange() {
//        self.systemBrightness = UIScreen.main.brightness
//    }
    
}
