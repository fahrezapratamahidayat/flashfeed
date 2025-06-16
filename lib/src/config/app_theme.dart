import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//==============================================================================
// PALET WARNA (PILIH SALAH SATU)
//==============================================================================

// Base class untuk struktur warna yang konsisten
abstract class AppColorPalette {
  // Light
  Color get lightBackground;
  Color get lightForeground;
  Color get lightCard;
  Color get lightCardForeground;
  Color get lightPopover;
  Color get lightPopoverForeground;
  Color get lightPrimary;
  Color get lightPrimaryForeground;
  Color get lightSecondary;
  Color get lightSecondaryForeground;
  Color get lightMuted;
  Color get lightMutedForeground;
  Color get lightAccent;
  Color get lightAccentForeground;
  Color get lightDestructive;
  Color get lightDestructiveForeground;
  Color get lightBorder;
  Color get lightInput;
  Color get lightRing;

  // Dark
  Color get darkBackground;
  Color get darkForeground;
  Color get darkCard;
  Color get darkCardForeground;
  Color get darkPopover;
  Color get darkPopoverForeground;
  Color get darkPrimary;
  Color get darkPrimaryForeground;
  Color get darkSecondary;
  Color get darkSecondaryForeground;
  Color get darkMuted;
  Color get darkMutedForeground;
  Color get darkAccent;
  Color get darkAccentForeground;
  Color get darkDestructive;
  Color get darkDestructiveForeground;
  Color get darkBorder;
  Color get darkInput;
  Color get darkRing;
}

/// Palet Warna shadcn/ui - Varian ZINC
class AppColorsZinc implements AppColorPalette {
  const AppColorsZinc();

  @override
  final Color lightBackground = const Color(0xFFFFFFFF);
  @override
  final Color lightForeground = const Color(0xFF09090B);
  @override
  final Color lightCard = const Color(0xFFFFFFFF);
  @override
  final Color lightCardForeground = const Color(0xFF09090B);
  @override
  final Color lightPopover = const Color(0xFFFFFFFF);
  @override
  final Color lightPopoverForeground = const Color(0xFF09090B);
  @override
  final Color lightPrimary = const Color(0xFF18181B);
  @override
  final Color lightPrimaryForeground = const Color(0xFFFAFAFA);
  @override
  final Color lightSecondary = const Color(0xFFF4F4F5);
  @override
  final Color lightSecondaryForeground = const Color(0xFF18181B);
  @override
  final Color lightMuted = const Color(0xFFF4F4F5);
  @override
  final Color lightMutedForeground = const Color(0xFF71717A);
  @override
  final Color lightAccent = const Color(0xFFF4F4F5);
  @override
  final Color lightAccentForeground = const Color(0xFF18181B);
  @override
  final Color lightDestructive = const Color(0xFFEF4444);
  @override
  final Color lightDestructiveForeground = const Color(0xFFFAFAFA);
  @override
  final Color lightBorder = const Color(0xFFE4E4E7);
  @override
  final Color lightInput = const Color(0xFFE4E4E7);
  @override
  final Color lightRing = const Color(0xFF71717A);

  @override
  final Color darkBackground = const Color(0xFF09090B);
  @override
  final Color darkForeground = const Color(0xFFFAFAFA);
  @override
  final Color darkCard = const Color(0xFF09090B);
  @override
  final Color darkCardForeground = const Color(0xFFFAFAFA);
  @override
  final Color darkPopover = const Color(0xFF09090B);
  @override
  final Color darkPopoverForeground = const Color(0xFFFAFAFA);
  @override
  final Color darkPrimary = const Color(0xFFFAFAFA);
  @override
  final Color darkPrimaryForeground = const Color(0xFF18181B);
  @override
  final Color darkSecondary = const Color(0xFF27272A);
  @override
  final Color darkSecondaryForeground = const Color(0xFFFAFAFA);
  @override
  final Color darkMuted = const Color(0xFF27272A);
  @override
  final Color darkMutedForeground = const Color(0xFFA1A1AA);
  @override
  final Color darkAccent = const Color(0xFF27272A);
  @override
  final Color darkAccentForeground = const Color(0xFFFAFAFA);
  @override
  final Color darkDestructive = const Color(0xFF7F1D1D);
  @override
  final Color darkDestructiveForeground = const Color(0xFFFAFAFA);
  @override
  final Color darkBorder = const Color(0xFF27272A);
  @override
  final Color darkInput = const Color(0xFF27272A);
  @override
  final Color darkRing = const Color(0xFFD4D4D8);
}

