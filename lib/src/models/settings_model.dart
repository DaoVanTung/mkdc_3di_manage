import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

extension ExtColors on Colors {
  static const customMaterialColor = MaterialColor(
    _customMaterialColorValue,
    <int, Color>{
      50: Color(0xffe8f5f1),
      100: Color(0xffd1ebe2),
      200: Color(0xffb9e2d4),
      300: Color(0xff74c4a9),
      400: Color(0xff45b18d),
      500: Color(_customMaterialColorValue),
      600: Color(0xff127e5a),
      700: Color(0xff0e5e43),
      800: Color(0xff093f2d),
      900: Color(0xff051f16),
    },
  );

  static const int _customMaterialColorValue = 0xff179d70;
}

enum ColorSeed {
  baseColor('M3 Baseline', ExtColors.customMaterialColor),
  indigo('Indigo', Colors.indigo),
  blue('Blue', Colors.blue),
  teal('Teal', Colors.teal),
  green('Green', Colors.green),
  yellow('Yellow', Colors.yellow),
  orange('Orange', Colors.orange),
  deepOrange('Deep Orange', Colors.deepOrange),
  pink('Pink', Colors.pink);

  const ColorSeed(this.label, this.primary);
  final String label;
  final MaterialColor primary;

  /// Lấy màu nền tiêu chuẩn
  Color get background {
    final isLight = SettingsModel().isLightMode;
    return isLight ? primary.shade50 : Colors.grey.shade900;
  }

  /// Lấy màu highligh tiêu chuẩn
  Color get highlightColor {
    final isLight = SettingsModel().isLightMode;
    return isLight ? Colors.yellow.shade400 : Colors.grey.shade600;
  }
}

class SettingsModel {
  SettingsModel._();
  static final _model = SettingsModel._();
  factory SettingsModel() => _model;

  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;
  set themeMode(value) => _themeMode = value;

  bool get isLightMode {
    switch (themeMode) {
      case ThemeMode.system:
        return SchedulerBinding
                .instance.platformDispatcher.platformBrightness ==
            Brightness.light;
      case ThemeMode.light:
        return true;
      case ThemeMode.dark:
        return false;
    }
  }

  ColorSeed _colorSeed = ColorSeed.baseColor;
  ColorSeed get colorSeed => _colorSeed;
  set colorSeed(value) => _colorSeed = value;

  Locale _locale = const Locale('vi', 'VN');
  Locale get locale => _locale;
  set locale(value) => _locale = value;

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  ThemeData get theme {
    switch (themeMode) {
      case ThemeMode.system:
        return ThemeData(
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          brightness: Brightness.light,
        );
      case ThemeMode.light:
        return ThemeData(
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          brightness: Brightness.light,
        );
      case ThemeMode.dark:
        return ThemeData(
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          brightness: Brightness.dark,
        );
    }
  }
}
