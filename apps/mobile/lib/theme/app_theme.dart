import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// App theme configuration for Fog of Flavor
/// Per PRD: Dark mode by default to emphasize "Fog" and "Light" contrast
class AppTheme {
  // Brand colors - Refined Japanese Palette
  static const Color primaryColor = Color(
    0xFFFF5A5F,
  ); // Soft Coral (Popular in Japanese apps)
  static const Color primaryDark = Color(0xFFE04246);
  static const Color primaryLight = Color(0xFFFF8A8E);
  static const Color accentColor = Color(0xFF00B2FF); // Sky Blue

  // Light theme colors (New Default)
  static const Color lightBackground = Color(0xFFF8F9FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceVariant = Color(0xFFF1F3F5);

  // Dark theme colors (Legacy/Optional)
  static const Color darkBackground = Color(0xFF1A1A1B);
  static const Color darkSurface = Color(0xFF242526);
  static const Color darkSurfaceVariant = Color(0xFF3A3B3C);

  // Fog colors
  static const Color fogColorLight = Color(0x66B0B0B0); // Translucent Grey-Blue
  static const Color fogColorDark = Color(0xAA121212);
  static const Color clearedAreaColor = Colors.transparent;

  // Text colors - Light Mode (Default)
  static const Color textPrimaryValue = Color(0xFF2D2E2F);
  static const Color textSecondaryValue = Color(0xFF868E96);

  static const Color textPrimary = textPrimaryValue;
  static const Color textSecondary = textSecondaryValue;
  static const Color textPrimaryLight = textPrimaryValue;
  static const Color textSecondaryLight = textSecondaryValue;

  // Text colors - Dark Mode
  static const Color textPrimaryDark = Color(0xFFF1F3F5);
  static const Color textSecondaryDark = Color(0xFFADB5BD);

  /// Modern light theme with Japanese aesthetic
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // Color scheme
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: accentColor,
        surface: lightSurface,
        onSurface: textPrimaryLight,
        onSurfaceVariant: textSecondaryLight,
        outline: Color(0xFFEBEEF2),
      ),

      // Scaffold
      scaffoldBackgroundColor: lightBackground,

      // App Bar
      appBarTheme: AppBarTheme(
        backgroundColor: lightSurface,
        foregroundColor: textPrimaryLight,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.notoSansJp(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: textPrimaryLight,
          letterSpacing: -0.5,
        ),
      ),

      // Card
      cardTheme: CardThemeData(
        color: lightSurface,
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.05),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),

      // Text theme
      textTheme: GoogleFonts.notoSansJpTextTheme(
        const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: textPrimaryLight,
            letterSpacing: -1.0,
          ),
          displayMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: textPrimaryLight,
          ),
          headlineMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: textPrimaryLight,
          ),
          titleLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: textPrimaryLight,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textPrimaryLight,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: textPrimaryLight,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: textPrimaryLight,
          ),
          bodySmall: TextStyle(fontSize: 12, color: textSecondaryLight),
        ),
      ),

      // Bottom Nav Bar
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: lightSurface,
        selectedItemColor: primaryColor,
        unselectedItemColor: textSecondaryLight,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // ElevatedButton
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 2,
          shadowColor: primaryColor.withValues(alpha: 0.3),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
      ),
    );
  }

  /// Main dark theme (Legacy support)
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: accentColor,
        surface: darkSurface,
        onSurface: textPrimaryDark,
      ),
      scaffoldBackgroundColor: darkBackground,
      textTheme: GoogleFonts.notoSansJpTextTheme(
        const TextTheme(
          bodyLarge: TextStyle(color: textPrimaryDark),
          bodyMedium: TextStyle(color: textPrimaryDark),
          bodySmall: TextStyle(color: textSecondaryDark),
        ),
      ),
      // ... kept for compatibility but lightTheme is preferred now
    );
  }

  // Animation durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 400);
  static const Duration longAnimation = Duration(milliseconds: 600);

  // Spacing constants
  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;

  // Border radius
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;
}
