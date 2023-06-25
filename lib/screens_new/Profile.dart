import 'package:breakmarket/components/CommonContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("profile screen...");
    return const CommonContainer(
      title: 'Profile',
      url: '/login',
    );
  }
}
