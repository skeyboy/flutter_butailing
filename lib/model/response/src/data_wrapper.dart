import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_wrapper.freezed.dart';
part 'data_wrapper.g.dart';

@Freezed(genericArgumentFactories: true)
sealed class DataWrapper<T> with _$DataWrapper<T> {
  const factory DataWrapper({
    T? data,
    @JsonKey(name: "hosts_data") List<dynamic>? hostsData,
    @JsonKey(name: "log") List<dynamic>? log,
  }) = _DataWrapper;

  factory DataWrapper.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$DataWrapperFromJson(json, fromJsonT);
}
