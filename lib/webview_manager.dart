import 'package:breakmarket/kakao_login.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class WebViewManager {
  late final WebViewController controller;
  late final PlatformWebViewControllerCreationParams params;

  addKakaoChannel() {
    controller.addJavaScriptChannel('kakaologin',
        onMessageReceived: (JavaScriptMessage message) async {
      var kakaoLogin = KakaoLogin();
      await kakaoLogin.login();

      OAuthToken token = await kakaoLogin.getAuthToken();

      await controller.runJavaScriptReturningResult(
        "setCookie('{accessToken: ${token.accessToken}, refreshToken: ${token.refreshToken}, loginType: kakao}')",
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

    controller.setJavaScriptMode(JavaScriptMode.unrestricted);

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
    }

    if (controller.platform is WebKitWebViewController) {
      (controller.platform as WebKitWebViewController)
          .setAllowsBackForwardNavigationGestures(true);
    }

    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    // controller.loadRequest(Uri.parse('https://break-webview.vercel.app/login'));
    controller.loadRequest(Uri.parse('http://192.168.0.93:3000/login'));
  }
}
