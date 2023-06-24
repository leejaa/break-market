import 'package:breakmarket/utils/webview_manager.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final globalWebviewManager = StateProvider((_) => WebViewManager());
