import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../models/api_key_model.dart';
import '../../../models/user_model.dart';
import '../../../services/three_di_service.dart';
import '../services/settings_service.dart';

class SettingsController with ChangeNotifier {
  SettingsController._();
  static final _controller = SettingsController._();
  factory SettingsController() => _controller;

  final _settingsService = SettingsService();
  final _threeDiService = ThreeDiService();

  bool isActive = false;
  ValueNotifier<int> numberOfUser = ValueNotifier(0);
  List<UserModel> users = [];
  List<ApiKeyModel> apiKeys = [];

  Future<void> loadSettings() async {
    // final license = await _settingsService.getLicense();

    // if (license.isNotEmpty) {
    //   isActive = true;
    //   getUsers();
    // }

    // notifyListeners();

    isActive = true;
    getUsers();
    notifyListeners();
  }

  bool updateLicense(String license) {
    if (validateLicense(license)) {
      _settingsService.updateLicense('license');
      isActive = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  final String fixedLicense =
      '{"keys":[{"p":"-48qfg9IV7GkTtod_46kAFcvJcUk_gXlNNyF9Hp32ouPFRNkV5JKqhpLi97PA6nvd4IDU5GWWfkVJ1s9ayGc1f7uL32p28Zbcti2AP_zzJ9du-cSJhdzyBl8phHZB71mpG-BAJswzEhpPKHYUtRtqiOwdiyewgoM15yrW7-vcFk","kty":"RSA","q":"yG-yM2DJdjx6bbWnzp_6Yuo0wuviiZxwxq6aQQfHQiQYiBtJnmXT4CXXh9TLD12eveqF0e1Es-eazcEYj3bq5-jkaJG86sCacHeOxvuxVuIOQo1sUg9pj0Yi2RcE3gFNMqu5kQYoiXhBt-md_v_6Xr37M7OuFk6XoSVm7sBmKLk","d":"ny-Cbh4TV7LKnL1fgvN_pBUkySnzqulwCD7yB4ap3Zxrq1BlLm8XtKkPKoDDfDmMG7am1YdUq75-wgfEP0r1yYsajCd4L8sfCHmVWgFARedK5xl-sQ7wVn3LpwTn1tzjjKrGJjIYJ1khLX62B0t0BCFElgXGY7oGngWeyd11DPLsC5w3bsHa235CpjW-Tz6tT1D1LzpF9DCoxE8ZJe5-0MECRmIKqJFuU_48HgfoEe_mU32Jb6r05yRKhl5oszvlZHOhdWWpUHi_8vca7RYIJlQ1ZXou8HrABGbxoX8FfOkffe7US2HDN45tnihT7gQHc8O-iSXYHgcbTGyq_cfSAQ","e":"AQAB","use":"sig","kid":"210x\\"f(mh*c;G*;jQU-[C+&OS9SJSm","qi":"0sU92Knpuxf5DwlmS1LfeKepmC6BJ-2eZdZR71YPbfiqkbIpLqCoq1kHE8QAxZYWBRATGxAvMCmA4TQNHx58Wb71pytnWrm0Vz2jdL6546F_djXgQUcrawwb5sC95X_hiZz-VokDn6z5oqy0tTyWISP873SWIgv9JQWTpliSJS8","dp":"AXpQ1JbAZQt9HJ15aaPr4LiiZUVoNznPo-TbwJjrlVQWjhgkEcOhPqiS4wp3Ct13s6sG2_nR-UtWTXnivXtgEX3C5nKFie37YYxWXWEjjIMvKMhtud2PZ5CGw-786Ge7b6HcDyXaPoj6XUnSHIJ09nfpNHiEoj0u4CFifFJ-9Fk","alg":"RS256","dq":"X19Gm8viELCWUL2vK1JUAd0PXfB_ypr1zpQmMetRlNc4FQtm7EfnmTBobemC9bzGW_fL1SfhGPmLX3wSA7HB9LeMd3VhPxKGah15gpUgvQazYleIw0MyJ0poKoQZfMmBwiqUEb2sbD0ciDZRR5TlvU8IyIEmxNaAr9zsLY6_DYE","n":"xPWbYfDF6iU07g83QO7OgchJw6097QpMkIY3egeVxQce2m_5ztbGNtSZDX5ivEiTVqlJe8HgT0c7lcfPx8cIVa-FAOYneScpbWytKJdiSC9oMaq7uu7g0t586SbaSARNr2oSQSbF2uNQLyurbinQDbaAZw2hoFhcSxGniEaE-ucrQyU-OxrcG3q2FmfVPkNua3zof8SMdbW9oFonxLWucvM36ojFL9EC_QlxVG2tiw31aU56HpARBQm-zKbwR74vWZRfRDahq6nWEcgdkY2n4F15VxFqyWGT11zx60beG7kygWlxAgBwDRPW31D6v5rAMMtXWbC4-BezCwgocswYUQ"}]}';

  bool validateLicense(String license) {
    final finalLicense =
        license.replaceAll(RegExp(r'\s+'), ' ').trim().replaceAll(' ', '');
    return finalLicense == fixedLicense;
  }

  Future<void> getUsers() async {
    users.clear();
    final usersData = jsonDecode(await _threeDiService.getUsers());
    numberOfUser.value = usersData['count'] ?? 0;

    for (final data in usersData['results']) {
      users.add(
        UserModel(
          id: data['id'],
          username: data['username'].toString(),
          firstName: data['first_name'].toString(),
          lastName: data['last_name'].toString(),
          email: data['email'].toString(),
        ),
      );
    }

    notifyListeners();
  }

  Future<void> getApiKeys() async {
    apiKeys.clear();
    final apiKeysData = jsonDecode(await _threeDiService.getApiKeys());

    for (final data in apiKeysData['results']) {
      apiKeys.add(
        ApiKeyModel(
          prefix: data['prefix'],
          scope: data['scope'],
          name: data['name'],
          created: data['created'],
          revoked: data['revoked'],
          lastUsed: data['last_used'],
          expiryDate: data['expiry_date'],
        ),
      );
    }

    notifyListeners();
  }
}
