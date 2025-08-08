import 'package:default_app/pages/screens/home_page.dart';
import 'package:flutter/material.dart';
import '../widgets/track_page.dart';
import '../widgets/activity_page.dart';
import '../widgets/meals_page.dart';// Adjust path if needed

class CustomBottomNav extends StatelessWidget {
  final Color deepBlue;

  const CustomBottomNav({super.key, required this.deepBlue});

  void navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  Widget navItem(
    BuildContext context,
    IconData icon,
    String label,
    Widget targetPage,
  ) {
    return InkWell(
      onTap: () => navigateTo(context, targetPage),
      child: SizedBox(
        width: 60,
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: deepBlue, size: 30),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(color: deepBlue, fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 6,
      child: SizedBox(
        height: 60,
        child: Row(
          children: [
            const SizedBox(width: 8),
            navItem(context, Icons.home, "Home", const HomePage()),
            const Spacer(),
            navItem(context, Icons.add_chart, "History", const TrackPage()),
            const Spacer(),
            navItem(context, Icons.add_a_photo, "Test", const MealsPage()),
            const Spacer(),
            navItem(context, Icons.account_circle_sharp, "Profile", const ActivityPage()),
            const Spacer(),
            const SizedBox(width: 64), // space for FAB
          ],
        ),
      ),
    );
  }
}
