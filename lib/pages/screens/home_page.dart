import 'package:default_app/common/widgets/curved_edges.dart';
import 'package:default_app/constants/colors.dart';
import 'package:default_app/auth/app_state.dart';
import 'package:default_app/services/greeting_service.dart';
import 'package:default_app/widgets/add_item_page.dart';
import 'package:default_app/widgets/custom_bottom_nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    final screenSize = MediaQuery.of(context).size;
    final headerHeight = screenSize.height * 0.55; // Increased height for card

    return CurvedEdgeWidget(
      child: Container(
        color: HomePage._deepBlue,
        padding: EdgeInsets.zero,
        child: SizedBox(
          height: headerHeight,
          child: Stack(
            children: [
              // Background circles
              Positioned(
                top: -headerHeight * 0.375,
                right: -screenSize.width * 0.375,
                child: CircularContainer(
                  backgroundColor: MColors.textWhite.withValues(alpha: 0.1),
                ),
              ),
              Positioned(
                top: headerHeight * 0.25,
                right: -screenSize.width * 0.75,
                child: CircularContainer(
                  backgroundColor: MColors.textWhite.withValues(alpha: 0.1),
                ),
              ),

              // Header content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).padding.top + 16),
                    _UserInfoBar(greeting: greeting, user: user),
                    const SizedBox(height: 24),
                    Expanded(
                      child: _GlucoseCardSection(), // New glucose card section
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GlucoseCardSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = GlucoseMeasurementData(
      title: 'Glucose',
      subtitle: 'Latest measurement',
      currentGlucoseValue: '4,5',
      currentGlucoseUnit: 'mmol/L',
      hypoLevelText: 'Hypos level',
      lastScanText: 'Last Scan',
      lastScanValue: '5,2 mmol/L',
      growthStatus: 'Negative Growth',
      mealStatus: 'Before meal',
      insulinUnits: '12 Insulin units',
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isSmallScreen = constraints.maxWidth < 600;
        final double cardPadding = isSmallScreen ? 12.0 : 16.0;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(cardPadding),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12), // Fixed: withValues()
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2), // Fixed: withValues()
              width: 1,
            ),
          ),
          child: _GlucoseCardContent(data: data, isSmallScreen: isSmallScreen),
        );
      },
    );
  }
}

class _GlucoseCardContent extends StatelessWidget {
  final GlucoseMeasurementData data;
  final bool isSmallScreen;

  const _GlucoseCardContent({required this.data, required this.isSmallScreen});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title and date row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isSmallScreen ? 20 : 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  data.subtitle,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: isSmallScreen ? 13 : 14,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(
                  alpha: 0.15,
                ), // Fixed: withValues()
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    color: Colors.white,
                    size: 14,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    DateFormat('MMM dd, yyyy').format(DateTime.now()),
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Glucose value row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      data.currentGlucoseValue,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isSmallScreen ? 36 : 42,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      data.currentGlucoseUnit,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isSmallScreen ? 16 : 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      data.hypoLevelText,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.info_outline,
                      color: Colors.white70,
                      size: 16,
                    ),
                  ],
                ),
              ],
            ),

            // Last scan column
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  data.lastScanText,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  data.lastScanValue,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isSmallScreen ? 16 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.trending_down, color: Colors.red[300], size: 16),
                    const SizedBox(width: 4),
                    Text(
                      data.growthStatus,
                      style: TextStyle(color: Colors.red[300], fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Action buttons
        Row(
          children: [
            Expanded(
              child: _GlucoseActionButton(
                text: data.mealStatus,
                icon: Icons.restaurant,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _GlucoseActionButton(
                text: data.insulinUnits,
                icon: Icons.medical_services,
              ),
            ),
            const SizedBox(width: 12),
            _AddButton(
              onPressed: () => _showSnackbar(context, 'Add measurement'),
            ),
          ],
        ),
      ],
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class _DateContainer extends StatelessWidget {
  final bool isSmallScreen;

  const _DateContainer({required this.isSmallScreen});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 8 : 10,
        vertical: isSmallScreen ? 4 : 6,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.calendar_today,
            color: Colors.white,
            size: isSmallScreen ? 12 : 14,
          ),
          SizedBox(width: isSmallScreen ? 4 : 6),
          Text(
            DateFormat('MMM dd, yyyy').format(DateTime.now()),
            style: TextStyle(
              color: Colors.white,
              fontSize: isSmallScreen ? 12 : 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _GlucoseValueSection extends StatelessWidget {
  final GlucoseMeasurementData data;
  final double largeText;
  final double smallText;
  final double mediumText;

  const _GlucoseValueSection({
    required this.data,
    required this.largeText,
    required this.smallText,
    required this.mediumText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                data.currentGlucoseValue,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: largeText,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                data.currentGlucoseUnit,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: mediumText,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              data.hypoLevelText,
              style: TextStyle(color: Colors.white70, fontSize: smallText),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.info_outline,
              color: Colors.white70,
              size: smallText + 2,
            ),
          ],
        ),
      ],
    );
  }
}

