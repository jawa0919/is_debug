import 'dart:io';

import 'package:flutter/material.dart';

import 'package:is_debug/is_debug.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _isDebugPlugin = IsDebug();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ...ListTile.divideTiles(context: context, tiles: _b(context))
        ],
      ),
    );
  }

  List<Widget> _b(BuildContext context) {
    return [
      const SizedBox(height: 4),
      ListTile(
        title: Text(Platform.version),
      ),
      ListTile(
        title: const Text('Running on PlatformName: '),
        trailing: FutureBuilder<String?>(
          future: _isDebugPlugin.getHostPlatformName(),
          builder: (c, s) => Text('${s.data}'),
        ),
      ),
      ListTile(
        title: const Text('Running on PlatformVersion: '),
        trailing: FutureBuilder<String?>(
          future: _isDebugPlugin.getHostPlatformVersion(),
          builder: (c, s) => Text('${s.data}'),
        ),
      ),
      ListTile(
        title: const Text('isDebugHost: '),
        trailing: FutureBuilder<bool>(
          future: _isDebugPlugin.isDebugHost(),
          builder: (c, s) => Text('${s.data}'),
        ),
      ),
      ListTile(
        title: const Text('isSimulatorHost: '),
        trailing: FutureBuilder<bool>(
          future: _isDebugPlugin.isSimulatorHost(),
          builder: (c, s) => Text('${s.data}'),
        ),
      ),
      ListTile(
        title: const Text('isRootHost: '),
        trailing: FutureBuilder<bool>(
          future: _isDebugPlugin.isRootHost(),
          builder: (c, s) => Text('${s.data}'),
        ),
      ),
      ListTile(
        title: const Text('isRunningProxy: '),
        trailing: FutureBuilder<bool>(
          future: _isDebugPlugin.isRunningProxy(),
          builder: (c, s) => Text('${s.data}'),
        ),
      ),
      ListTile(
        title: const Text('isRunningVpn: '),
        trailing: FutureBuilder<bool>(
          future: _isDebugPlugin.isRunningVpn(),
          builder: (c, s) => Text('${s.data}'),
        ),
      ),
      const SizedBox(),
    ];
  }
}
