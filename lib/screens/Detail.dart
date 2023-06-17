import 'package:breakmarket/webview_manager.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.url});
  final String? url;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  WebViewManager webviewManager = WebViewManager();

  @override
  void initState() {
    super.initState();
    webviewManager.init(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await webviewManager.controller.canGoBack()) {
          webviewManager.controller.goBack();
          return false;
        }
        return true;
      },
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
                title: const Text("카드 상세정보"), backgroundColor: Colors.black),
            body: WebViewWidget(controller: webviewManager.controller)),
      ),
    );
  }
}
