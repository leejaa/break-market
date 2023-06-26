import 'package:breakmarket/components/SharedAppBar.dart';
import 'package:breakmarket/utils/webview_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  WebViewManager webViewManager = WebViewManager();

  @override
  void initState() {
    super.initState();
    webViewManager.init();
    webViewManager.changeUrl('/login');
    webViewManager.load();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: sharedAppBar(),
      body: WebViewWidget(controller: webViewManager.controller),
    ));
  }
}
