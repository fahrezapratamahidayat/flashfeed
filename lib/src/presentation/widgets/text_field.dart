import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum TextFieldVariant { outlined, filled, underlined }

enum TextFieldSize { small, medium, large }

class AppTextField extends StatefulWidget {
  final String? label;
  final String? placeholder;
  final String? helperText;
  final String? errorText;
  final TextEditingController? controller;
  final TextFieldVariant variant;
  final TextFieldSize size;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final GestureTapCallback? onTap;
  final FocusNode? focusNode;
  final bool readOnly;
  final bool enabled;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool autofocus;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsetsGeometry? contentPadding;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;
  final String? Function(String?)? validator;
  final AutovalidateMode autovalidateMode;
  final bool required;
  final bool floatingLabel;

  const AppTextField({
    super.key,
    this.label,
    this.placeholder,
    this.helperText,
    this.errorText,
    this.controller,
    this.variant = TextFieldVariant.outlined,
    this.size = TextFieldSize.medium,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.focusNode,
    this.readOnly = false,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.prefix,
    this.suffix,
    this.prefixIcon,
    this.suffixIcon,
    this.autofocus = false,
    this.inputFormatters,
    this.contentPadding,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
    this.validator,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.required = false,
    this.floatingLabel = true,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _showPassword = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _hasError = widget.errorText != null;
  }

  @override
  void didUpdateWidget(AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.errorText != widget.errorText) {
      setState(() {
        _hasError = widget.errorText != null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = theme.colorScheme;

    if (widget.floatingLabel && widget.label != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.label!,
                  style: TextStyle(
                    fontSize: _getLabelFontSize(),
                    color: _hasError
                        ? colors.error
                        : theme.textTheme.labelLarge?.color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (widget.required)
                  Text(
                    ' *',
                    style: TextStyle(
                      fontSize: _getLabelFontSize(),
                      color: colors.error,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
          ),
          _buildTextField(theme, isDark, colors, false),
        ],
      );
    } else {
      return _buildTextField(theme, isDark, colors, true);
    }
  }

  Widget _buildTextField(
    ThemeData theme,
    bool isDark,
    ColorScheme colors,
    bool showLabel,
  ) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText: widget.obscureText && !_showPassword,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      onChanged: (value) {
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }

        if (widget.validator != null &&
            widget.autovalidateMode == AutovalidateMode.onUserInteraction) {
          setState(() {
            _hasError = widget.validator!(value) != null;
          });
        }
      },
      onFieldSubmitted: widget.onSubmitted,
      onTap: widget.onTap,
      autofocus: widget.autofocus,
      inputFormatters: widget.inputFormatters,
      validator: widget.validator != null
          ? (value) {
              final error = widget.validator!(value);
              setState(() {
                _hasError = error != null;
              });
              return error;
            }
          : null,
      autovalidateMode: widget.autovalidateMode,
      style: TextStyle(
        fontSize: _getFontSize(),
        color: theme.textTheme.bodyLarge?.color,
      ),
      decoration: InputDecoration(
        labelText: showLabel ? _getLabelText() : null,
        hintText: widget.placeholder,
        helperText: widget.helperText,
        errorText: widget.errorText,
        filled: widget.variant == TextFieldVariant.filled,
        fillColor: _getFillColor(theme),
        isDense: true,
        prefixIcon: widget.prefixIcon != null
            ? Padding(
                padding: const EdgeInsets.only(left: 12, right: 8),
                child: widget.prefixIcon,
              )
            : null,
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _showPassword ? Icons.visibility : Icons.visibility_off,
                  size: _getIconSize(),
                  color: theme.textTheme.bodySmall?.color,
                ),
                onPressed: () {
                  setState(() {
                    _showPassword = !_showPassword;
                  });
                },
              )
            : widget.suffixIcon != null
            ? Padding(
                padding: const EdgeInsets.only(right: 12),
                child: widget.suffixIcon,
              )
            : null,
        prefix: widget.prefix,
        suffix: widget.suffix,
        contentPadding: widget.contentPadding ?? _getContentPadding(),
        prefixIconConstraints:
            widget.prefixIconConstraints ??
            BoxConstraints(
              minWidth: _getIconSize() + 16,
              minHeight: _getHeight(),
            ),
        suffixIconConstraints:
            widget.suffixIconConstraints ??
            BoxConstraints(
              minWidth: _getIconSize() + 16,
              minHeight: _getHeight(),
            ),
        border: _getBorder(theme, false),
        enabledBorder: _getBorder(theme, false),
        focusedBorder: _getBorder(theme, true),
        errorBorder: _getErrorBorder(theme, false),
        focusedErrorBorder: _getErrorBorder(theme, true),
        labelStyle: TextStyle(
          fontSize: _getLabelFontSize(),
          color: _hasError ? colors.error : theme.textTheme.bodySmall?.color,
        ),
        floatingLabelBehavior: widget.variant == TextFieldVariant.filled
            ? FloatingLabelBehavior.never
            : FloatingLabelBehavior.auto,
        hintStyle: TextStyle(
          fontSize: _getFontSize(),
          color: theme.textTheme.bodySmall?.color,
        ),
        helperStyle: TextStyle(
          fontSize: _getHelperFontSize(),
          color: theme.textTheme.bodySmall?.color,
        ),
        errorStyle: TextStyle(
          fontSize: _getHelperFontSize(),
          color: colors.error,
        ),
        // prefixIconPadding: widget.prefixIcon != null
        //     ? EdgeInsets.zero
        //     : const EdgeInsets.only(left: 12, right: 8),
        // suffixIconPadding: widget.suffixIcon != null || widget.obscureText
        //     ? EdgeInsets.zero
        //     : const EdgeInsets.only(right: 12),
      ),
    );
  }

  String? _getLabelText() {
    if (widget.label == null) return null;
    return widget.required ? '${widget.label} *' : widget.label;
  }

  double _getFontSize() {
    switch (widget.size) {
      case TextFieldSize.small:
        return 14;
      case TextFieldSize.medium:
        return 16;
      case TextFieldSize.large:
        return 18;
    }
  }

  double _getLabelFontSize() {
    switch (widget.size) {
      case TextFieldSize.small:
        return 12;
      case TextFieldSize.medium:
        return 14;
      case TextFieldSize.large:
        return 16;
    }
  }

  double _getHelperFontSize() {
    switch (widget.size) {
      case TextFieldSize.small:
        return 10;
      case TextFieldSize.medium:
        return 12;
      case TextFieldSize.large:
        return 14;
    }
  }

  double _getHeight() {
    switch (widget.size) {
      case TextFieldSize.small:
        return 36;
      case TextFieldSize.medium:
        return 44;
      case TextFieldSize.large:
        return 52;
    }
  }

  double _getIconSize() {
    switch (widget.size) {
      case TextFieldSize.small:
        return 16;
      case TextFieldSize.medium:
        return 18;
      case TextFieldSize.large:
        return 20;
    }
  }

  EdgeInsetsGeometry _getContentPadding() {
    final double vertical = widget.size == TextFieldSize.small
        ? 8
        : widget.size == TextFieldSize.medium
        ? 12
        : 16;

    final double horizontal = widget.size == TextFieldSize.small
        ? 10
        : widget.size == TextFieldSize.medium
        ? 12
        : 16;

    final double left = widget.prefixIcon != null ? 0 : horizontal;

    final double right = widget.suffixIcon != null || widget.obscureText
        ? 0
        : horizontal;

    return EdgeInsets.only(
      top: vertical,
      bottom: vertical,
      left: left,
      right: right,
    );
  }

  Color _getFillColor(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;

    if (!widget.enabled) {
      return isDark
          ? Colors.grey.shade800.withValues(alpha: 0.5)
          : Colors.grey.shade200;
    }

    return isDark ? theme.colorScheme.surface : theme.colorScheme.surface;
  }

  InputBorder _getBorder(ThemeData theme, bool isFocused) {
    final isDark = theme.brightness == Brightness.dark;
    final colors = theme.colorScheme;
    final borderRadius = BorderRadius.circular(20.8);

    final Color normalBorderColor = isDark
        ? theme.colorScheme.outline
        : theme.colorScheme.outline;

    final Color focusedBorderColor = colors.primary;

    switch (widget.variant) {
      case TextFieldVariant.outlined:
        return isFocused
            ? OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide(color: focusedBorderColor, width: 1.5),
              )
            : OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide(color: normalBorderColor, width: 1),
              );

      case TextFieldVariant.filled:
        return isFocused
            ? OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide(color: focusedBorderColor, width: 1.5),
              )
            : OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide.none,
              );

      case TextFieldVariant.underlined:
        return isFocused
            ? UnderlineInputBorder(
                borderSide: BorderSide(color: focusedBorderColor, width: 1.5),
              )
            : UnderlineInputBorder(
                borderSide: BorderSide(color: normalBorderColor, width: 1),
              );
    }
  }

  InputBorder _getErrorBorder(ThemeData theme, bool isFocused) {
    final colors = theme.colorScheme;
    final borderRadius = BorderRadius.circular(12);

    switch (widget.variant) {
      case TextFieldVariant.outlined:
        return isFocused
            ? OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide(color: colors.error, width: 1.5),
              )
            : OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide(color: colors.error, width: 1),
              );

      case TextFieldVariant.filled:
        return isFocused
            ? OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide(color: colors.error, width: 1.5),
              )
            : OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide(color: colors.error, width: 1),
              );

      case TextFieldVariant.underlined:
        return isFocused
            ? UnderlineInputBorder(
                borderSide: BorderSide(color: colors.error, width: 1.5),
              )
            : UnderlineInputBorder(
                borderSide: BorderSide(color: colors.error, width: 1),
              );
    }
  }
}
