import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/messages.g.dart',
  dartOptions: DartOptions(),
  kotlinOut: 'android/src/main/kotlin/com/example/is_debug/Messages.g.kt',
  kotlinOptions: KotlinOptions(),
  swiftOut: 'ios/Classes/Messages.g.swift',
  swiftOptions: SwiftOptions(),
))
// #docregion host-definitions
@HostApi()
abstract class IsDebugHostApi {
  String getPlatformVersion();

  bool isDebugHost();
}
// #enddocregion host-definitions

// #docregion flutter-definitions
// @FlutterApi()
// abstract class IsDebugFlutterApi {
//   String getFlutterArgs(String? string);
// }
// #enddocregion flutter-definitions
