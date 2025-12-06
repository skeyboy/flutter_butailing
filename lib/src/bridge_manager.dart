import 'package:flutter/foundation.dart';
import 'package:flutter_butailing/bridge_client/bridge_rest_client.dart';
import 'package:flutter_butailing/bridge_client/response/api_response.dart';
import 'package:flutter_butailing/bridge_client/response/bridge_response.dart';
import 'package:flutter_butailing/src/rust/api/simple.dart'
    hide ApiAddTorrentResponse, SessionStatsSnapshot;
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
    if (kDebugMode) {
      print("BridgeManager.startBridgeServe $appDocDir");
    }
    await Future.any([
      // 启动内置api服务器
      startService(destDir: appDocDir.path, addr: "0.0.0.0", port: 8888),
      Future.delayed(Duration(seconds: 5), () {}),
    ]);
    final result = await stats();
    if (kDebugMode) {
      print("startBridgeServe start stats check $result");
    }
  }
}

extension BridgeManagerApi on BridgeManager {
  Future<ApiResponse<ApiAddTorrentResponse>> addTorrent({
    required String magnet,
  }) async {
    return await BridgeRestClient.client.addTorrent(magnet: magnet);
  }

  Future<ApiResponse<TorrentStats>> torrentStats({
    required String infoHash,
  }) async {
    return await BridgeRestClient.client.torrentStats(infoHash: infoHash);
  }

  Future<SessionStatsSnapshot> stats() async {
    return await BridgeRestClient.client.stats();
  }

  Future<TorrentListResponse> torrentsist() async {
    return await BridgeRestClient.client.torrentsist();
  }
}
