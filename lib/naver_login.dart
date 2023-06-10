import 'package:flutter_naver_login/flutter_naver_login.dart';

class NaverLogin {
  late String accessToken;
  late String refreshToken;

  getAccessToken() {
    return accessToken;
  }

  getRefreshToken() {
    return refreshToken;
  }

  login() async {
    await FlutterNaverLogin.logIn();
    NaverAccessToken res = await FlutterNaverLogin.currentAccessToken;

    accessToken = res.accessToken;
    refreshToken = res.refreshToken;
  }
}
