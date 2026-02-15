import 'package:flutter/material.dart';

class AppColors {
  // Primary
  static const Color primary = Color(0xFF58CC02);
  static const Color primaryDark = Color(0xFF46A302);
  static const Color primaryLight = Color(0xFFD7FFB8);

  // Accent
  static const Color accentYellow = Color(0xFFFFC800);
  static const Color accentOrange = Color(0xFFFF9600);
  static const Color accentBlue = Color(0xFF1CB0F6);
  static const Color accentRed = Color(0xFFFF4B4B);
  static const Color accentPurple = Color(0xFFCE82FF);

  // Backgrounds
  static const Color background = Color(0xFFF7F7F7);
  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFF0F0F0);

  // Text
  static const Color textPrimary = Color(0xFF3C3C3C);
  static const Color textSecondary = Color(0xFF777777);
  static const Color textLight = Color(0xFFAFAFAF);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Status
  static const Color success = Color(0xFF58CC02);
  static const Color warning = Color(0xFFFFC800);
  static const Color error = Color(0xFFFF4B4B);
  static const Color info = Color(0xFF1CB0F6);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF58CC02), Color(0xFF46A302)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient blueGradient = LinearGradient(
    colors: [Color(0xFF1CB0F6), Color(0xFF0093D4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient orangeGradient = LinearGradient(
    colors: [Color(0xFFFF9600), Color(0xFFFF7600)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Shadows
  static List<BoxShadow> softShadow = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.08),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.05),
      blurRadius: 10,
      offset: const Offset(0, 2),
    ),
  ];
}
