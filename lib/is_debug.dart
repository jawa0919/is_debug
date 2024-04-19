library is_debug;

import 'src/messages.g.dart';

class IsDebug {
  Future<String?> getPlatformVersion() async {
    return IsDebugHostApi().getPlatformVersion();
  }

  Future<bool?> isDebugHost() async {
    return IsDebugHostApi().isDebugHost();
  }
}
