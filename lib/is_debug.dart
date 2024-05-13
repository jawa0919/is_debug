import 'package:flutter/services.dart';

class IsDebug {
  static const mc = MethodChannel('is_debug.MethodChannel');

  Future<String?> getHostPlatformName() async {
    final name = await mc.invokeMethod<String>('getHostPlatformName');
    return name;
  }

  Future<String?> getHostPlatformVersion() async {
    final version = await mc.invokeMethod<String>('getHostPlatformVersion');
    return version;
  }

  Future<bool> isDebugHost() async {
    final res = await mc.invokeMethod<String>('isDebugHost');
    return res == "isDebugHost";
  }

  Future<bool> isSimulatorHost() async {
    final res = await mc.invokeMethod<String>('isSimulatorHost');
    return res == "isSimulatorHost";
  }

  Future<bool> isRootHost() async {
    final res = await mc.invokeMethod<String>('isRootHost');
    return res == "isRootHost";
  }

  Future<bool> isRunningProxy() async {
    final res = await mc.invokeMethod<String>('isRunningProxy');
    return res == "isRunningProxy";
  }

  Future<bool> isRunningVpn() async {
    final res = await mc.invokeMethod<String>('isRunningVpn');
    return res == "isRunningVpn";
  }
}
