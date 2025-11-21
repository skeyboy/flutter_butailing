import 'package:flutter_butailing/api/rest_client.dart';
import 'package:flutter_butailing/config/config.dart';
import 'package:flutter_butailing/model/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'login.g.dart';

@riverpod
class Login extends _$Login {
  Future<SharedPreferences> get pref async =>
      await SharedPreferences.getInstance();
  @override
  Future<bool> build() async {
    final login = (await pref).getBool('login') ?? false;
    state = AsyncData(login);
    return login;
  }

  Future<ApiResponse<Captcha>> refreshCaptcha() async {
    final captchaResult = await (await RestClient.client).getCaptcha();
    logger.d("login captcha : $captchaResult");
    return captchaResult;
  }
}
