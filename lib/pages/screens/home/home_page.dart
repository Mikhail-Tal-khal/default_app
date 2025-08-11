import 'package:default_app/pages/screens/home/widgets/home_content.dart';
import 'package:default_app/pages/screens/home/widgets/home_fab.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:default_app/widgets/add_item_page.dart';
import 'package:default_app/widgets/custom_bottom_nav.dart';
import 'package:default_app/constants/colors.dart';
import 'package:default_app/auth/app_state.dart';
import 'package:default_app/services/greeting_service.dart';

class HomePage extends StatefulWidget {
  static const _deepBlue = MColors.primary;

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final greeting = GreetingService.getGreeting();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (user == null) {
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        AppState.saveLastPage('home');
      }
    });

    if (user == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: HomeContent(greeting: greeting, user: user),
      floatingActionButton: HomeFloatingActionButton(
        onPressed: () => _navigateTo(context, const AddItemPage()),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: CustomBottomNav(deepBlue: HomePage._deepBlue),
    );
  }
}