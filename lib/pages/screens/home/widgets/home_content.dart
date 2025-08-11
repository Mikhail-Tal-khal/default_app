import 'package:default_app/pages/screens/home/widgets/home_header.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeContent extends StatelessWidget {
  final String greeting;
  final User user;

  const HomeContent({super.key, required this.greeting, required this.user});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeHeader(greeting: greeting, user: user),
          // Add other home page sections here
        ],
      ),
    );
  }
}