import 'package:flutter_butailing/model/response/src/ecca.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'ecca_data.freezed.dart';
part 'ecca_data.g.dart';

@freezed
abstract class EccaData with _$EccaData {
  const factory EccaData({
    @JsonKey(name: "WEB-4K") @Default([]) List<Ecca>? web4K,
    @JsonKey(name: "WEB-1080P") @Default([]) List<Ecca>? web1080p,
    @JsonKey(name: "杜比视界") @Default([]) List<Ecca>? dubi,
    @JsonKey(name: "all_seeds") @Default([]) List<Ecca>? allSeeds,
  }) = _EccaData;
  factory EccaData.fromJson(Map<String, Object?> json) =>
      _$EccaDataFromJson(json);
}
