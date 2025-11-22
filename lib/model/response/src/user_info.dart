import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_info.g.dart';
part 'user_info.freezed.dart';

@freezed
abstract class User with _$User {
  const factory User({
    required int id,
    required String nickname,
    String? phone,
    String? email,
    String? avatar,
    String? signed,
    String? username,
    @JsonKey(name: 'vip_expire_at') String? vipExpireAt,
    @JsonKey(name: 'is_vip') @Default(1) int? isVip,
    @JsonKey(name: 'is_wp') @Default(1) int? isWp,
    @JsonKey(name: 'vip_type') int? vipType,
    @JsonKey(name: 'is_super') @Default(false) bool? isSuper,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
abstract class UserInfo with _$UserInfo {
  const factory UserInfo({required User user}) = _UserInfo;

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
}

@freezed
abstract class Login with _$Login {
  const factory Login({
    @JsonKey(name: 'access_token') required String accessToken,
  }) = _Login;

  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);
}
