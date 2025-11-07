import 'package:shared_preferences/shared_preferences.dart';

class Oauth {
  static Future<void> setIdentity(String newValue) async {
    (await SharedPreferences.getInstance()).setString('identity', newValue);
  }

  static Future<void> setAppId(String newValue) async {
    (await SharedPreferences.getInstance()).setString('appId', newValue);
  }

  static Future<SharedPreferences> get pref async =>
      await SharedPreferences.getInstance();

  static Future<String?> get identity async =>
      (await Oauth.pref).getString("identity");

  static Future<String?> get appId async =>
      (await Oauth.pref).getString("appId");

  static Future<Map<String, dynamic>> get commonParams async {
    return {"app_id": await Oauth.appId, "identity": await Oauth.identity};
  }

  static Future<bool> get oauthed async {
    return ((await Oauth.appId)?.trim().isNotEmpty ?? false) &&
        ((await Oauth.identity)?.trim().isNotEmpty ?? false);
  }
}
