import 'package:default_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class GreetingService {
  static String getGreetingLocalized(BuildContext context) {
    final now = DateTime.now();
    final hour = now.hour;
    final loc = AppLocalizations.of(context)!;

    if (hour >= 5 && hour < 12) {
      return loc.greeting_morning;
    } else if (hour >= 12 && hour < 17) {
      return loc.greeting_afternoon;
    } else if (hour >= 17 && hour < 21) {
      return loc.greeting_evening;
    } else {
      return loc.greeting_night;
    }
  }
}
