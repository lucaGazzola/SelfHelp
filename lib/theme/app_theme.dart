import 'package:flutter/material.dart';

class AppTheme {
  // Calming color palette
  static const Color primaryColor = Color(0xFF6B9AC4);    // Soft blue
  static const Color secondaryColor = Color(0xFF93B5A0);  // Sage green
  static const Color backgroundColor = Color(0xFFFAFAFA); // Off-white
  static const Color surfaceColor = Color(0xFFFFFFFF);    // White
  static const Color textColor = Color(0xFF2D3436);       // Soft charcoal
  static const Color accentColor = Color(0xFFB4A7D6);     // Lavender

  // Additional calming colors for variety
  static const Color warmPeach = Color(0xFFF5CAC3);
  static const Color softCoral = Color(0xFFE8A598);
  static const Color paleBlue = Color(0xFFD4E4ED);
  static const Color mintGreen = Color(0xFFD4EDDA);

  static const ColorScheme colorScheme = ColorScheme.light(
    primary: primaryColor,
    secondary: secondaryColor,
    surface: surfaceColor,
    error: Color(0xFFE57373),
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: textColor,
    onError: Colors.white,
  );

  // Animation durations (slow for calming effect)
  static const Duration shortAnimation = Duration(milliseconds: 300);
  static const Duration mediumAnimation = Duration(milliseconds: 500);
  static const Duration longAnimation = Duration(milliseconds: 800);

  // Spacing
  static const double spacingXs = 4;
  static const double spacingSm = 8;
  static const double spacingMd = 16;
  static const double spacingLg = 24;
  static const double spacingXl = 32;
  static const double spacingXxl = 48;

  // Border radius
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 24;
}
