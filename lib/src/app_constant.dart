class AppConstant {
  AppConstant._internal();
  static final _instance = AppConstant._internal();
  factory AppConstant() {
    return _instance;
  }

  static const ssoHost = 'https://sso.mkdc.vn';
  static const clientHost = 'http://localhost:5000/';
  static const callbackUrl = 'http://localhost:5000/callback.html';
  static const clientId = '0jHMauaBk83FZ_DTGoW6XABKdq0a';
  static const secretKey = 'AEDNmfBcNwBaIRLUGofKtv0ZHtoa';
}
