import 'package:breakmarket/apple_login.dart';
import 'package:breakmarket/google_login.dart';
import 'package:breakmarket/kakao_login.dart';
import 'package:breakmarket/naver_login.dart';
import 'package:breakmarket/screens/Detail.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:http/http.dart' as http;

class WebViewManager {
  late final WebViewController controller;
  late final PlatformWebViewControllerCreationParams params;
  late String? url;
  late BuildContext context;

  setContext(BuildContext contextParam) {
    context = contextParam;
  }

  addNavigateChanngel() {
    controller.addJavaScriptChannel('navigate',
        onMessageReceived: (JavaScriptMessage message) async {
      String newMessage = double.parse(message.message).toStringAsFixed(0);

      String nextUrl = '$url/card/${newMessage}';
      // String nextUrl = 'https://zigzag.kr/catalog/products/112511532';
      context.push('/detail?url=$nextUrl');

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => DetailScreen(url: nextUrl)),
      // );
    });
  }

  addNotificationChannel() {
    controller.addJavaScriptChannel('notification',
        onMessageReceived: (JavaScriptMessage message) async {
      var client = http.Client();
      // var response =
      //     await client.post(Uri.http(url ?? '', '/api/notification'));
      var response =
          await client.post(Uri.https(url ?? '', '/api/notification'));
    });
  }

  addNaverChannel() {
    controller.addJavaScriptChannel('naverlogin',
        onMessageReceived: (JavaScriptMessage message) async {
      var naverLogin = NaverLogin();
      await naverLogin.login();
      var accessToken = naverLogin.getAccessToken();
      var refreshToken = naverLogin.getRefreshToken();

      await controller.runJavaScriptReturningResult(
        "setCookie('{\"accessToken\": \"${accessToken}\", \"refreshToken\": \"${refreshToken}\", \"loginType\": \"kakao\"}')",
      );
    });
  }

  addGoogleChannel() {
    controller.addJavaScriptChannel('googlelogin',
        onMessageReceived: (JavaScriptMessage message) async {
      var googleLogin = GoogleLogin();
      await googleLogin.login();

      var accessToken = googleLogin.getAccessToken();
      var refreshToken = googleLogin.getRefreshToken();

      await controller.runJavaScriptReturningResult(
        "setCookie('{\"accessToken\": \"${accessToken}\", \"refreshToken\": \"${refreshToken}\", \"loginType\": \"kakao\"}')",
      );
    });
  }

  addKakaoChannel() {
    controller.addJavaScriptChannel('kakaologin',
        onMessageReceived: (JavaScriptMessage message) async {
      var kakaoLogin = KakaoLogin();
      await kakaoLogin.login();

      OAuthToken token = await kakaoLogin.getAuthToken();

      await controller.runJavaScriptReturningResult(
        "setCookie('{\"accessToken\": \"${token.accessToken}\", \"refreshToken\": \"${token.refreshToken}\", \"loginType\": \"kakao\"}')",
      );
    });
  }

  addAppleChannel() {
    controller.addJavaScriptChannel('applelogin',
        onMessageReceived: (JavaScriptMessage message) async {
      var appleLogin = AppleLogin();
      await appleLogin.login();

      var accessToken = await appleLogin.getAccessToken();
      var refreshToken = await appleLogin.getRefreshToken();

      await controller.runJavaScriptReturningResult(
        "setCookie('{\"accessToken\": \"${accessToken}\", \"refreshToken\": \"${refreshToken}\", \"loginType\": \"apple\"}')",
      );
    });
  }

  init(String? urlParam) {
    url = urlParam;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    controller = WebViewController.fromPlatformCreationParams(params);

    controller.setJavaScriptMode(JavaScriptMode.unrestricted);

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
    }

    if (controller.platform is WebKitWebViewController) {
      (controller.platform as WebKitWebViewController)
          .setAllowsBackForwardNavigationGestures(true);
    }

    controller.loadRequest(Uri.parse('https://$url'));
    // controller.loadRequest(Uri.parse('http://$url'));

    addKakaoChannel();
    addAppleChannel();
    addGoogleChannel();
    addNaverChannel();
    addNotificationChannel();
    addNavigateChanngel();
  }
}
