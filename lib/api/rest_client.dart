import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_butailing/config/config.dart';
import 'package:flutter_butailing/config/oauth.dart';
import 'package:flutter_butailing/model/index.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: 'https://web5.mukaku.com/prod/api/v1')
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  // static final CookieJar cookieJar = CookieJar();

  static Dio get dio {
    final options = BaseOptions(
      receiveTimeout: Duration(seconds: 30),
      sendTimeout: Duration(seconds: 30),
      connectTimeout: Duration(seconds: 30),
    );
    return Dio(options);
  }

  static Future<RestClient> get client async {
    // ignore: no_leading_underscores_for_local_identifiers
    final _dio = RestClient.dio;
    // _dio.interceptors.add(CookieManager(RestClient.cookieJar));

    _dio.interceptors.addAll([
      LogInterceptor(requestBody: kDebugMode, responseBody: kDebugMode),
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // 在请求发送前添加逻辑
          // 例如，添加一个自定义的请求头
          options.headers["Custom-Header"] = "value";

          // 添加公共参数
          Map<String, dynamic> commonParams = await Oauth.commonParams;
          if (options.method.toUpperCase() == "GET") {
            // 对于GET请求，添加到URL的查询参数中
            options.queryParameters.addAll(commonParams);
          } else {
            // 对于POST、PUT等请求，添加到请求体中
            final data = options.data ?? {};
            if (data is Map) {
              data.addAll(commonParams);
              options.data = data;
            }
          }

          // 继续执行请求
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // 在响应返回后添加逻辑
          // 例如，打印响应数据

          logger.d(response.data);
          // 继续执行响应
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          // 在发生错误时添加逻辑
          // 例如，根据错误类型显示不同的错误信息
          logger.d(e.message);
          // 继续执行错误处理
          return handler.next(e);
        },
      ),
    ]);
    return RestClient(_dio);
  }

  @GET('/routesAll')
  Future<ApiResponse<List<RoutesAll>>> routesAll();

  @GET("/getVideoList")
  Future<ApiResponse<DataWrapper<List<VideoList>>>> getVideoList({
    @Query("sc") required int sc,
  });
  @GET('/getVideoDetail')
  Future<ApiResponse<VideoDetail>> getVideoDetail({
    @Query("id") required String idcode,
  });

  @GET("/getVideoTypeList")
  Future<ApiResponse<VideoType>> getVideoTypeList();
  @GET('/getVideoMovieList')
  Future<ApiResponse<Paging<MovieItem>>> getVideoMovieList({
    @Query('sa') int sa = 1,
    @Query('sc') int? sc,
    @Query('sct') int? sct,
    @Query('scn') int? scn = 0,
    @Query('sd') int? sd,
    @Query('sdt') int? sdt,
    @Query('se') int? se,
    @Query('sen') int? sen,
    @Query('set') int? set,
    @Query('page') int page = 1,
  });
}
