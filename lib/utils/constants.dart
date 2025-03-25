import 'dart:ui';

class AppConstants {
  static const String appName = 'SympCheck Navigator';

  // API Endpoints
  static const String baseUrl = 'https://api.sympcheck-navigator.com';
  static const String symptomsEndpoint = '/symptoms';
  static const String conditionsEndpoint = '/conditions';
  static const String articlesEndpoint = '/articles';

  // Asset paths
  static const String logoPath = 'assets/images/logo.png';
  static const String onboarding1Path = 'assets/images/onboarding1.png';
  static const String onboarding2Path = 'assets/images/onboarding2.png';
  static const String onboarding3Path = 'assets/images/onboarding3.png';

  // Colors
  static const Color primaryColor = Color(0xFF3366FF);
  static const Color secondaryColor = Color(0xFF00CC99);
  static const Color accentColor = Color(0xFFFF6633);
  static const Color textColor = Color(0xFF333333);
  static const Color lightGray = Color(0xFFF5F5F5);
  static const Color mediumGray = Color(0xFFE0E0E0);
  static const Color darkGray = Color(0xFF757575);

  // Text styles
  static const double headingFontSize = 24.0;
  static const double subheadingFontSize = 18.0;
  static const double bodyFontSize = 16.0;
  static const double captionFontSize = 14.0;
}