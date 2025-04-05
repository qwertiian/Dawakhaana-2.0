import 'package:flutter/material.dart';
import 'phone_login_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Simply redirect to phone login screen
    return const PhoneLoginScreen();
  }
}