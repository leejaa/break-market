import 'package:breakmarket/components/GlobalNavigationBar.dart';
import 'package:breakmarket/components/WebviewBody.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class CommonContainer extends StatefulWidget {
  final String title;
  final String url;
  const CommonContainer({super.key, required this.title, required this.url});

  @override
  State<CommonContainer> createState() => _CommonContainerState();
}

class _CommonContainerState extends State<CommonContainer> {
  @override
  Widget build(BuildContext context) {
    void handleItemTapped(int index) {
      switch (index) {
        case 0:
          context.go('/');
          break;
        case 1:
          context.go('/profile');
          break;
        default:
      }
    }

    int currentIndex = 0;
    final router = GoRouter.of(context);
    String currentLocation = router.location;
    print("currentLocation: $currentLocation");
    switch (currentLocation) {
      case '/profile':
        currentIndex = 1;
        break;
      default:
    }
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
      body: WebviewBody(widget.url),
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
        currentIndex: currentIndex,
        selectedItemColor: Colors.black,
        onTap: handleItemTapped,
      ),
    ));
  }
}
