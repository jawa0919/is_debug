import Flutter
import UIKit

public class IsDebugPlugin: NSObject, FlutterPlugin, IsDebugHostApi {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let messenger = registrar.messenger()
        let api = IsDebugPlugin.init()
        IsDebugHostApiSetup.setUp(binaryMessenger: messenger, api: api);
    }
    
    func getPlatformVersion() throws -> String {
        return "iOS " + UIDevice.current.systemVersion;
    }
    
    func isDebugHost() throws -> Bool {
#if DEBUG
        return true
#else
        return false
#endif
    }
}
