class AppConstant {
  AppConstant._internal();
  static final _instance = AppConstant._internal();
  factory AppConstant() {
    return _instance;
  }

  static const ssoHost = 'https://sso.mkdc.com.vn';
  // static const clientHost = 'https://simcenter.mkdc.com.vn';
  // static const callbackUrl = 'https://simcenter.mkdc.com.vn/callback.html';
  static const clientHost = 'http://localhost:5000';
  static const callbackUrl = 'http://localhost:5000/callback.html';
  static const clientId = 'fTfy_R_ngljzkpVDBABz5cGXZJwa';
  static const secretKey = 'Z_MCvx2I3Bpr14TfN5mIf1uIKN8a';
}
