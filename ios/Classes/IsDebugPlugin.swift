import Flutter
import UIKit

public class IsDebugPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "is_debug.MethodChannel", binaryMessenger: registrar.messenger())
    let instance = IsDebugPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }
  
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
      case "getHostPlatformName":
        result(UIDevice.current.systemName)
      case "getHostPlatformVersion":
        result(UIDevice.current.systemVersion)
      case "isDebugHost":
#if DEBUG
        result("isDebugHost")
#else
        result("")
#endif
      case "isSimulatorHost":
#if targetEnvironment(simulator)
        result("isSimulatorHost")
#else
        result("")
#endif
      case "isRootHost":
        let url = URL(fileURLWithPath: "/private/isRootHost.txt")
        let string = "isRootHost"
        do {
          try string.write(to: url, atomically: true, encoding: .utf8)
          result("isRootHost")
        } catch {
          result("")
        }
      case "isRunningProxy":
        guard let st = CFNetworkCopySystemProxySettings()?.takeUnretainedValue() else {
          result("")
          return
        }
        guard let dict = st as? [String: Any] else {
          result("")
          return
        }
        let isUsed = dict.isEmpty
        guard let httpProxy = dict["HTTPProxy"] as? String else {
          result("")
          return
        }
        if (httpProxy.count > 0) {
          result("isRunningProxy")
        } else {
          result("")
        }
      case "isRunningVpn":
        guard let st = CFNetworkCopySystemProxySettings()?.takeUnretainedValue() else {
          result("")
          return
        }
        guard let dict = st as? [String: Any] else {
          result("")
          return
        }
        let isUsed = dict.isEmpty
        guard let scoped = dict["__SCOPED__"] as? [String: Any] else {
          result("")
          return
        }
        for (key,value) in scoped {
          print("Key: \(key) Value: \(value)")
          if key.contains("tap") || key.contains("tun") || key.contains("ipsec") || key.contains("ppp") {
            result("isRunningVpn");
            return
          }
        }
        result("")
      default:
        result(FlutterMethodNotImplemented)
    }
  }
}
