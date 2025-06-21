import 'package:flutter/material.dart';

extension ColorExtension on Color {
  Color withValues({double? alpha, double? lightness, double? saturation}) {
    final HSLColor hsl = HSLColor.fromColor(this);
    return HSLColor.fromAHSL(
      alpha ?? hsl.alpha,
      hsl.hue,
      saturation ?? hsl.saturation,
      lightness ?? hsl.lightness,
    ).toColor();
  }
}

class ModernTheme {
  // Zinc Color Palette
  static const Map<int, Color> zincColors = {
    50: Color(0xFFFAFAFA),
    100: Color(0xFFF4F4F5),
    200: Color(0xFFE4E4E7),
    300: Color(0xFFD4D4D8),
    400: Color(0xFFA1A1AA),
    500: Color(0xFF71717A),
    600: Color(0xFF52525B),
    700: Color(0xFF3F3F46),
    800: Color(0xFF27272A),
    900: Color(0xFF18181B),
    950: Color(0xFF09090B),
  };

  // Primary Colors (Blue like Twitter/Vercel)
  static const Map<int, Color> primaryColors = {
    50: Color(0xFFEFF6FF),
    100: Color(0xFFDBEAFE),
    200: Color(0xFFBFDBFE),
    300: Color(0xFF93C5FD),
    400: Color(0xFF60A5FA),
    500: Color(0xFF3B82F6),
    600: Color(0xFF2563EB),
    700: Color(0xFF1D4ED8),
    800: Color(0xFF1E40AF),
    900: Color(0xFF1E3A8A),
  };

  // Accent Colors (Amber)
  static const Map<int, Color> accentColors = {
    50: Color(0xFFFFFBEB),
    100: Color(0xFFFEF3C7),
    200: Color(0xFFFDE68A),
    300: Color(0xFFFCD34D),
    400: Color(0xFFFBBF24),
    500: Color(0xFFF59E0B),
    600: Color(0xFFD97706),
    700: Color(0xFFB45309),
    800: Color(0xFF92400E),
    900: Color(0xFF78350F),
  };

  // Error Colors (Red)
  static const Color errorColor = Color(0xFFEF4444);
  static const Color errorLightColor = Color(0xFFFEE2E2);
  static const Color errorDarkColor = Color(0xFFB91C1C);

  // Success Colors (Green)
  static const Color successColor = Color(0xFF10B981);
  static const Color successLightColor = Color(0xFFD1FAE5);
  static const Color successDarkColor = Color(0xFF047857);

  // Warning Colors (Yellow)
  static const Color warningColor = Color(0xFFF59E0B);
  static const Color warningLightColor = Color(0xFFFEF3C7);
  static const Color warningDarkColor = Color(0xFFB45309);

  // Info Colors (Blue)
  static const Color infoColor = Color(0xFF3B82F6);
  static const Color infoLightColor = Color(0xFFDBEAFE);
  static const Color infoDarkColor = Color(0xFF1D4ED8);

  // Radius values
  static const double radiusXs = 4.0;
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 20.0;
  static const double radiusXxl = 24.0;
  static const double radiusRound = 9999.0;

