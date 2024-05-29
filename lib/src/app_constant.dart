class AppConstant {
  AppConstant._internal();
  static final _instance = AppConstant._internal();
  factory AppConstant() {
    return _instance;
  }

  static const ssoHost = 'https://sso.mkdc.vn';
  static const clientHost = 'https://lsimcenter.mkdc.com.vn';
  static const callbackUrl = 'https://simcenter.mkdc.com.vn/callback.html';
  static const clientId = '_PkL507mp9D92g1PSoQzdMG98iga';
  static const secretKey = 'rNKoABIiKbLNNYtJe5adQnddPcga';
}
