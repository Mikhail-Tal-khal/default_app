import 'package:shared_preferences/shared_preferences.dart';

class AppState {
  static const _lastPageKey = 'last_page';

  static Future<void> saveLastPage(String pageName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastPageKey, pageName);
  }

  static Future<String?> getLastPage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_lastPageKey);
  }

  static Future<void> clearLastPage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_lastPageKey);
  }
}