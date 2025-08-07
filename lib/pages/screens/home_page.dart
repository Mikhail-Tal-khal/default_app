import 'package:default_app/auth/app_state.dart';
import 'package:default_app/widgets/add_item_page.dart';
import 'package:default_app/widgets/track_page.dart';
import 'package:flutter/material.dart';
import '../../widgets/activity_page.dart';
import '../../widgets/meals_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void navigateTo(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
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
        // Added SizedBox to constrain height
        height: 36, // Match parent constraint height
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          children: [
            Icon(icon, color: Colors.grey, size: 20), // Reduced icon size
            const SizedBox(height: 2), // Reduced spacing
            Text(
              label,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 10, // Reduced font size
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppState.saveLastPage('home');
    });
    return Scaffold(
      body: Center(child: Text('Welcome to Home')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateTo(context, AddItemPage()),
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 0,
          ), // Removed vertical padding
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  navItem(context, Icons.home, "Home", HomePage()),
                  SizedBox(width: 24),
                  navItem(context, Icons.assignment, "Track", TrackPage()),
                ],
              ),
              Row(
                children: [
                  navItem(context, Icons.restaurant_menu, "Meals", MealsPage()),
                  SizedBox(width: 24),
                  navItem(
                    context,
                    Icons.directions_run,
                    "Activity",
                    ActivityPage(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
