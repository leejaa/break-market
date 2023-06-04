import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:http/http.dart' as http;

class KakaoLogin {
  late OAuthToken authToken;

  getAuthToken() {
    return authToken;
  }

  getToken() async {
    try {
      OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
      authToken = token;
      print('카카오톡으로 로그인 성공');
    } catch (error) {
      print('카카오톡으로 로그인 실패 $error');

      try {
        OAuthToken token2 = await UserApi.instance.loginWithKakaoAccount();
        print('카카오톡으로 로그인 성공2');
        authToken = token2;
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
        return false;
      }
    }
  }

  saveData() async {
    var client = http.Client();
    var response = await client
        // .post(Uri.http('192.168.0.93:3000', '/api/login'), body: {
        .post(Uri.https('break-webview.vercel.app', '/api/login'), body: {
      'accessToken': authToken.accessToken,
      'refreshToken': authToken.refreshToken
    });
  }

  login() async {
    await getToken();
    await saveData();
  }
}
