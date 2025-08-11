import 'package:default_app/auth/app_state.dart';
import 'package:default_app/auth/auth_service.dart';
import 'package:default_app/constants/theme/theme.dart';
import 'package:default_app/l10n/app_localizations.dart';
import 'package:default_app/pages/login_page.dart';
import 'package:default_app/pages/screens/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [Provider<AuthService>(create: (_) => AuthService())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('sw'), // add other locales if needed
      ],
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: appTheme,
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  String? _lastVisitedPage;

  @override
  void initState() {
    super.initState();
    _loadLastPage();
  }

  Future<void> _loadLastPage() async {
    final lastPage = await AppState.getLastPage();
    setState(() => _lastVisitedPage = lastPage);
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return StreamBuilder<User?>(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;

          // Redirect logic
          if (user == null) {
            return const LoginPage();
          } else {
            // Navigate to last visited page if exists
            if (_lastVisitedPage == 'home') {
              return  HomePage();
            } else {
              // Default page after login
              return  HomePage(); // Replace with your initial post-login page
            }
          }
        }
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
