// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get greeting_morning => 'Good Morning ☀️';

  @override
  String get greeting_afternoon => 'Good Afternoon 🌤️';

  @override
  String get greeting_evening => 'Good Evening 🌇';

  @override
  String get greeting_night => 'Good Night 🌙';
}
