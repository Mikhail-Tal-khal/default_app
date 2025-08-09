import 'package:default_app/common/widgets/curved_edges.dart';
import 'package:default_app/constants/colors.dart';
import 'package:default_app/auth/app_state.dart';
import 'package:default_app/services/greeting_service.dart';
import 'package:default_app/widgets/add_item_page.dart';
import 'package:default_app/widgets/custom_bottom_nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../common/widgets/circular_conatiner.dart';

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
      body: _HomeContent(greeting: greeting, user: user),
      floatingActionButton: _HomeFloatingActionButton(
        onPressed: () => _navigateTo(context, const AddItemPage()),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: CustomBottomNav(deepBlue: HomePage._deepBlue),
    );
  }
}

class _HomeContent extends StatelessWidget {
  final String greeting;
  final User user;

  const _HomeContent({required this.greeting, required this.user});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HomeHeader(greeting: greeting, user: user),
          // Add other home page content sections here
        ],
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  final String greeting;
  final User user;

  const _HomeHeader({required this.greeting, required this.user});

  @override
  Widget build(BuildContext context) {
    return CurvedEdgeWidget(
      child: Container(
        color: HomePage._deepBlue,
        padding: EdgeInsets.zero,
        child: SizedBox(
          height: 400,
          child: Stack(
            children: [
              Positioned(
                top: -150,
                right: -150,
                child: CircularContainer(
                  backgroundColor: MColors.textWhite.withValues(alpha: 0.1),
                ),
              ),
              Positioned(
                top: 100,
                right: -300,
                child: CircularContainer(
                  backgroundColor: MColors.textWhite.withValues(alpha: 0.1),
                ),
              ),
              Positioned(
                top: 50,
                left: 16,
                right: 16,
                child: _UserInfoBar(greeting: greeting, user: user),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserInfoBar extends StatelessWidget {
  final String greeting;
  final User user;

  const _UserInfoBar({required this.greeting, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _UserProfile(greeting: greeting, user: user),
        const _NotificationIcon(),
      ],
    );
  }
}

class _UserProfile extends StatelessWidget {
  final String greeting;
  final User user;

  const _UserProfile({required this.greeting, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.white.withValues(alpha: 0.2),
          backgroundImage: user.photoURL != null
              ? NetworkImage(user.photoURL!)
              : const AssetImage('assets/006.png') as ImageProvider,
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              greeting,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              user.displayName ?? 'User',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _NotificationIcon extends StatelessWidget {
  const _NotificationIcon();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          icon: const Icon(
            Icons.notifications_none_rounded,
            size: 28,
            color: Colors.white,
          ),
          onPressed: () {
            // Handle notification tap
          },
        ),
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: const Color(0xFFFF4D4D),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}

class _HomeFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _HomeFloatingActionButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: HomePage._deepBlue,
      onPressed: onPressed,
      child: const Icon(Icons.add_a_photo_outlined, color: Colors.white),
    );
  }
}

class CurvedEdgeWidget extends StatelessWidget {
  final Widget? child;

  const CurvedEdgeWidget({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return ClipPath(clipper: CustomCurvedEdges(), child: child);
  }
}
