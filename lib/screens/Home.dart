import 'package:breakmarket/constants.dart';
import 'package:breakmarket/webview_manager.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WebViewManager webviewManager = WebViewManager();

  @override
  void initState() {
    super.initState();

    webviewManager.init(url);
  }

  @override
  Widget build(BuildContext context) {
    webviewManager.setContext(context);
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
                title: const Text("카드 리스트"), backgroundColor: Colors.black),
            body: WebViewWidget(controller: webviewManager.controller)),
      ),
    );
  }
}
