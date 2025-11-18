import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'theme_config.g.dart';

@riverpod
class ThemeConfig extends _$ThemeConfig {
  Future<SharedPreferences> get prefs async =>
      await SharedPreferences.getInstance();
  ThemeMode get currentThemeMode => state.value ?? ThemeMode.system;
  Future<ThemeMode> get themeMode async {
    final themeMode = (await prefs).getString('ThemeMode') ?? 'system';
    switch (themeMode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      default:
        return ThemeMode.system;
    }
  }

  @override
  Future<ThemeMode> build() async {
    final current = await themeMode;
    state = AsyncData(current);
    return current;
  }

  void switchTheme(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        prefs.then((value) => value.setString('ThemeMode', 'light'));
        break;
      case ThemeMode.dark:
        prefs.then((value) => value.setString('ThemeMode', 'dark'));
        break;
      case ThemeMode.system:
        prefs.then((value) => value.setString('ThemeMode', 'system'));
        break;
    }
    state = AsyncData(themeMode);
  }
}
