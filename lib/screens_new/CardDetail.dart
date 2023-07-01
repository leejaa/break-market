import 'package:breakmarket/components/SharedAppBar.dart';
import 'package:breakmarket/utils/webview_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CardDetailScreen extends StatefulWidget {
  final String? id;
  const CardDetailScreen({super.key, required this.id});

  @override
  State<CardDetailScreen> createState() => _CardDetailScreen();
}

class _CardDetailScreen extends State<CardDetailScreen> {
  WebViewManager webViewManager = WebViewManager();

  @override
  void initState() {
    super.initState();
    webViewManager.init();
    webViewManager.changeUrl('/card/${widget.id}');
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
