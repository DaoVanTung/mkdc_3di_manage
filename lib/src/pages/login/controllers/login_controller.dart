import 'package:flutter/material.dart';

import '../../../services/auth_service.dart';

class LoginController extends ChangeNotifier {
  LoginController._();
  static final _instance = LoginController._();
  factory LoginController() {
    return _instance;
  }

  final _service = AuthService();

  ValueNotifier<bool> isBusy = ValueNotifier(false);

  Future<bool> login() async {
    isBusy.value = true;
    final isLogged = await _service.login();
    isBusy.value = false;

    return isLogged;
  }
}
