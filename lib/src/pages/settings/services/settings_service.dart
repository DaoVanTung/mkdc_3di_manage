import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/settings_model.dart';

/// A service that stores and retrieves user settings.
///
/// By default, this class does not persist user settings. If you'd like to
/// persist the user settings locally, use the shared_preferences package. If
/// you'd like to store settings on a web server, use the http package.
class SettingsService {
  /// Loads the User's preferred ThemeMode from local or remote storage.
  Future<ThemeMode> themeMode() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final index = preferences.getInt('theme_mode') ?? 0;
    return ThemeMode.values.elementAt(index);
  }

  /// Persists the user's preferred ThemeMode to local or remote storage.
  Future<void> updateThemeMode(ThemeMode themeMode) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('theme_mode', themeMode.index);
  }

  Future<ColorSeed> colorSeed() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final index = preferences.getInt('color_seed') ?? 0;
    return ColorSeed.values.elementAt(index);
  }

  Future<void> updateColorSeed(int index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('color_seed', index);
  }

  Future<Locale> locale() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final languageCode = preferences.getString('language_code') ?? 'vi';
    return Locale(languageCode);
  }

  Future<void> updateLocale(Locale locale) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('language_code', locale.languageCode);
  }
}