  // Spacing values
  static const double spacingXxs = 2.0;
  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;
  static const double spacingXxl = 48.0;

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: primaryColors[600]!,
      onPrimary: Colors.white,
      primaryContainer: primaryColors[100]!,
      onPrimaryContainer: primaryColors[800]!,
      secondary: accentColors[500]!,
      onSecondary: Colors.white,
      secondaryContainer: accentColors[100]!,
      onSecondaryContainer: accentColors[800]!,
      tertiary: zincColors[600]!,
      onTertiary: Colors.white,
      tertiaryContainer: zincColors[100]!,
      onTertiaryContainer: zincColors[800]!,
      surface: Colors.white,
      onSurface: zincColors[900]!,
      onSurfaceVariant: zincColors[600]!,
      surfaceTint: primaryColors[50]!,
      error: errorColor,
      onError: Colors.white,
      errorContainer: errorLightColor,
      onErrorContainer: errorDarkColor,
      outline: zincColors[300]!,
      outlineVariant: zincColors[200]!,
      shadow: zincColors[900]!.withValues(alpha: 0.1),
      inverseSurface: zincColors[900]!,
      onInverseSurface: zincColors[50]!,
      inversePrimary: primaryColors[200]!,
    ),

    // Scaffold
    scaffoldBackgroundColor: zincColors[50]!,

    // App Bar
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: zincColors[900],
      elevation: 0,
      scrolledUnderElevation: 1,
      shadowColor: zincColors[200],
      surfaceTintColor: Colors.transparent,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: zincColors[900],
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.2,
      ),
      iconTheme: IconThemeData(color: zincColors[700], size: 24),
      actionsIconTheme: IconThemeData(color: zincColors[700], size: 24),
    ),

    // Cards
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 0,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusMd),
        side: BorderSide(color: zincColors[200]!, width: 1),
      ),
      shadowColor: zincColors[900]!.withValues(alpha: 0.05),
    ),

    // Elevated Button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColors[600]!,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
        minimumSize: const Size(64, 44),
        shadowColor: primaryColors[600]!.withValues(alpha: 0.3),
      ),
    ),

    // Outlined Button
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: zincColors[900],
        side: BorderSide(color: zincColors[300]!),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
        minimumSize: const Size(64, 44),
      ),
    ),

    // Text Button
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColors[600]!,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
    ),

    // Input Decoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMd),
        borderSide: BorderSide(color: zincColors[300]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMd),
        borderSide: BorderSide(color: zincColors[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMd),
        borderSide: BorderSide(color: primaryColors[600]!, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMd),
        borderSide: BorderSide(color: errorColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMd),
        borderSide: BorderSide(color: errorColor, width: 1.5),
      ),
      hintStyle: TextStyle(color: zincColors[500], fontSize: 14),
      labelStyle: TextStyle(
        color: zincColors[700],
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      errorStyle: TextStyle(color: errorColor, fontSize: 12),
      floatingLabelStyle: TextStyle(
        color: primaryColors[600]!,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),

    // Divider
    dividerTheme: DividerThemeData(
      color: zincColors[200],
      thickness: 1,
      space: 1,
    ),

    // Bottom Navigation Bar
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: primaryColors[600],
      unselectedItemColor: zincColors[500],
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),

    // Icon Theme
    iconTheme: IconThemeData(color: zincColors[700], size: 24),

    // Text Theme
    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: zincColors[900],
        fontWeight: FontWeight.w700,
        fontSize: 57,
        height: 1.12,
        letterSpacing: -0.25,
      ),
      displayMedium: TextStyle(
        color: zincColors[900],
        fontWeight: FontWeight.w700,
        fontSize: 45,
        height: 1.16,
      ),
      displaySmall: TextStyle(
        color: zincColors[900],
        fontWeight: FontWeight.w600,
        fontSize: 36,
        height: 1.22,
      ),
      headlineLarge: TextStyle(
        color: zincColors[900],
        fontWeight: FontWeight.w700,
        fontSize: 32,
        height: 1.25,
        letterSpacing: -0.5,
      ),
      headlineMedium: TextStyle(
        color: zincColors[900],
        fontWeight: FontWeight.w600,
        fontSize: 28,
        height: 1.28,
        letterSpacing: -0.5,
      ),
      headlineSmall: TextStyle(
        color: zincColors[900],
        fontWeight: FontWeight.w600,
        fontSize: 24,
        height: 1.33,
        letterSpacing: -0.5,
      ),
      titleLarge: TextStyle(
        color: zincColors[900],
        fontWeight: FontWeight.w600,
        fontSize: 22,
        height: 1.27,
        letterSpacing: -0.25,
      ),
      titleMedium: TextStyle(
        color: zincColors[900],
        fontWeight: FontWeight.w600,
        fontSize: 16,
        height: 1.5,
        letterSpacing: -0.15,
      ),
      titleSmall: TextStyle(
        color: zincColors[900],
        fontWeight: FontWeight.w600,
        fontSize: 14,
        height: 1.43,
        letterSpacing: -0.1,
      ),
      bodyLarge: TextStyle(
        color: zincColors[700],
        fontWeight: FontWeight.w400,
        fontSize: 16,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        color: zincColors[600],
        fontWeight: FontWeight.w400,
        fontSize: 14,
        height: 1.43,
      ),
      bodySmall: TextStyle(
        color: zincColors[500],
        fontWeight: FontWeight.w400,
        fontSize: 12,
        height: 1.33,
      ),
      labelLarge: TextStyle(
        color: zincColors[900],
        fontWeight: FontWeight.w600,
        fontSize: 14,
        height: 1.43,
        letterSpacing: 0.1,
      ),
      labelMedium: TextStyle(
        color: zincColors[700],
        fontWeight: FontWeight.w500,
        fontSize: 12,
        height: 1.33,
        letterSpacing: 0.5,
      ),
      labelSmall: TextStyle(
        color: zincColors[600],
        fontWeight: FontWeight.w500,
        fontSize: 11,
        height: 1.45,
        letterSpacing: 0.5,
      ),
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: primaryColors[500]!,
      onPrimary: zincColors[950]!,
      primaryContainer: primaryColors[800]!,
      onPrimaryContainer: primaryColors[100]!,
      secondary: accentColors[400]!,
      onSecondary: zincColors[950]!,
      secondaryContainer: accentColors[700]!,
      onSecondaryContainer: accentColors[100]!,
      tertiary: zincColors[400]!,
      onTertiary: zincColors[950]!,
      tertiaryContainer: zincColors[700]!,
      onTertiaryContainer: zincColors[100]!,
      surface: zincColors[900]!,
      onSurface: zincColors[100]!,
      surfaceContainerHighest: zincColors[800]!,
      onSurfaceVariant: zincColors[300]!,
      surfaceTint: primaryColors[800]!,
      error: errorColor,
      onError: Colors.white,
      errorContainer: errorDarkColor,
      onErrorContainer: errorLightColor,
      outline: zincColors[700]!,
      outlineVariant: zincColors[800]!,
      shadow: Colors.black.withValues(alpha: 0.3),
      inverseSurface: zincColors[100]!,
      onInverseSurface: zincColors[900]!,
      inversePrimary: primaryColors[700]!,
    ),

    // Scaffold
    scaffoldBackgroundColor: zincColors[950],

    // App Bar
    appBarTheme: AppBarTheme(
      backgroundColor: zincColors[900],
      foregroundColor: zincColors[100],
      elevation: 0,
      scrolledUnderElevation: 1,
      shadowColor: Colors.black.withValues(alpha: 0.2),
      surfaceTintColor: Colors.transparent,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: zincColors[100],
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.2,
      ),
      iconTheme: IconThemeData(color: zincColors[300], size: 24),
      actionsIconTheme: IconThemeData(color: zincColors[300], size: 24),
    ),

    // Cards
    cardTheme: CardThemeData(
      color: zincColors[900],
      elevation: 0,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusMd),
        side: BorderSide(color: zincColors[800]!, width: 1),
      ),
      shadowColor: Colors.black.withValues(alpha: 0.2),
    ),

    // Elevated Button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColors[500]!,
        foregroundColor: zincColors[950]!,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
        minimumSize: const Size(64, 44),
        shadowColor: primaryColors[500]!.withValues(alpha: 0.4),
      ),
    ),

    // Outlined Button
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: zincColors[100],
        side: BorderSide(color: zincColors[700]!),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
        minimumSize: const Size(64, 44),
      ),
    ),

    // Text Button
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColors[400]!,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
    ),

    // Input Decoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: zincColors[800]!,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMd),
        borderSide: BorderSide(color: zincColors[700]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMd),
        borderSide: BorderSide(color: zincColors[700]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMd),
        borderSide: BorderSide(color: primaryColors[500]!, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMd),
        borderSide: BorderSide(color: errorColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMd),
        borderSide: BorderSide(color: errorColor, width: 1.5),
      ),
      hintStyle: TextStyle(color: zincColors[500], fontSize: 14),
      labelStyle: TextStyle(
        color: zincColors[400],
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      errorStyle: TextStyle(color: errorColor, fontSize: 12),
      floatingLabelStyle: TextStyle(
        color: primaryColors[400]!,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),

    // Divider
    dividerTheme: DividerThemeData(
      color: zincColors[800],
      thickness: 1,
      space: 1,
    ),

    // Bottom Navigation Bar
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: zincColors[900],
      selectedItemColor: primaryColors[400],
      unselectedItemColor: zincColors[500],
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),

    // Icon Theme
    iconTheme: IconThemeData(color: zincColors[400], size: 24),

    // Text Theme
    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: zincColors[100],
        fontWeight: FontWeight.w700,
        fontSize: 57,
        height: 1.12,
        letterSpacing: -0.25,
      ),
      displayMedium: TextStyle(
        color: zincColors[100],
        fontWeight: FontWeight.w700,
        fontSize: 45,
        height: 1.16,
      ),
      displaySmall: TextStyle(
        color: zincColors[100],
        fontWeight: FontWeight.w600,
        fontSize: 36,
        height: 1.22,
      ),
      headlineLarge: TextStyle(
        color: zincColors[100],
        fontWeight: FontWeight.w700,
        fontSize: 32,
        height: 1.25,
        letterSpacing: -0.5,
      ),
      headlineMedium: TextStyle(
        color: zincColors[100],
        fontWeight: FontWeight.w600,
        fontSize: 28,
        height: 1.28,
        letterSpacing: -0.5,
      ),
      headlineSmall: TextStyle(
        color: zincColors[100],
        fontWeight: FontWeight.w600,
        fontSize: 24,
        height: 1.33,
        letterSpacing: -0.5,
      ),
      titleLarge: TextStyle(
        color: zincColors[100],
        fontWeight: FontWeight.w600,
        fontSize: 22,
        height: 1.27,
        letterSpacing: -0.25,
      ),
      titleMedium: TextStyle(
        color: zincColors[200],
        fontWeight: FontWeight.w600,
        fontSize: 16,
        height: 1.5,
        letterSpacing: -0.15,
      ),
      titleSmall: TextStyle(
        color: zincColors[200],
        fontWeight: FontWeight.w600,
        fontSize: 14,
        height: 1.43,
        letterSpacing: -0.1,
      ),
      bodyLarge: TextStyle(
        color: zincColors[300],
        fontWeight: FontWeight.w400,
        fontSize: 16,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        color: zincColors[400],
        fontWeight: FontWeight.w400,
        fontSize: 14,
        height: 1.43,
      ),
      bodySmall: TextStyle(
        color: zincColors[500],
        fontWeight: FontWeight.w400,
        fontSize: 12,
        height: 1.33,
      ),
      labelLarge: TextStyle(
        color: zincColors[100],
        fontWeight: FontWeight.w600,
        fontSize: 14,
        height: 1.43,
        letterSpacing: 0.1,
      ),
      labelMedium: TextStyle(
        color: zincColors[300],
        fontWeight: FontWeight.w500,
        fontSize: 12,
        height: 1.33,
        letterSpacing: 0.5,
      ),
      labelSmall: TextStyle(
        color: zincColors[400],
        fontWeight: FontWeight.w500,
        fontSize: 11,
        height: 1.45,
        letterSpacing: 0.5,
      ),
    ),
  );
}
