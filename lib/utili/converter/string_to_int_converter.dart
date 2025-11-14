import 'package:freezed_annotation/freezed_annotation.dart';

class StringToIntConverter implements JsonConverter<int, dynamic> {
  const StringToIntConverter();

  @override
  int fromJson(dynamic json) {
    if (json is int) return json;
    if (json is String) return int.tryParse(json) ?? 0;
    return 0; // 或者抛出异常
  }

  @override
  dynamic toJson(int object) => object;
}

class NullableIntConverter implements JsonConverter<int?, dynamic> {
  const NullableIntConverter();

  @override
  int? fromJson(dynamic json) {
    if (json == null) return null;
    if (json is int) return json;
    if (json is String) {
      if (json.isEmpty) return null;
      return int.tryParse(json);
    }
    return null;
  }

  @override
  dynamic toJson(int? object) => object;
}
