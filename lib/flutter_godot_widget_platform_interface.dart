import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_godot_widget_method_channel.dart';

abstract class FlutterGodotWidgetPlatform extends PlatformInterface {
  /// Constructs a FlutterGodotWidgetPlatform.
  FlutterGodotWidgetPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterGodotWidgetPlatform _instance = MethodChannelFlutterGodotWidget();

  /// The default instance of [FlutterGodotWidgetPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterGodotWidget].
  static FlutterGodotWidgetPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterGodotWidgetPlatform] when
  /// they register themselves.
  static set instance(FlutterGodotWidgetPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
  Future<void> openGame() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
  Future<String?> sendData2Game(String data) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
