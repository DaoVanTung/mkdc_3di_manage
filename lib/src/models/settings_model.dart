class SettingsModel {
  SettingsModel._();
  static final _model = SettingsModel._();
  factory SettingsModel() => _model;

  String? _license;
  String? get license => _license;
  set license(value) => _license = value;
}
