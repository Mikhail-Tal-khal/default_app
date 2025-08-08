import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:default_app/widgets/custom_bottom_nav.dart';
import 'package:default_app/widgets/add_item_page.dart';
import 'package:default_app/auth/app_state.dart';

import '../../services/greeting_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final Color deepBlue = const Color.fromARGB(255, 55, 35, 236);

  void navigateTo(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final greeting = GreetingService.getGreetingLocalized(context);

    // Redirect if user is not logged in
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
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(context, user, greeting),
                      const SizedBox(height: 30),
                      const Center(child: Text('Welcome to Home')),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: deepBlue,
        onPressed: () => navigateTo(context, const AddItemPage()),
        child: const Icon(Icons.add_a_photo_outlined, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

      bottomNavigationBar: CustomBottomNav(deepBlue: deepBlue),
    );
  }

  Widget _buildHeader(BuildContext context, User user, String greeting) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Profile Info
        Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: user.photoURL != null
                  ? NetworkImage(user.photoURL!)
                  : const AssetImage('assets/images/default_avatar.png')
                        as ImageProvider,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  greeting,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                ),
                Text(
                  user.displayName ?? 'User',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),

        // Notification Icon with Red Dot
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_none_rounded, size: 28),
              onPressed: () {
                // Handle notification tap
              },
            ),
            Positioned(
              right: 10,
              top: 10,
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
