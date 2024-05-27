import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  Future<String> getLicense() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final license = preferences.getString('license') ?? '';
    return license;
  }

  Future<void> updateLicense(String license) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('license', license);
  }

  Future<void> removeLicense() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('license');
  }
}
