// import 'package:flutter_test/flutter_test.dart';
// import 'package:is_debug/is_debug.dart';
// import 'package:is_debug/is_debug_platform_interface.dart';
// import 'package:is_debug/is_debug_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';
//
// class MockIsDebugPlatform
//     with MockPlatformInterfaceMixin
//     implements IsDebugPlatform {
//
//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }
//
// void main() {
//   final IsDebugPlatform initialPlatform = IsDebugPlatform.instance;
//
//   test('$MethodChannelIsDebug is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelIsDebug>());
//   });
//
//   test('getPlatformVersion', () async {
//     IsDebug isDebugPlugin = IsDebug();
//     MockIsDebugPlatform fakePlatform = MockIsDebugPlatform();
//     IsDebugPlatform.instance = fakePlatform;
//
//     expect(await isDebugPlugin.getPlatformVersion(), '42');
//   });
// }
