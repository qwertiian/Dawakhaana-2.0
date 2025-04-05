import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/onboarding_screen.dart';
import 'utils/constants.dart';
import 'utils/styles.dart';
import 'config/env.dart';
import 'screens/auth/phone_login_screen.dart';
import 'screens/onboarding_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {

    // Initialize Supabase
    await Supabase.initialize(
      url: Env.supabaseUrl,
      anonKey: Env.supabaseAnonKey,
    );

    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    runApp(const MyApp());
  } catch (e) {
    runApp(MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Initialization failed: $e'),
        ),
      ),
    ));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SympCheck Navigator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Inter',
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          titleTextStyle: Styles.appBarTitleStyle,
        ),
      ),
<<<<<<< HEAD
      home: const AuthWrapper(), // Changed to use AuthWrapper
=======
      home: const InitialScreen(),
>>>>>>> a6bc40793cdae86e1990de3f4ac9570fd1d98741
    );
  }
}

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Check if user has completed onboarding (you might want to use SharedPreferences for this)
    const hasCompletedOnboarding = false; // Change this based on your logic

    if (!hasCompletedOnboarding) {
      return const OnboardingScreen();
    }

    return const AuthWrapper();
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = Supabase.instance.client.auth.currentSession;

<<<<<<< HEAD
        // If user is logged in, go to home screen
        // If not, show your original onboarding flow
        return session == null ? const OnboardingScreen() : const HomeScreen();
=======
        return session == null
            ? const PhoneLoginScreen()
            : const HomeScreen();
>>>>>>> a6bc40793cdae86e1990de3f4ac9570fd1d98741
      },
    );
  }
}

<<<<<<< HEAD
// Your existing home screen widget
=======
// Placeholder widget for the home screen
>>>>>>> a6bc40793cdae86e1990de3f4ac9570fd1d98741
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Home Screen', style: Styles.appBarTitleStyle),
      ),
    );
  }
}