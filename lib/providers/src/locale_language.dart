import 'package:flutter_butailing/i18n/strings.g.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'locale_language.g.dart';

@riverpod
class LocaleLanguage extends _$LocaleLanguage {
  Future<SharedPreferences> get pref async =>
      await SharedPreferences.getInstance();

  @override
  Future<AppLocale> build() async {
    final languageCode =
        (await pref).getString('languageCode') ??
        LocaleSettings.instance.currentLocale.languageCode;
    final index = LocaleSettings.instance.supportedLocales
        .map((e) => e.languageCode)
        .toList()
        .indexOf(languageCode);
    final locale = LocaleSettings.instance.supportedLocales[index];
    final appLocale = AppLocaleUtils.parseLocaleParts(
      languageCode: locale.languageCode,
      countryCode: locale.countryCode,
      scriptCode: locale.scriptCode,
    );
    final current = await LocaleSettings.instance.setLocale(appLocale);
    state = AsyncData(current);
    return LocaleSettings.instance.currentLocale;
  }

  AppLocale get currentLocale =>
      state.value ?? LocaleSettings.instance.currentLocale;

  Future<AppLocale> changeLanguageCode({required String languageCode}) async {
    final index = LocaleSettings.instance.supportedLocales
        .map((e) => e.languageCode)
        .toList()
        .indexOf(languageCode);
    final locale = LocaleSettings.instance.supportedLocales[index];
    (await pref).setString('languageCode', locale.languageCode);
    final appLocale = AppLocaleUtils.parseLocaleParts(
      languageCode: locale.languageCode,
      countryCode: locale.countryCode,
      scriptCode: locale.scriptCode,
    );
    final current = await LocaleSettings.instance.setLocale(appLocale);
    state = AsyncData(current);
    return current;
  }
}
