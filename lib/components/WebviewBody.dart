import 'package:breakmarket/providers/webview_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewBody extends HookConsumerWidget {
  final String url;

  const WebviewBody(
    this.url, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final webviewManager = ref.watch(globalWebviewManager);

    webviewManager.changeUrl(url);
    webviewManager.load();

    return WillPopScope(
        onWillPop: () async {
          if (await webviewManager.controller.canGoBack()) {
            webviewManager.controller.goBack();
            return false;
          }
          return true;
        },
        child: WebViewWidget(controller: webviewManager.controller));
  }
}
