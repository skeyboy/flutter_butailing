import 'package:flutter_butailing/bridge_client/bridge_rest_client.dart';
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
    await Future.any([
      config(destDir: appDocDir.path),
      Future.delayed(Duration(seconds: 0), () {}),
    ]);
  }
}

extension BridgeManagerApi on BridgeManager {
  Future<dynamic> addTorrent({required String magnet}) async {
    return await BridgeRestClient.client.addTorrent(magnet: magnet);
  }

  Future torrentStats({required String infoHash}) async {
    return await BridgeRestClient.client.torrentStats(infoHash: infoHash);
  }

  Future stats() async {
    return await BridgeRestClient.client.stats();
  }

  Future torrentsist() async {
    return await BridgeRestClient.client.torrentsist();
  }
}
