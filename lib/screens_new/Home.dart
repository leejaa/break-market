import 'package:breakmarket/components/SharedAppBar.dart';
import 'package:breakmarket/utils/webview_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatefulWidget {
  final BuildContext? context;
  const HomeScreen({super.key, required this.context});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  WebViewManager webViewManager = WebViewManager();

  @override
  void initState() {
    super.initState();

    webViewManager.init();
    webViewManager.setContext(widget.context);
    webViewManager.load();
    webViewManager.addNavigationChannel();
  }

  @override
  Widget build(BuildContext context) {
    void handleItemTapped(int index) {
      if (index == 1) {
        context.push('/profile');
      }
    }

    return SafeArea(
        child: Scaffold(
      appBar: sharedAppBar(),
      body: WebViewWidget(controller: webViewManager.controller),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Profile',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.black,
        onTap: handleItemTapped,
      ),
    ));
  }
}
