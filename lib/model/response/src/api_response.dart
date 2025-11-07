import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';
part 'api_response.g.dart';

@Freezed(genericArgumentFactories: true)
sealed class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse({
    T? data,
    required String requestId,
    required String path,
    required bool success,
    required String message,
    required int code,
  }) = _ApiResponse;

  // const factory ApiResponse.data({
  //   T? data,
  //   required String requestId,
  //   required String path,
  //   required bool success,
  //   required String message,
  //   required int code,
  // }) = ApiResponseData;
  // const factory ApiResponse.error(String message) = ApiResponseError;

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$ApiResponseFromJson(json, fromJsonT);
}