/// Palet Warna shadcn/ui - Varian BLUE
class AppColorsBlue implements AppColorPalette {
  const AppColorsBlue(); // Tambahkan const constructor

  @override
  final Color lightBackground = const Color(0xFFFFFFFF);
  @override
  final Color lightForeground = const Color(0xFF020817);
  @override
  final Color lightCard = const Color(0xFFFFFFFF);
  @override
  final Color lightCardForeground = const Color(0xFF020817);
  @override
  final Color lightPopover = const Color(0xFFFFFFFF);
  @override
  final Color lightPopoverForeground = const Color(0xFF020817);
  @override
  final Color lightPrimary = const Color(0xFF2563EB);
  @override
  final Color lightPrimaryForeground = const Color(0xFFF8FAFC);
  @override
  final Color lightSecondary = const Color(0xFFF1F5F9);
  @override
  final Color lightSecondaryForeground = const Color(0xFF0F172A);
  @override
  final Color lightMuted = const Color(0xFFF1F5F9);
  @override
  final Color lightMutedForeground = const Color(0xFF64748B);
  @override
  final Color lightAccent = const Color(0xFFF1F5F9);
  @override
  final Color lightAccentForeground = const Color(0xFF0F172A);
  @override
  final Color lightDestructive = const Color(0xFFEF4444);
  @override
  final Color lightDestructiveForeground = const Color(0xFFF8FAFC);
  @override
  final Color lightBorder = const Color(0xFFE2E8F0);
  @override
  final Color lightInput = const Color(0xFFE2E8F0);
  @override
  final Color lightRing = const Color(0xFF94A3B8);

  @override
  final Color darkBackground = const Color(0xFF020817);
  @override
  final Color darkForeground = const Color(0xFFF8FAFC);
  @override
  final Color darkCard = const Color(0xFF020817);
  @override
  final Color darkCardForeground = const Color(0xFFF8FAFC);
  @override
  final Color darkPopover = const Color(0xFF020817);
  @override
  final Color darkPopoverForeground = const Color(0xFFF8FAFC);
  @override
  final Color darkPrimary = const Color(0xFF3B82F6);
  @override
  final Color darkPrimaryForeground = const Color(0xFFF8FAFC);
  @override
  final Color darkSecondary = const Color(0xFF1E293B);
  @override
  final Color darkSecondaryForeground = const Color(0xFFF8FAFC);
  @override
  final Color darkMuted = const Color(0xFF1E293B);
  @override
  final Color darkMutedForeground = const Color(0xFF94A3B8);
  @override
  final Color darkAccent = const Color(0xFF1E293B);
  @override
  final Color darkAccentForeground = const Color(0xFFF8FAFC);
  @override
  final Color darkDestructive = const Color(0xFF7F1D1D);
  @override
  final Color darkDestructiveForeground = const Color(0xFFF8FAFC);
  @override
  final Color darkBorder = const Color(0xFF1E293B);
  @override
  final Color darkInput = const Color(0xFF1E293B);
  @override
  final Color darkRing = const Color(0xFF1E293B);
}

//==============================================================================
// KELAS TEMA UTAMA
//==============================================================================

class AppTheme {
  static final AppColorPalette _colors = const AppColorsZinc();

  static final _fontFamily = GoogleFonts.openSans().fontFamily;
  static const double _borderRadius = 8.0;

