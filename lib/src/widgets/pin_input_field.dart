import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PinInputField extends StatefulWidget {
  final int pinLength;
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final bool obscureText;
  final bool autofocus;
  final BoxShape shape;
  final double boxSize;
  final double spacing;
  final TextStyle? textStyle;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? backgroundColor;
  final Color? errorColor;
  final String? errorText;
  final bool autoFocusNext;
  final bool autoUnfocusWhenCompleted;
  final String obscuringCharacter;
  final bool enabled;

  const PinInputField({
    super.key,
    this.pinLength = 6,
    this.onCompleted,
    this.onChanged,
    this.controller,
    this.obscureText = false,
    this.autofocus = false,
    this.shape = BoxShape.rectangle,
    this.boxSize = 50,
    this.spacing = 10,
    this.textStyle,
    this.activeColor,
    this.inactiveColor,
    this.backgroundColor,
    this.errorColor,
    this.errorText,
    this.autoFocusNext = true,
    this.autoUnfocusWhenCompleted = true,
    this.obscuringCharacter = '•',
    this.enabled = true,
  });

  @override
  State<PinInputField> createState() => _PinInputFieldState();
}

class _PinInputFieldState extends State<PinInputField> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  late List<String> _pin;

  @override
  void initState() {
    super.initState();
    _initializeFields();
  }

  void _initializeFields() {
    _controllers = List.generate(
      widget.pinLength,
      (index) => TextEditingController(),
    );

    _focusNodes = List.generate(widget.pinLength, (index) => FocusNode());

    _pin = List.filled(widget.pinLength, '');

    if (widget.controller != null && widget.controller!.text.isNotEmpty) {
      _setTextToControllers(widget.controller!.text);
    }

    // Tambahkan listener untuk setiap controller untuk mengupdate pin
    for (int i = 0; i < widget.pinLength; i++) {
      _controllers[i].addListener(() {
        _updatePinAndCallback();
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(PinInputField oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Atur ulang jika panjang pin berubah
    if (oldWidget.pinLength != widget.pinLength) {
      // Hapus controller dan focus node yang lama
      for (var controller in _controllers) {
        controller.dispose();
      }
      for (var node in _focusNodes) {
        node.dispose();
      }

      // Inisialisasi ulang
      _initializeFields();
    }

    // Update text dari controller eksternal jika berubah
    if (widget.controller != null &&
        widget.controller!.text != _getPin() &&
        widget.controller!.text.length <= widget.pinLength) {
      _setTextToControllers(widget.controller!.text);
    }
  }

  // Mengatur input ke controller internal
  void _setTextToControllers(String text) {
    for (int i = 0; i < widget.pinLength; i++) {
      if (i < text.length) {
        _controllers[i].text = text[i];
        _pin[i] = text[i];
      } else {
        _controllers[i].text = '';
        _pin[i] = '';
      }
    }
  }

  // Mendapatkan nilai PIN secara lengkap
  String _getPin() {
    return _pin.join();
  }

  // Update pin dan panggil callback
  void _updatePinAndCallback() {
    for (int i = 0; i < widget.pinLength; i++) {
      _pin[i] = _controllers[i].text;
    }

    // Panggil callback onChanged
    if (widget.onChanged != null) {
      widget.onChanged!(_getPin());
    }

    // Jika semua field sudah diisi, panggil callback onCompleted
    if (_pin.every((digit) => digit.isNotEmpty)) {
      if (widget.onCompleted != null) {
        widget.onCompleted!(_getPin());
      }

      // Auto unfocus jika sudah lengkap
      if (widget.autoUnfocusWhenCompleted) {
        for (var node in _focusNodes) {
          node.unfocus();
        }
      }
    }

    // Update nilai controller eksternal jika ada
    if (widget.controller != null) {
      final currentValue = _getPin();
      widget.controller!.value = TextEditingValue(
        text: currentValue,
        selection: TextSelection.collapsed(offset: currentValue.length),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final activeColor = widget.activeColor ?? colors.primary;
    final inactiveColor = widget.inactiveColor ?? colors.outline;
    final backgroundColor = widget.backgroundColor ?? colors.surface;
    final errorColor = widget.errorColor ?? colors.error;

    final defaultTextStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: theme.textTheme.bodyLarge?.color,
    );

    final textStyle = widget.textStyle ?? defaultTextStyle;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.pinLength * 2 - 1, (index) {
            // Spasi antara kotak
            if (index.isOdd) {
              return SizedBox(width: widget.spacing);
            }

            final digitIndex = index ~/ 2;

            return SizedBox(
              width: widget.boxSize,
              height: widget.boxSize,
              child: Stack(
                children: [
                  // Background box
                  Container(
                    width: widget.boxSize,
                    height: widget.boxSize,
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      shape: widget.shape,
                      borderRadius: widget.shape == BoxShape.rectangle
                          ? BorderRadius.circular(12)
                          : null,
                      border: Border.all(
                        color: _focusNodes[digitIndex].hasFocus
                            ? activeColor
                            : _controllers[digitIndex].text.isNotEmpty
                            ? activeColor.withValues(alpha: 0.7)
                            : widget.errorText != null
                            ? errorColor
                            : inactiveColor,
                        width: _focusNodes[digitIndex].hasFocus ? 2 : 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child:
                        widget.obscureText &&
                            _controllers[digitIndex].text.isNotEmpty
                        ? Text(widget.obscuringCharacter, style: textStyle)
                        : null,
                  ),

                  // Hidden TextField
                  TextField(
                    controller: _controllers[digitIndex],
                    focusNode: _focusNodes[digitIndex],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    autofocus: widget.autofocus && digitIndex == 0,
                    enabled: widget.enabled,
                    showCursor: false,
                    readOnly: !widget.enabled,
                    style: widget.obscureText
                        ? TextStyle(
                            color: Colors.transparent,
                            fontSize: textStyle.fontSize,
                          )
                        : textStyle,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      counterText: '',
                      contentPadding: EdgeInsets.zero,
                    ),
                    onChanged: (value) {
                      // Auto focus ke field berikutnya
                      if (widget.autoFocusNext) {
                        if (value.isNotEmpty &&
                            digitIndex < widget.pinLength - 1) {
                          _focusNodes[digitIndex + 1].requestFocus();
                        } else if (value.isEmpty && digitIndex > 0) {
                          _focusNodes[digitIndex - 1].requestFocus();
                        }
                      }
                    },
                  ),
                ],
              ),
            );
          }),
        ),

        // Error Text
        if (widget.errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 4),
            child: Text(
              widget.errorText!,
              style: TextStyle(color: errorColor, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
