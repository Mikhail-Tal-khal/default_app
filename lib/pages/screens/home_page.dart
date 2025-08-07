import 'package:default_app/auth/app_state.dart';
import 'package:default_app/widgets/add_item_page.dart';
import 'package:default_app/widgets/custom_bottom_nav.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final Color deepBlue = const Color.fromARGB(255, 26, 6, 204); // Deep blue

  void navigateTo(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppState.saveLastPage('home');
    });

    return Scaffold(
      body: const Center(child: Text('Welcome to Home')),

      floatingActionButton: SizedBox(
        height: 56,
        width: 56,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: deepBlue,
          onPressed: () => navigateTo(context, const AddItemPage()),
          child: const Icon(Icons.add_a_photo_outlined, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

      bottomNavigationBar: CustomBottomNav(deepBlue: deepBlue),
    );
  }
}
