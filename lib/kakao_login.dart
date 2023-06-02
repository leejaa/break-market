import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class KakaoLogin {
  getToken() async {
    try {
      OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
      print('카카오톡으로 로그인 성공');
      return token;
    } catch (error) {
      print('카카오톡으로 로그인 실패 $error');

      try {
        OAuthToken token2 = await UserApi.instance.loginWithKakaoAccount();
        print('카카오톡으로 로그인 성공2');
        return token2;
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
        return false;
      }
    }
  }

  saveData() async {}

  login() async {
    OAuthToken result = await getToken();
    print("result: ${result}");
  }
}
