import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'routes_all.freezed.dart';
part 'routes_all.g.dart';

@Freezed(genericArgumentFactories: true)
abstract class RoutesAll with _$RoutesAll {
  const factory RoutesAll({
    required int id,
    @JsonKey(name: "parent_id") required int parentId,
    required String name,
    required String component,
    required String path,
    String? redirect,
    @JsonKey(name: "meta") Meta? meta,
  }) = _RoutesAll;
  factory RoutesAll.fromJson(Map<String, Object?> json) =>
      _$RoutesAllFromJson(json);
}

@freezed
abstract class Meta with _$Meta {
  const factory Meta({
    required String type,
    String? icon,
    required String title,
    @Default(false) bool? hidden,
    @Default(false) bool? hiddenBreadcrumb,
  }) = _Meta;
  factory Meta.fromJson(Map<String, Object?> json) => _$MetaFromJson(json);
}
