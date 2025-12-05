import 'package:freezed_annotation/freezed_annotation.dart';

class SafeMapConverter implements JsonConverter<Map<String, dynamic>, dynamic> {
  const SafeMapConverter();

  @override
  Map<String, dynamic> fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return json;
    } else if (json is Map) {
      // 处理 Map<dynamic, dynamic> 的情况
      return json.cast<String, dynamic>();
    }
    return {};
  }

  @override
  dynamic toJson(Map<String, dynamic> object) => object;
}
