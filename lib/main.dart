import 'package:breakmarket/notification_manager.dart';
import 'package:breakmarket/webview_manager.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
    nativeAppKey: '371c839e44bb2539089fea478be5e3ee',
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const MaterialApp(
      home: MainApp(),
      // home: MyHomePage(),
    ),
  );

  var notificationManager = NotificationManager();
  await notificationManager.init();
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  WebViewManager webviewManager = WebViewManager();

  @override
  void initState() {
    super.initState();
    webviewManager.init();
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
            body: WebViewWidget(controller: webviewManager.controller)),
      ),
    );
  }
}
