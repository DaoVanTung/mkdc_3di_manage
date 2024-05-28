// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../app_constant.dart';

class AuthService {
  final storage = const FlutterSecureStorage();

  Future<bool> login() async {
    const loginUrl =
        '${AppConstant.ssoHost}./oauth2/authorize?client_id=${AppConstant.clientId}&redirect_uri=${AppConstant.callbackUrl}&response_type=code&scope=openid';
    final loginTab = html.window.open(
      loginUrl,
      'MKDC Sign in',
    );

    final messageEvt = await html.window.onMessage.firstWhere((evt) => true);
    final code = messageEvt.data;

    loginTab.close();

    final Map<String, String> body = {
      'grant_type': 'authorization_code',
      'code': code,
      'redirect_uri': AppConstant.callbackUrl,
      'client_id': AppConstant.clientId,
      'client_secret': AppConstant.secretKey,
      'scope': 'openid profile email',
    };

    final urlToken = Uri.parse('${AppConstant.ssoHost}/oauth2/token');
    final response = await http.post(urlToken, body: body);
    final responseBody = jsonDecode(response.body) as Map<String, dynamic>;

    // print(responseBody['access_token']);
    // print(responseBody['id_token']);

    await storage.write(
      key: 'access_token',
      value: responseBody['access_token'],
    );

    await storage.write(
      key: 'id_token',
      value: responseBody['id_token'],
    );

    return responseBody['access_token'] != null;
  }

  Future<void> logout() async {
    final idToken = await storage.read(key: 'id_token');

    final url =
        '${AppConstant.ssoHost}/oidc/logout?id_token_hint=$idToken&post_logout_redirect_uri=${AppConstant.clientHost}&state=0';

    await storage.delete(key: 'access_token');
    await storage.delete(key: 'id_token');
    html.window.location.replace(url);
  }

  Future<void> validateToken() async {
    // final accessToken = await storage.read(key: 'access_token');
    // const url = '${AppConstant.ssoHost}/oauth2/introspect';
  }
}
