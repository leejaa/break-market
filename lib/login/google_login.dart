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
        //     '480951865146-q2ts929sc92ncktkk1koh3j816sdsokv.apps.googleusercontent.com',
        // scopes: [
        //   'email',
        //   'https://www.googleapis.com/auth/contacts.readonly',
        // ]
        );

    final GoogleSignInAccount? signInAccount = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication credential =
        await signInAccount!.authentication;

    var notificationManager = NotificationManager();

    var appToken = await notificationManager.getToken();

    var client = http.Client();
    // Uri httpUrl = isProduction
    //     ? Uri.https(url, '/api/google_login')
    //     : Uri.http(url, '/api/google_login');
    // await client.post(httpUrl, body: {
    //   'email': signInAccount.email,
    //   'appToken': appToken,
    // });

    // accessToken = credential.accessToken;
    // refreshToken = credential.idToken;
  }
}
