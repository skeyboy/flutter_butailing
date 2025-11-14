import 'package:flutter_butailing/utili/converter/string_to_int_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'paging.freezed.dart';
part 'paging.g.dart';

@Freezed(genericArgumentFactories: true)
abstract class Paging<T> with _$Paging<T> {
  const factory Paging({
    @JsonKey(name: "list") required List<T> data,
    @StringToIntConverter() required int page,
    @StringToIntConverter() required int limit,
    required int total,
    // String? sql,
  }) = _Paging;
  factory Paging.fromJson(
    Map<String, Object?> json,
    T Function(Object?) fromJsonT,
  ) => _$PagingFromJson(json, fromJsonT);
}
