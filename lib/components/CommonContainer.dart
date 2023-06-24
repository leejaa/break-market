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
      appBar: AppBar(
        leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Image.asset('assets/images/logo.png')),
        leadingWidth: 100,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
            padding: const EdgeInsets.all(8),
            constraints: const BoxConstraints(),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person),
            padding: const EdgeInsets.all(8),
            constraints: const BoxConstraints(),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart),
              padding: const EdgeInsets.all(8),
              constraints: const BoxConstraints(),
            ),
          )
        ],
      ),
      body: const WebviewBody(),
    ));
  }
}
