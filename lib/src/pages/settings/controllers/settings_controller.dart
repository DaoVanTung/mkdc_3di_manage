import 'package:flutter/material.dart';

import '../../../models/settings_model.dart';
import '../services/settings_service.dart';

/// A class that many Widgets can interact with to read user settings, update
/// user settings, or listen to user settings changes.
///
/// Controllers glue Data Services to Flutter Widgets. The SettingsController
/// uses the SettingsService to store and retrieve user settings.
class SettingsController with ChangeNotifier {
  SettingsController._();
  static final _controller = SettingsController._();
  factory SettingsController() => _controller;

  // Make SettingsService a private variable so it is not used directly.
  final _settingsService = SettingsService();

  set navigationKey(value) {
    SettingsModel().navigatorKey = value;
  }

  /// Load the user's settings from the SettingsService. It may load from a
  /// local database or the internet. The controller only knows it can load the
  /// settings from the service.
  Future<void> loadSettings() async {
    final themeMode = await _settingsService.themeMode();
    final colorSeed = await _settingsService.colorSeed();
    final locale = await _settingsService.locale();
    SettingsModel().themeMode = themeMode;
    SettingsModel().colorSeed = colorSeed;
    SettingsModel().locale = locale;

    // Important! Inform listeners a change has occurred.
    notifyListeners();
  }

  /// Update and persist the ThemeMode based on the user's selection.
  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) {
      return;
    }

    if (newThemeMode == SettingsModel().themeMode) {
      return;
    }

    // Persist the changes to a local database or the internet using the
    // SettingService.
    await _settingsService.updateThemeMode(newThemeMode);
    SettingsModel().themeMode = newThemeMode;
    notifyListeners();
  }

  Future<void> updateColorSeed(int index) async {
    await _settingsService.updateColorSeed(index);
    SettingsModel().colorSeed = ColorSeed.values.elementAt(index);
    notifyListeners();
  }

  Future<void> updateLocale(Locale? newLocale) async {
    if (newLocale == null) return;

    // Do not perform any work if new and old ThemeMode are identical
    if (newLocale == SettingsModel().locale) return;

    // Otherwise, store the new ThemeMode in memory
    SettingsModel().locale = newLocale;

    // Important! Inform listeners a change has occurred.
    notifyListeners();

    // Persist the changes to a local database or the internet using the
    // SettingService.
    await _settingsService.updateLocale(newLocale);
  }
}