class _LastScanSection extends StatelessWidget {
  final GlucoseMeasurementData data;
  final double smallText;
  final double mediumText;

  const _LastScanSection({
    required this.data,
    required this.smallText,
    required this.mediumText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          data.lastScanText,
          style: TextStyle(color: Colors.white70, fontSize: smallText),
        ),
        const SizedBox(height: 4),
        Text(
          data.lastScanValue,
          style: TextStyle(
            color: Colors.white,
            fontSize: mediumText,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.trending_down,
              color: Colors.red[300],
              size: smallText + 2,
            ),
            const SizedBox(width: 4),
            Text(
              data.growthStatus,
              style: TextStyle(color: Colors.red[300], fontSize: smallText),
            ),
          ],
        ),
      ],
    );
  }
}

class _GlucoseActionButton extends StatelessWidget {
  final String text;
  final IconData icon;

  const _GlucoseActionButton({required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 600;
        final height = isSmallScreen ? 40.0 : 48.0;
        final iconSize = isSmallScreen ? 16.0 : 20.0;
        final fontSize = isSmallScreen ? 12.0 : 14.0;
        final padding = isSmallScreen ? 8.0 : 12.0;

        return Container(
          height: height,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: iconSize, color: Colors.white),
                SizedBox(width: padding),
                Flexible(
                  child: Text(
                    text,
                    style: TextStyle(color: Colors.white, fontSize: fontSize),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AddButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _AddButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 600;
        final buttonSize = isSmallScreen ? 40.0 : 50.0;
        final iconSize = isSmallScreen ? 24.0 : 28.0;

        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: IconButton(
            onPressed: onPressed,
            icon: Container(
              width: buttonSize,
              height: buttonSize,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add,
                color: const Color(0xFF1A237E),
                size: iconSize,
              ),
            ),
          ),
        );
      },
    );
  }
}

// Data model for the Glucose Measurement Card
class GlucoseMeasurementData {
  final String title;
  final String subtitle;
  final String currentGlucoseValue;
  final String currentGlucoseUnit;
  final String hypoLevelText;
  final String lastScanText;
  final String lastScanValue;
  final String growthStatus;
  final String mealStatus;
  final String insulinUnits;

  GlucoseMeasurementData({
    required this.title,
    required this.subtitle,
    required this.currentGlucoseValue,
    required this.currentGlucoseUnit,
    required this.hypoLevelText,
    required this.lastScanText,
    required this.lastScanValue,
    required this.growthStatus,
    required this.mealStatus,
    required this.insulinUnits,
  });
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
        const _ActionIconsRow(),
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

class _ActionIconsRow extends StatelessWidget {
  const _ActionIconsRow();

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
          onPressed: () {
            // Handle notification tap
          },
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
