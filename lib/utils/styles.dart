import 'package:flutter/material.dart';
import '/utils/constants.dart';

class Styles {
  static const TextStyle appBarTitleStyle = TextStyle(
    color: AppConstants.textColor,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle headingStyle = TextStyle(
    color: AppConstants.textColor,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle subheadingStyle = TextStyle(
    color: AppConstants.textColor,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle bodyStyle = TextStyle(
    color: AppConstants.textColor,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle captionStyle = TextStyle(
    color: AppConstants.darkGray,
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle linkStyle = TextStyle(
    color: AppConstants.primaryColor,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.underline,
  );
}