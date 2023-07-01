import 'package:breakmarket/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class WebViewManager {
  late final WebViewController controller;
  late final PlatformWebViewControllerCreationParams params;
  late final BuildContext? context;
  late String currentUrl = '/';

  getController() {
    return controller;
  }

  setContext(BuildContext? contextParam) {
    context = contextParam;
  }

  changeUrl(String newUrl) {
    currentUrl = newUrl;
  }

  addNavigationChannel() {
    controller.addJavaScriptChannel('navigation',
        onMessageReceived: (JavaScriptMessage message) async {
      context?.push(message.message);
    });
  }

  load() {
    String url = '$webviewUrl$currentUrl';
    controller.loadRequest(Uri.parse(url));
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

    controller.setJavaScriptMode(JavaScriptMode.unrestricted);

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
    }

    if (controller.platform is WebKitWebViewController) {
      (controller.platform as WebKitWebViewController)
          .setAllowsBackForwardNavigationGestures(true);
    }
  }
}
