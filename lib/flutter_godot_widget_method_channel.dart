import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_godot_widget_platform_interface.dart';

/// An implementation of [FlutterGodotWidgetPlatform] that uses method channels.
class MethodChannelFlutterGodotWidget extends FlutterGodotWidgetPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_godot_widget');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
  @override
  Future<void> openGame() async {
    
    //final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    //startEvent();
    await methodChannel.invokeMethod("openGame");//GodotHandler("ad");
    print('Result from Android: WE STARTED GODOT');
    
  }
  
  @override
  Future<String?> sendData2Game(String data) async {
    try {
      await methodChannel.invokeMethod("sendData2Godot", {"data": data});
      return "a";
    } catch (e) {
      print("Error sending data to native godot: $e");
      return "";
    }
    return"";
  }
}