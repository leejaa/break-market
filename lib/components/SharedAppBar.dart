import 'package:flutter/material.dart';

AppBar Function() sharedAppBar = () {
  return AppBar(
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
  );
};
