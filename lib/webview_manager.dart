import 'package:breakmarket/apple_login.dart';
import 'package:breakmarket/constants.dart';
import 'package:breakmarket/google_login.dart';
import 'package:breakmarket/kakao_login.dart';
import 'package:breakmarket/naver_login.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class WebViewManager {
  late final WebViewController controller;
  late final PlatformWebViewControllerCreationParams params;

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

  init() {
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    controller = WebViewController.fromPlatformCreationParams(params);

    addKakaoChannel();
    addAppleChannel();
    addGoogleChannel();
    addNaverChannel();

    controller.setJavaScriptMode(JavaScriptMode.unrestricted);

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
    }

    if (controller.platform is WebKitWebViewController) {
      (controller.platform as WebKitWebViewController)
          .setAllowsBackForwardNavigationGestures(true);
    }

    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    // controller.loadRequest(Uri.parse('https://$url'));
    // controller.loadRequest(Uri.parse('http://$url'));
    controller.loadRequest(Uri.parse('http://$url'));
  }
}
