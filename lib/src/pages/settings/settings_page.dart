import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../app_style.dart';
import 'controllers/settings_controller.dart';
import '../../models/settings_model.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final al = AppLocalizations.of(context)!;
    final controller = SettingsController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          al.settings,
          style: const TextStyle(
            fontSize: AppStyle.fontSize18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Chọn ngôn ngữ
            InputDecorator(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                labelText: al.language,
                border: const OutlineInputBorder(),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<Locale>(
                  value: SettingsModel().locale,
                  onChanged: controller.updateLocale,
                  hint: Text(al.language),
                  items: [
                    DropdownMenuItem(
                      value: const Locale.fromSubtags(languageCode: 'vi'),
                      child: Text(al.vi),
                    ),
                    DropdownMenuItem(
                      value: const Locale.fromSubtags(languageCode: 'en'),
                      child: Text(al.en),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppStyle.padding16),
            // Chọn theme
            InputDecorator(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                labelText: al.theme,
                border: const OutlineInputBorder(),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<ThemeMode>(
                  value: SettingsModel().themeMode,
                  onChanged: (themeMode) {
                    controller.updateThemeMode(themeMode);
                    setState(() {});
                  },
                  hint: Text(al.theme),
                  items: [
                    DropdownMenuItem(
                      value: ThemeMode.system,
                      child: Text(al.system),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.light,
                      child: Text(al.light),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.dark,
                      child: Text(al.dark),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
