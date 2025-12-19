import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_butailing/bridge_client/bridge_response.dart';
import 'package:flutter_butailing/config/config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'bridge_rest_client.g.dart';

@Singleton()
@RestApi()
abstract class BridgeRestClient {
  factory BridgeRestClient(Dio dio, {String? baseUrl}) = _BridgeRestClient;

  static BridgeRestClient get client => GetIt.instance<BridgeRestClient>();

  @FactoryMethod()
  static BridgeRestClient create(Config config) {
    return BridgeRestClient(
      baseUrl: config.torrentApiBaseUrl,
      Dio(
          BaseOptions(baseUrl: config.torrentApiBaseUrl)
            ..sendTimeout = Duration(seconds: 30)
            ..connectTimeout = Duration(seconds: 30)
            ..receiveTimeout = Duration(seconds: 30),
        )
        ..interceptors.addAll([
          LogInterceptor(responseBody: true, requestBody: true),
          InterceptorsWrapper(
            onError: (err, handler) {
              if (err.type == DioExceptionType.cancel) {
                // 记录日志但不传播错误
                if (kDebugMode) {
                  print('请求被取消: ${err.requestOptions.path}');
                }
                return handler.resolve(
                  Response(
                    data: null,
                    requestOptions: err.requestOptions,
                    statusCode: 499, // 客户端关闭请求
                  ),
                );
              }
              return handler.next(err);
            },
          ),
          aliceDioAdapter,
        ]),
    );
  }

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
  Future<ApiResponse<SessionStatsSnapshot>> startApiService({
    @Query("dest_dir") required String destDir,
  });
}
