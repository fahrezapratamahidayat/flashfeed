import 'package:flutter/material.dart';

enum AppTextVariant {
  // Heading styles
  displayLarge,
  displayMedium,
  displaySmall,
  headingLarge,
  headingMedium,
  headingSmall,
  titleLarge,
  titleMedium,
  titleSmall,

  // Body styles
  bodyLarge,
  bodyMedium,
  bodySmall,

  // Utility styles
  labelLarge,
  labelMedium,
  labelSmall,

  // Legacy styles (untuk kompatibilitas)
  h1,
  h2,
  h3,
  h4,
  body,
  caption,
  small,
}

class AppText extends StatelessWidget {
  final String text;
  final AppTextVariant variant;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? letterSpacing;
  final TextDecoration? decoration;
  final bool selectable;
  final double? lineHeight;
  final FontWeight? fontWeight;
  final bool muted;

  const AppText({
    super.key,
    required this.text,
    this.variant = AppTextVariant.bodyMedium,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.letterSpacing,
    this.decoration,
    this.selectable = false,
    this.lineHeight,
    this.fontWeight,
    this.muted = false,
  });

  @override
  Widget build(BuildContext context) {
    if (selectable) {
      return SelectableText(
        text,
        style: _getTextStyle(context),
        textAlign: textAlign,
        maxLines: maxLines,
      );
    }

    return Text(
      text,
      style: _getTextStyle(context),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  TextStyle _getBaseStyle(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Color defaultColor;
    if (muted) {
      defaultColor = isDark
          ? theme.colorScheme.onSurface.withValues(alpha: 0.7)
          : theme.colorScheme.onSurface.withValues(alpha: 0.6);
    } else {
      defaultColor = theme.colorScheme.onSurface;
    }

    return TextStyle(
      color: color ?? defaultColor,
      fontFamily: 'ui-sans-serif, system-ui',
      decoration: decoration,
      letterSpacing: letterSpacing,
      height: lineHeight,
      fontWeight: fontWeight,
    );
  }

  TextStyle _getTextStyle(BuildContext context) {
    final baseStyle = _getBaseStyle(context);
    final theme = Theme.of(context);

    switch (variant) {
      // Display styles
      case AppTextVariant.displayLarge:
        return baseStyle.copyWith(
          fontSize: 57,
          fontWeight: fontWeight ?? FontWeight.w400,
          height: lineHeight ?? 1.12,
          letterSpacing: letterSpacing ?? -0.25,
        );

      case AppTextVariant.displayMedium:
        return baseStyle.copyWith(
          fontSize: 45,
          fontWeight: fontWeight ?? FontWeight.w400,
          height: lineHeight ?? 1.16,
          letterSpacing: letterSpacing ?? 0,
        );

      case AppTextVariant.displaySmall:
        return baseStyle.copyWith(
          fontSize: 36,
          fontWeight: fontWeight ?? FontWeight.w400,
          height: lineHeight ?? 1.22,
          letterSpacing: letterSpacing ?? 0,
        );

      // Heading styles
      case AppTextVariant.headingLarge:
        return baseStyle.copyWith(
          fontSize: 32,
          fontWeight: fontWeight ?? FontWeight.w700,
          height: lineHeight ?? 1.25,
          letterSpacing: letterSpacing ?? -0.5,
        );

      case AppTextVariant.headingMedium:
        return baseStyle.copyWith(
          fontSize: 28,
          fontWeight: fontWeight ?? FontWeight.w700,
          height: lineHeight ?? 1.29,
          letterSpacing: letterSpacing ?? -0.25,
        );

      case AppTextVariant.headingSmall:
        return baseStyle.copyWith(
          fontSize: 24,
          fontWeight: fontWeight ?? FontWeight.w700,
          height: lineHeight ?? 1.33,
          letterSpacing: letterSpacing ?? 0,
        );

      // Title styles
      case AppTextVariant.titleLarge:
        return baseStyle.copyWith(
          fontSize: 22,
          fontWeight: fontWeight ?? FontWeight.w600,
          height: lineHeight ?? 1.27,
          letterSpacing: letterSpacing ?? 0,
        );

      case AppTextVariant.titleMedium:
        return baseStyle.copyWith(
          fontSize: 16,
          fontWeight: fontWeight ?? FontWeight.w600,
          height: lineHeight ?? 1.5,
          letterSpacing: letterSpacing ?? 0.15,
        );

      case AppTextVariant.titleSmall:
        return baseStyle.copyWith(
          fontSize: 14,
          fontWeight: fontWeight ?? FontWeight.w600,
          height: lineHeight ?? 1.43,
          letterSpacing: letterSpacing ?? 0.1,
        );

      // Body styles
      case AppTextVariant.bodyLarge:
        return baseStyle.copyWith(
          fontSize: 16,
          fontWeight: fontWeight ?? FontWeight.w400,
          height: lineHeight ?? 1.5,
          letterSpacing: letterSpacing ?? 0.15,
        );

      case AppTextVariant.bodyMedium:
        return baseStyle.copyWith(
          fontSize: 14,
          fontWeight: fontWeight ?? FontWeight.w400,
          height: lineHeight ?? 1.43,
          letterSpacing: letterSpacing ?? 0.25,
        );

      case AppTextVariant.bodySmall:
        return baseStyle.copyWith(
          fontSize: 12,
          fontWeight: fontWeight ?? FontWeight.w400,
          height: lineHeight ?? 1.33,
          letterSpacing: letterSpacing ?? 0.4,
        );

      // Label styles
      case AppTextVariant.labelLarge:
        return baseStyle.copyWith(
          fontSize: 14,
          fontWeight: fontWeight ?? FontWeight.w500,
          height: lineHeight ?? 1.43,
          letterSpacing: letterSpacing ?? 0.1,
        );

      case AppTextVariant.labelMedium:
        return baseStyle.copyWith(
          fontSize: 12,
          fontWeight: fontWeight ?? FontWeight.w500,
          height: lineHeight ?? 1.33,
          letterSpacing: letterSpacing ?? 0.5,
        );

      case AppTextVariant.labelSmall:
        return baseStyle.copyWith(
          fontSize: 11,
          fontWeight: fontWeight ?? FontWeight.w500,
          height: lineHeight ?? 1.45,
          letterSpacing: letterSpacing ?? 0.5,
        );

      // Legacy styles (untuk kompatibilitas)
      case AppTextVariant.h1:
        return baseStyle.copyWith(
          fontSize: 32,
          fontWeight: fontWeight ?? FontWeight.bold,
          height: lineHeight ?? 1.2,
        );

      case AppTextVariant.h2:
        return baseStyle.copyWith(
          fontSize: 28,
          fontWeight: fontWeight ?? FontWeight.bold,
          height: lineHeight ?? 1.3,
        );

      case AppTextVariant.h3:
        return baseStyle.copyWith(
          fontSize: 24,
          fontWeight: fontWeight ?? FontWeight.w600,
          height: lineHeight ?? 1.3,
        );

      case AppTextVariant.h4:
        return baseStyle.copyWith(
          fontSize: 20,
          fontWeight: fontWeight ?? FontWeight.w600,
          height: lineHeight ?? 1.4,
        );

      case AppTextVariant.body:
        return baseStyle.copyWith(
          fontSize: 16,
          fontWeight: fontWeight ?? FontWeight.normal,
          height: lineHeight ?? 1.5,
        );

      case AppTextVariant.caption:
        return baseStyle.copyWith(
          fontSize: 14,
          fontWeight: fontWeight ?? FontWeight.normal,
          color: color ?? theme.textTheme.bodySmall?.color,
          height: lineHeight ?? 1.4,
        );

      case AppTextVariant.small:
        return baseStyle.copyWith(
          fontSize: 12,
          fontWeight: fontWeight ?? FontWeight.normal,
          color: color ?? theme.textTheme.bodySmall?.color,
          height: lineHeight ?? 1.4,
        );
    }
  }
}

/// Extensions untuk membuat kode lebih bersih
extension StringExtension on String {
  AppText h1({
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    TextDecoration? decoration,
    bool selectable = false,
    double? lineHeight,
    FontWeight? fontWeight,
    bool muted = false,
  }) => AppText(
    text: this,
    variant: AppTextVariant.headingLarge,
    color: color,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    letterSpacing: letterSpacing,
    decoration: decoration,
    selectable: selectable,
    lineHeight: lineHeight,
    fontWeight: fontWeight,
    muted: muted,
  );

  AppText h2({
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    TextDecoration? decoration,
    bool selectable = false,
    double? lineHeight,
    FontWeight? fontWeight,
    bool muted = false,
  }) => AppText(
    text: this,
    variant: AppTextVariant.headingMedium,
    color: color,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    letterSpacing: letterSpacing,
    decoration: decoration,
    selectable: selectable,
    lineHeight: lineHeight,
    fontWeight: fontWeight,
    muted: muted,
  );

  AppText h3({
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    TextDecoration? decoration,
    bool selectable = false,
    double? lineHeight,
    FontWeight? fontWeight,
    bool muted = false,
  }) => AppText(
    text: this,
    variant: AppTextVariant.headingSmall,
    color: color,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    letterSpacing: letterSpacing,
    decoration: decoration,
    selectable: selectable,
    lineHeight: lineHeight,
    fontWeight: fontWeight,
    muted: muted,
  );

  AppText title({
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    TextDecoration? decoration,
    bool selectable = false,
    double? lineHeight,
    FontWeight? fontWeight,
    bool muted = false,
  }) => AppText(
    text: this,
    variant: AppTextVariant.titleLarge,
    color: color,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    letterSpacing: letterSpacing,
    decoration: decoration,
    selectable: selectable,
    lineHeight: lineHeight,
    fontWeight: fontWeight,
    muted: muted,
  );

  AppText subtitle({
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    TextDecoration? decoration,
    bool selectable = false,
    double? lineHeight,
    FontWeight? fontWeight,
    bool muted = false,
  }) => AppText(
    text: this,
    variant: AppTextVariant.titleMedium,
    color: color,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    letterSpacing: letterSpacing,
    decoration: decoration,
    selectable: selectable,
    lineHeight: lineHeight,
    fontWeight: fontWeight,
    muted: muted,
  );

  AppText body({
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    TextDecoration? decoration,
    bool selectable = false,
    double? lineHeight,
    FontWeight? fontWeight,
    bool muted = false,
  }) => AppText(
    text: this,
    variant: AppTextVariant.bodyLarge,
    color: color,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    letterSpacing: letterSpacing,
    decoration: decoration,
    selectable: selectable,
    lineHeight: lineHeight,
    fontWeight: fontWeight,
    muted: muted,
  );

  AppText caption({
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    TextDecoration? decoration,
    bool selectable = false,
    double? lineHeight,
    FontWeight? fontWeight,
    bool muted = false,
  }) => AppText(
    text: this,
    variant: AppTextVariant.bodySmall,
    color: color,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    letterSpacing: letterSpacing,
    decoration: decoration,
    selectable: selectable,
    lineHeight: lineHeight,
    fontWeight: fontWeight,
    muted: muted,
  );

  AppText label({
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    TextDecoration? decoration,
    bool selectable = false,
    double? lineHeight,
    FontWeight? fontWeight,
    bool muted = false,
  }) => AppText(
    text: this,
    variant: AppTextVariant.labelLarge,
    color: color,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    letterSpacing: letterSpacing,
    decoration: decoration,
    selectable: selectable,
    lineHeight: lineHeight,
    fontWeight: fontWeight,
    muted: muted,
  );
}
