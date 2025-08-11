import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:default_app/constants/colors.dart';

class UserInfoBar extends StatelessWidget {
  final String greeting;
  final User user;

  const UserInfoBar({super.key, required this.greeting, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        UserProfile(greeting: greeting, user: user),
        ActionIconsRow(),
      ],
    );
  }
}

class UserProfile extends StatelessWidget {
  final String greeting;
  final User user;

  const UserProfile({super.key, required this.greeting, required this.user});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;

    return Row(
      children: [
        CircleAvatar(
          radius: isSmallScreen ? 20 : 24,
          backgroundColor: Colors.white.withValues(alpha: 0.2),
          backgroundImage: user.photoURL != null
              ? NetworkImage(user.photoURL!)
              : const AssetImage('assets/006.png') as ImageProvider,
        ),
        SizedBox(width: isSmallScreen ? 12 : 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              greeting,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: isSmallScreen ? 12 : 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: isSmallScreen ? 2 : 4),
            Text(
              user.displayName ?? 'User',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: isSmallScreen ? 16 : 18,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ActionIconsRow extends StatelessWidget {
  const ActionIconsRow({super.key});

  Widget _buildActionIcon({
    required IconData icon,
    required VoidCallback onPressed,
    Widget? badge,
    required bool isSmallScreen,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(isSmallScreen ? 8 : 12),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          IconButton(
            icon: Icon(
              icon,
              size: isSmallScreen ? 20 : 28,
              color: Colors.white,
            ),
            padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
            onPressed: onPressed,
          ),
          if (badge != null)
            Positioned(
              right: isSmallScreen ? 6 : 8,
              top: isSmallScreen ? 6 : 8,
              child: badge,
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildActionIcon(
          icon: Icons.notifications_none_rounded,
          onPressed: () {},
          badge: Container(
            width: isSmallScreen ? 8 : 12,
            height: isSmallScreen ? 8 : 12,
            decoration: BoxDecoration(
              color: MColors.error,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: isSmallScreen ? 1 : 1.5,
              ),
            ),
          ),
          isSmallScreen: isSmallScreen,
        ),
        SizedBox(width: isSmallScreen ? 4 : 8),
        _buildActionIcon(
          icon: Icons.settings_outlined,
          onPressed: () => Navigator.pushNamed(context, '/settings'),
          isSmallScreen: isSmallScreen,
        ),
      ],
    );
  }
}