import 'package:freezed_annotation/freezed_annotation.dart';
part 'ecca.freezed.dart';
part 'ecca.g.dart';

@freezed
abstract class Ecca with _$Ecca {
  const factory Ecca({
    required String zname,
    @JsonKey(name: 'new') required int isnew,
    required int id,
    required String zsize,
    required String zqxd,
    required String zlink,
    required String down,
    required String ezt,
    @JsonKey(name: 'definition_group') required String definitionGroup,
  }) = _Ecca;
  factory Ecca.fromJson(Map<String, Object?> json) => _$EccaFromJson(json);
}
