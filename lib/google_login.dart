import 'dart:convert';

import 'package:breakmarket/constants.dart';
import 'package:breakmarket/notification_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:http/http.dart' as http;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class GoogleLogin {
  late String? accessToken;
  late String? refreshToken;

  getAccessToken() {
    return accessToken;
  }

  getRefreshToken() {
    return refreshToken;
  }

  login() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
        // clientId:
        //     '845312398147-el5et7id81f808v4q09qt22t01uvvcpp.apps.googleusercontent.com',
        scopes: [
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
        ]);

    GoogleSignInAccount? signInAccount = await googleSignIn.signIn();

    GoogleSignInAuthentication credential = await signInAccount!.authentication;

    var notificationManager = NotificationManager();

    var appToken = await notificationManager.getToken();

    var client = http.Client();
    await client.post(Uri.http(url, '/api/google_login'), body: {
      'email': signInAccount.email,
      'appToken': appToken,
    });

    accessToken = credential.accessToken;
    refreshToken = credential.idToken;
  }
}
