import 'package:breakmarket/components/GlobalNavigationBar.dart';
import 'package:breakmarket/components/WebviewBody.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CommonContainer extends StatefulWidget {
  final String title;
  const CommonContainer({super.key, required this.title});

  @override
  State<CommonContainer> createState() => _CommonContainerState();
}

class _CommonContainerState extends State<CommonContainer> {
  @override
  Widget build(BuildContext context) {
    String title = widget.title;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: Text(title)),
      body: const WebviewBody(),
    ));
  }
}
