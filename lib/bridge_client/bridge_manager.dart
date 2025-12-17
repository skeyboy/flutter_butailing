import 'package:flutter/foundation.dart';
import 'package:flutter_butailing/bridge_client/bridge_rest_client.dart';
import 'package:flutter_butailing/bridge_client/bridge_response.dart';
import 'package:flutter_butailing/config/app_inject.dart';
import 'package:flutter_rqbit/flutter_rqbit.dart';
import 'package:path_provider/path_provider.dart';

class BridgeManager with AppInject {
  BridgeManager._();
  static final BridgeManager _manager = BridgeManager._();
  static BridgeManager get manager => _manager;
  Future<void> initBridge() async {
    await RustLib.init();
  }

  Future<void> startBridgeServe({
    String? destDir,
    String? addr = "0.0.0.0",
    int? port = 8888,
  }) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    if (kDebugMode) {
      print("BridgeManager.startBridgeServe $appDocDir");
    }
    await Future.any([
      // 启动内置api服务器
      startService(destDir: destDir ?? appDocDir.path, addr: addr, port: port),
      Future.delayed(Duration(seconds: 5), () {}),
    ]);
    final startResult = await BridgeManager.manager.startApiService(
      destDir: destDir ?? appDocDir.path,
    );
    if (kDebugMode) {
      print("startApiService $startResult");
    }
    // final startResult = await startApiService(workDir: appDocDir.path);
    final result = await stats();
    if (kDebugMode) {
      print("startBridgeServe start stats check  $result");
    }
  }
}

extension BridgeManagerApi on BridgeManager {
  BridgeRestClient get client => getIt<BridgeRestClient>();

  Future<ApiResponse<ApiAddTorrentResponse>> addTorrent({
    required String magnet,
  }) async {
    return await client.addTorrent(magnet: magnet);
  }

  Future<ApiResponse<TorrentStats>> torrentStats({
    required String infoHash,
  }) async {
    return await client.torrentStats(infoHash: infoHash);
  }

  Future<ApiResponse<SessionStatsSnapshot>> stats() async {
    return await client.stats();
  }

  Future<TorrentListResponse> torrentsist() async {
    return await client.torrentsist();
  }

  Future<ApiResponse<dynamic>> deleteTorrent({
    int? id,
    String? infoHash,
  }) async {
    return await client.deleteTorrent(id: id, infoHash: infoHash);
  }

  Future<ApiResponse<ApiAddTorrentResponse>> addTorrentFile({
    required String torrentContent,
  }) async {
    return await client.addTorrentFile(torrentContent: torrentContent);
  }

  Future<ApiResponse<dynamic>> startTorrent({int? id, String? infoHash}) async {
    return await client.startTorrent(id: id, infoHash: infoHash);
  }

  Future<ApiResponse<dynamic>> pauseTorrent({int? id, String? infoHash}) async {
    return await client.pauseTorrent(id: id, infoHash: infoHash);
  }

  Future<ApiResponse<TorrentDetailsResponse>> torrentDetail({
    int? id,
    String? infoHash,
  }) async {
    return await client.torrentDetail(id: id, infoHash: infoHash);
  }

  Future<ApiResponse<SessionStatsSnapshot>> startApiService({
    required String destDir,
  }) async {
    return await client.startApiService(destDir: destDir);
  }
}
