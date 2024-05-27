import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/pages/settings/controllers/settings_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SettingsController().loadSettings();
  runApp(const MyApp());
}
