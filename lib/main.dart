import 'package:breakmarket/notification_manager.dart';
import 'package:breakmarket/screens/Detail.dart';
import 'package:breakmarket/screens_new/CardDetail.dart';
import 'package:breakmarket/screens_new/Home.dart';
import 'package:breakmarket/screens_new/Profile.dart';
import 'package:breakmarket/styles/palette.dart';
import 'package:breakmarket/utils/webview_manager.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var notificationManager = NotificationManager();

  await notificationManager.init();

  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
    nativeAppKey: '371c839e44bb2539089fea478be5e3ee',
  );

  // runApp(MainApp());

  runApp(ProviderScope(child: MainApp()));
}

class MainApp extends HookConsumerWidget {
  MainApp({
    Key? key,
  }) : super(key: key);

  final _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => HomeScreen(
          context: context,
        ),
      ),
      GoRoute(
        path: '/card/:id',
        builder: (context, state) =>
            CardDetailScreen(id: state.pathParameters['id']),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: ThemeData(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            },
          ),
          primarySwatch: Palette.black),
    );
  }
}
