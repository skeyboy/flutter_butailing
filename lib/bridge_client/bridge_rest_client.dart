import 'package:dio/dio.dart';
import 'package:flutter_butailing/bridge_client/bridge_response.dart';
import 'package:flutter_butailing/config/config.dart';
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
        aliceDioAdapter,
      ]),
  );
  static BridgeRestClient get client => _client;

  @GET("/api/v1/add_torrent")
  Future<ApiResponse<ApiAddTorrentResponse>> addTorrent({
    @Query('magnet') required String magnet,
  });

  @POST("/api/v1/add_torrent_file")
  Future<ApiResponse<ApiAddTorrentResponse>> addTorrentFile({
    @BodyExtra('torrent_content') required String torrentContent,
  });

  @GET("/api/v1/torrent_stats")
  Future<ApiResponse<TorrentStats>> torrentStats({
    @Query('info_hash') required String infoHash,
  });

  @GET("/api/v1/stats")
  Future<ApiResponse<SessionStatsSnapshot>> stats();

  @GET("/api/v1/torrents_list")
  Future<TorrentListResponse> torrentsist();
  @GET("/")
  Future hello();

  @GET('/api/v1/delete_torrent')
  Future<ApiResponse<dynamic>> deleteTorrent({
    @Query("id") int? id,
    @Query("info_hash") String? infoHash,
  });

  @GET('/api/v1/start_torrent')
  Future<ApiResponse<dynamic>> startTorrent({
    @Query("id") int? id,
    @Query("info_hash") String? infoHash,
  });

  @GET('/api/v1/pause_torrent')
  Future<ApiResponse<dynamic>> pauseTorrent({
    @Query("id") int? id,
    @Query("info_hash") String? infoHash,
  });

  @GET("/api/v1/torrent_details")
  Future<ApiResponse<TorrentDetailsResponse>> torrentDetail({
    @Query("id") int? id,
    @Query("info_hash") String? infoHash,
  });

  @GET("/api/v1/start_api_service")
  Future<ApiResponse<SessionStatsSnapshot>> startApiService({@Query("dest_dir") required String destDir});
}