  // Tema Terang (Light Mode)
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: _fontFamily,
    scaffoldBackgroundColor: _colors.lightBackground,
    primaryColor: _colors.lightPrimary,
    colorScheme: ColorScheme.light(
      primary: _colors.lightPrimary,
      onPrimary: _colors.lightPrimaryForeground,
      secondary: _colors.lightSecondary,
      onSecondary: _colors.lightSecondaryForeground,
      error: _colors.lightDestructive,
      onError: _colors.lightDestructiveForeground,
      surface: _colors.lightCard,
      onSurface: _colors.lightCardForeground,
      outline: _colors.lightBorder,
    ),
    textTheme: _textTheme(
      _colors.lightForeground,
      _colors.lightMutedForeground,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: _colors.lightBackground,
      foregroundColor: _colors.lightForeground,
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: _colors.lightForeground),
      titleTextStyle: TextStyle(
        color: _colors.lightForeground,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: _fontFamily,
      ),
    ),
    elevatedButtonTheme: _elevatedButtonTheme(
      _colors.lightPrimary,
      _colors.lightPrimaryForeground,
    ),
    inputDecorationTheme: _inputDecorationTheme(
      fillColor: _colors.lightInput,
      borderColor: _colors.lightBorder,
      focusedBorderColor: _colors.lightRing,
      hintColor: _colors.lightMutedForeground,
    ),
    dividerTheme: DividerThemeData(color: _colors.lightBorder, thickness: 1),
    cardTheme: CardThemeData(
      color: _colors.lightCard,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
        side: BorderSide(color: _colors.lightBorder),
      ),
    ),
  );

  // Tema Gelap (Dark Mode)
  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: _fontFamily,
    scaffoldBackgroundColor: _colors.darkBackground,
    primaryColor: _colors.darkPrimary,
    colorScheme: ColorScheme.dark(
      primary: _colors.darkPrimary,
      onPrimary: _colors.darkPrimaryForeground,
      secondary: _colors.darkSecondary,
      onSecondary: _colors.darkSecondaryForeground,
      error: _colors.darkDestructive,
      onError: _colors.darkDestructiveForeground,
      surface: _colors.darkCard,
      onSurface: _colors.darkCardForeground,
      outline: _colors.darkBorder,
    ),
    textTheme: _textTheme(_colors.darkForeground, _colors.darkMutedForeground),
    appBarTheme: AppBarTheme(
      backgroundColor: _colors.darkBackground,
      foregroundColor: _colors.darkForeground,
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: _colors.darkForeground),
      titleTextStyle: TextStyle(
        color: _colors.darkForeground,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: _fontFamily,
      ),
    ),
    elevatedButtonTheme: _elevatedButtonTheme(
      _colors.darkPrimary,
      _colors.darkPrimaryForeground,
    ),
    inputDecorationTheme: _inputDecorationTheme(
      fillColor: _colors.darkInput,
      borderColor: _colors.darkBorder,
      focusedBorderColor: _colors.darkRing,
      hintColor: _colors.darkMutedForeground,
    ),
    dividerTheme: DividerThemeData(color: _colors.darkBorder, thickness: 1),
    // **PERBAIKAN**: Menggunakan `CardThemeData` bukan `CardTheme`
    cardTheme: CardThemeData(
      color: _colors.darkCard,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
        side: BorderSide(color: _colors.darkBorder),
      ),
    ),
  );

  // Helper methods (tidak berubah, tapi disertakan untuk kelengkapan)
  static TextTheme _textTheme(Color foreground, Color mutedForeground) {
    return TextTheme(
      displayLarge: TextStyle(color: foreground),
      displayMedium: TextStyle(color: foreground),
      displaySmall: TextStyle(color: foreground),
      headlineLarge: TextStyle(color: foreground),
      headlineMedium: TextStyle(color: foreground, fontWeight: FontWeight.w600),
      headlineSmall: TextStyle(color: foreground, fontWeight: FontWeight.w600),
      titleLarge: TextStyle(color: foreground, fontWeight: FontWeight.w600),
      titleMedium: TextStyle(color: foreground),
      titleSmall: TextStyle(color: foreground),
      bodyLarge: TextStyle(color: foreground),
      bodyMedium: TextStyle(color: foreground),
      bodySmall: TextStyle(color: mutedForeground),
      labelLarge: TextStyle(color: foreground, fontWeight: FontWeight.w600),
      labelMedium: TextStyle(color: mutedForeground),
      labelSmall: TextStyle(color: mutedForeground),
    ).apply(bodyColor: foreground, displayColor: foreground);
  }

  static ElevatedButtonThemeData _elevatedButtonTheme(
    Color primary,
    Color onPrimary,
  ) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: onPrimary,
        elevation: 0,
        shadowColor: Colors.transparent,
        textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  static InputDecorationTheme _inputDecorationTheme({
    required Color fillColor,
    required Color borderColor,
    required Color focusedBorderColor,
    required Color hintColor,
  }) {
    return InputDecorationTheme(
      filled: true,
      fillColor: fillColor,
      hintStyle: TextStyle(color: hintColor),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
        borderSide: BorderSide(color: borderColor, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
        borderSide: BorderSide(color: borderColor, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
        borderSide: BorderSide(color: focusedBorderColor, width: 2),
      ),
    );
  }
}
