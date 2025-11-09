import 'package:freezed_annotation/freezed_annotation.dart';

part 'paging.freezed.dart';
part 'paging.g.dart';

@Freezed(genericArgumentFactories: true)
abstract class Paging<T> with _$Paging<T> {
  const factory Paging({
    @JsonKey(name: "list") required List<T> data,
    required int page,
    required int limit,
    required int total,
  }) = _Paging;
  factory Paging.fromJson(
    Map<String, Object?> json,
    T Function(Object?) fromJsonT,
  ) => _$PagingFromJson(json, fromJsonT);
}
