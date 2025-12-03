import 'package:flutter_butailing/src/rust/api/simple.dart';
import 'package:flutter_butailing/src/rust/frb_generated.dart';
import 'package:path_provider/path_provider.dart';

class BridgeManager {
  BridgeManager._();
  static final BridgeManager _manager = BridgeManager._();
  static BridgeManager get manager => _manager;
  Future<void> initBridge() async {
    await RustLib.init();
  }

  Future<void> startBridgeServe() async {
    final appDocDir = await getApplicationDocumentsDirectory();

    config(destDir: appDocDir.path);
  }
}
