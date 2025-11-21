import 'package:freezed_annotation/freezed_annotation.dart';
part 'captcha.freezed.dart';
part 'captcha.g.dart';

@freezed
abstract class Captcha with _$Captcha {
  const factory Captcha({required String key, required String img}) = _Captcha;

  factory Captcha.fromJson(Map<String, dynamic> json) =>
      _$CaptchaFromJson(json);
}
