import 'package:breakmarket/notification_manager.dart';
import 'package:breakmarket/providers/webview_provider.dart';
import 'package:breakmarket/screens/Detail.dart';
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
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      )
    ],
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(globalWebviewManager).init();

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

// test...

// void main() {
//   runApp(const MaterialApp(
//     title: 'Navigation Basics',
//     home: FirstRoute(),
//   ));
// }

// class FirstRoute extends StatelessWidget {
//   const FirstRoute({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('First Route'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           child: const Text('Open route'),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const SecondRoute()),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class SecondRoute extends StatelessWidget {
//   const SecondRoute({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Second Route'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: const Text('Go back!'),
//         ),
//       ),
//     );
//   }
// }
