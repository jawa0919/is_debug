import 'package:flutter_test/flutter_test.dart';
import 'package:is_debug/is_debug.dart';

import 'package:flutter/services.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  IsDebug platform = IsDebug();
  const MethodChannel channel = MethodChannel('is_debug.MethodChannel');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        if (methodCall.method == "getHostPlatformVersion") {
          return "42";
        } else if (methodCall.method == "getHostPlatformName") {
          return "AndIos";
        } else if (methodCall.method == "isDebugHost") {
          return "isDebugHost";
        } else if (methodCall.method == "isSimulatorHost") {
          return "isSimulatorHost";
        } else if (methodCall.method == "isRootHost") {
          return "";
        }
        return '';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getHostPlatformVersion', () async {
    expect(await platform.getHostPlatformVersion(), '42');
  });

  test('getHostPlatformName', () async {
    expect(await platform.getHostPlatformName(), 'AndIos');
  });

  test('isDebugHost', () async {
    expect(await platform.isDebugHost(), true);
  });

  test('getHostPlatformName', () async {
    expect(await platform.isSimulatorHost(), true);
  });

  test('isRootHost', () async {
    expect(await platform.isRootHost(), false);
  });
}
