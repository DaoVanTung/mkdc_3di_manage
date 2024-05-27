import 'package:flutter/material.dart';

import '../services/settings_service.dart';

class SettingsController with ChangeNotifier {
  SettingsController._();
  static final _controller = SettingsController._();
  factory SettingsController() => _controller;

  final _settingsService = SettingsService();
  bool isActive = false;

  Future<void> loadSettings() async {
    final license = await _settingsService.getLicense();
    if (license.isNotEmpty) {
      isActive = true;
    }

    // _settingsService.removeLicense();

    notifyListeners();
  }

  bool updateLicense(String license) {
    if (validateLicense(license)) {
      _settingsService.updateLicense(license);
      isActive = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  bool validateLicense(String license) {
    return license == 'JT29-DLHN-24MK';
  }
}
