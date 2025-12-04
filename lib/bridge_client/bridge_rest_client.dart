import 'package:dio/dio.dart';
import 'package:flutter_butailing/bridge_client/response/api_response.dart';
import 'package:flutter_butailing/bridge_client/response/bridge_response.dart';
import 'package:retrofit/retrofit.dart';
part 'bridge_rest_client.g.dart';

@RestApi(baseUrl: 'http://127.0.0.1:8888')
abstract class BridgeRestClient {
  factory BridgeRestClient(Dio dio, {String? baseUrl}) = _BridgeRestClient;
  static final BridgeRestClient _client = BridgeRestClient(
    Dio(
        BaseOptions()
          ..sendTimeout = Duration(seconds: 30)
          ..connectTimeout = Duration(seconds: 30)
          ..receiveTimeout = Duration(seconds: 30),
      )
      ..interceptors.addAll([
        LogInterceptor(responseBody: true, requestBody: true),
      ]),
  );
  static BridgeRestClient get client => _client;

  @GET("/api/v1/add_torrent")
  Future<ApiResponse<ApiAddTorrentResponse>> addTorrent({
    @Query('magnet') required String magnet,
  });

  @GET("/api/v1/torrent_stats")
  Future<ApiResponse<TorrentStats>> torrentStats({
    @Query('info_hash') required String infoHash,
  });

  @GET("/api/v1/stats")
  Future<SessionStatsSnapshot> stats();

  @GET("/api/v1/torrents_list")
  Future<TorrentListResponse> torrentsist();

  @GET("/")
  Future hello();
}
