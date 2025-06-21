import 'package:flutter/material.dart';

enum ButtonVariant { primary, secondary, accent, destructive, outline, ghost }

enum ButtonSize { small, medium, large }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final bool isLoading;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isFullWidth;
  final EdgeInsetsGeometry? margin;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.isLoading = false,
    this.prefixIcon,
    this.suffixIcon,
    this.isFullWidth = false,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: SizedBox(
        width: isFullWidth ? double.infinity : null,
        height: _getHeight(),
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: _getButtonStyle(context),
          child: Padding(
            padding: _getPadding(),
            child: isLoading
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (prefixIcon != null) ...[
                        // Menggunakan widget prefixIcon langsung
                        prefixIcon!,
                        SizedBox(width: _getSpacing()),
                      ],
                      Flexible(
                        child: Text(
                          text,
                          style: TextStyle(
                            fontSize: _getFontSize(),
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (suffixIcon != null) ...[
                        SizedBox(width: _getSpacing()),
                        suffixIcon!,
                      ],
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  double _getHeight() {
    switch (size) {
      case ButtonSize.small:
        return 32;
      case ButtonSize.medium:
        return 40;
      case ButtonSize.large:
        return 48;
    }
  }

  double _getFontSize() {
    switch (size) {
      case ButtonSize.small:
        return 14;
      case ButtonSize.medium:
        return 16;
      case ButtonSize.large:
        return 16;
    }
  }

  EdgeInsetsGeometry _getPadding() {
    switch (size) {
      case ButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 12);
      case ButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 16);
      case ButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 20);
    }
  }

  double _getSpacing() {
    switch (size) {
      case ButtonSize.small:
        return 6;
      case ButtonSize.medium:
      case ButtonSize.large:
        return 8;
    }
  }

  ButtonStyle _getButtonStyle(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = Theme.of(context).colorScheme;
    final borderRadius = BorderRadius.circular(8);

    switch (variant) {
      case ButtonVariant.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          shadowColor: Colors.transparent,
        );

      case ButtonVariant.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: colors.secondary,
          foregroundColor: colors.onSecondary,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          shadowColor: Colors.transparent,
        );

      case ButtonVariant.accent:
        return ElevatedButton.styleFrom(
          backgroundColor: colors.tertiary,
          foregroundColor: colors.onTertiary,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          shadowColor: Colors.transparent,
        );

      case ButtonVariant.destructive:
        return ElevatedButton.styleFrom(
          backgroundColor: colors.error,
          foregroundColor: colors.onError,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          shadowColor: Colors.transparent,
        );

      case ButtonVariant.outline:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: colors.inverseSurface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
            side: BorderSide(color: colors.primary),
          ),
          shadowColor: Colors.transparent,
        );

      case ButtonVariant.ghost:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: isDark ? colors.onSurface : colors.onSurface,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          shadowColor: Colors.transparent,
        );
    }
  }

  Color _getForegroundColor(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    switch (variant) {
      case ButtonVariant.primary:
        return colors.onPrimary;
      case ButtonVariant.secondary:
        return colors.onSecondary;
      case ButtonVariant.accent:
        return colors.onTertiary;
      case ButtonVariant.destructive:
        return colors.onError;
      case ButtonVariant.outline:
        return colors.primary;
      case ButtonVariant.ghost:
        return isDark ? colors.onSurface : colors.onSurface;
    }
  }
}
