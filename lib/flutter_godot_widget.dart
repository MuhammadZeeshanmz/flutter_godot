
import 'flutter_godot_widget_platform_interface.dart';

class FlutterGodotWidget {
  Future<String?> getPlatformVersion() {
    return FlutterGodotWidgetPlatform.instance.getPlatformVersion();
  }
  Future<void> openGame() {
    return FlutterGodotWidgetPlatform.instance.openGame();
  }
  Future<String?> sendData2Game(String dATA) {
    return FlutterGodotWidgetPlatform.instance.sendData2Game(dATA);
  }
}
