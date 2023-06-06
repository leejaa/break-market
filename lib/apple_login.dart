import 'dart:convert';

import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:http/http.dart' as http;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleLogin {
  late String code;
  late String accessToken;
  late String refreshToken;

  getAccessToken() {
    return accessToken;
  }

  getRefreshToken() {
    return refreshToken;
  }

  getCode() async {
    final AuthorizationCredentialAppleID credential =
        await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      webAuthenticationOptions: WebAuthenticationOptions(
        clientId: "breakmarket.breakncompany.com",
        redirectUri: Uri.parse(
          "https://break-webview.vercel.app/callback/sign_in_apple",
        ),
      ),
    );
    code = credential.authorizationCode;
  }

  login() async {
    await getCode();
    var client = http.Client();
    var response = await client
        // .post(Uri.http('172.30.1.22:3000', '/api/apple_login'), body: {
        // .post(Uri.http('192.168.0.93:3000', '/api/apple_login'), body: {
        .post(Uri.https('break-webview.vercel.app', '/api/apple_login'), body: {
      'code': code,
    });

    var data = jsonDecode(response.body);

    accessToken = data['accessToken'];
    refreshToken = data['refreshToken'];
  }
}
