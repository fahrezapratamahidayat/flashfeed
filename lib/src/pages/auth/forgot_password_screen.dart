import 'package:flashfeed/src/widgets/button.dart';
import 'package:flashfeed/src/widgets/text_field.dart';
import 'package:flashfeed/src/widgets/spacing.dart';
import 'package:flashfeed/src/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final List<TextEditingController> _pinControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _pinFocusNodes = List.generate(
    4,
    (index) => FocusNode(),
  );

  int _currentStep = 0;
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  final List<String> _stepTitles = [
    "Lupa Kata Sandi",
    "Verifikasi Kode",
    "Kata Sandi Baru",
    "Berhasil",
  ];

  @override
  void dispose() {
    _emailController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    for (var controller in _pinControllers) {
      controller.dispose();
    }
    for (var node in _pinFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 3) {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  Future<void> _handleStepAction() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    // Simulasi API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    if (_currentStep == 3) {
      Navigator.pop(context);
    } else {
      _nextStep();
    }
  }

  Widget _buildStepIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: List.generate(4, (index) {
          bool isActive = index == _currentStep;
          bool isCompleted = index < _currentStep;

          return Expanded(
            child: Container(
              height: 4,
              margin: EdgeInsets.only(right: index < 3 ? 8 : 0),
              decoration: BoxDecoration(
                color: isActive || isCompleted
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildEmailStep() {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          label: 'Email',
          placeholder: 'Masukkan alamat email Anda',
          autofocus: true,
          variant: TextFieldVariant.outlined,
          size: TextFieldSize.medium,
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.done,
          prefixIcon: Icon(
            Icons.email_outlined,
            color: colorScheme.onSurfaceVariant,
            size: 20,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Email tidak boleh kosong';
            } else if (!RegExp(
              r'^[\w-.]+@([\w-]+\.)+[\w]{2,4}$',
            ).hasMatch(value)) {
              return 'Format email tidak valid';
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ],
    );
  }

  Widget _buildCodeStep() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            children: [
              const TextSpan(text: 'Kami telah mengirimkan kode ke '),
              TextSpan(
                text: _emailController.text,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
        Spacing.vertical(Spacing.lg),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(4, (index) {
            return SizedBox(
              width: 68,
              height: 68,
              child: TextFormField(
                controller: _pinControllers[index],
                focusNode: _pinFocusNodes[index],
                autofocus: index == 0,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 1,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  counterText: '',
                  filled: true,
                  fillColor: colorScheme.surfaceContainerHighest.withValues(
                    alpha: 0.3,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colorScheme.outline),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colorScheme.outline),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
                onChanged: (value) {
                  if (value.length == 1 && index < 3) {
                    FocusScope.of(
                      context,
                    ).requestFocus(_pinFocusNodes[index + 1]);
                  } else if (value.isEmpty && index > 0) {
                    FocusScope.of(
                      context,
                    ).requestFocus(_pinFocusNodes[index - 1]);
                  }
                },
              ),
            );
          }),
        ),
        Spacing.vertical(Spacing.lg),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tidak menerima kode? ',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Kirim Ulang',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPasswordStep() {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          label: 'Kata Sandi Baru',
          placeholder: 'Masukkan kata sandi baru',
          controller: _newPasswordController,
          obscureText: !_isPasswordVisible,
          autofocus: true,
          variant: TextFieldVariant.outlined,
          size: TextFieldSize.medium,
          textInputAction: TextInputAction.next,
          prefixIcon: Icon(
            Icons.lock_outline_rounded,
            color: colorScheme.onSurfaceVariant,
            size: 20,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordVisible
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              size: 20,
              color: colorScheme.onSurfaceVariant,
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
            tooltip: _isPasswordVisible
                ? 'Sembunyikan kata sandi'
                : 'Tampilkan kata sandi',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Kata sandi tidak boleh kosong';
            } else if (value.length < 8) {
              return 'Kata sandi minimal 8 karakter';
            } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
              return 'Kata sandi harus memiliki minimal 1 huruf kapital';
            } else if (!RegExp(r'[0-9]').hasMatch(value)) {
              return 'Kata sandi harus memiliki minimal 1 angka';
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),

        Spacing.vertical(Spacing.md),

        AppTextField(
          label: 'Konfirmasi Kata Sandi',
          placeholder: 'Masukkan ulang kata sandi baru',
          controller: _confirmPasswordController,
          obscureText: !_isConfirmPasswordVisible,
          variant: TextFieldVariant.outlined,
          size: TextFieldSize.medium,
          textInputAction: TextInputAction.done,
          prefixIcon: Icon(
            Icons.lock_outline_rounded,
            color: colorScheme.onSurfaceVariant,
            size: 20,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _isConfirmPasswordVisible
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              size: 20,
              color: colorScheme.onSurfaceVariant,
            ),
            onPressed: () {
              setState(() {
                _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
              });
            },
            tooltip: _isConfirmPasswordVisible
                ? 'Sembunyikan kata sandi'
                : 'Tampilkan kata sandi',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Konfirmasi kata sandi tidak boleh kosong';
            } else if (value != _newPasswordController.text) {
              return 'Konfirmasi kata sandi tidak sesuai';
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ],
    );
  }

  Widget _buildSuccessStep() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check_rounded,
            color: colorScheme.primary,
            size: 60,
          ),
        ),
        Spacing.vertical(Spacing.lg),
        Text(
          'Kata Sandi Berhasil Diubah!',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: colorScheme.primary,
          ),
        ),
        Spacing.vertical(Spacing.sm),
        Text(
          'Kata sandi Anda berhasil diubah.\nSekarang Anda dapat masuk dengan kata sandi baru.',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildEmailStep();
      case 1:
        return _buildCodeStep();
      case 2:
        return _buildPasswordStep();
      case 3:
        return _buildSuccessStep();
      default:
        return _buildEmailStep();
    }
  }

  String _getButtonText() {
    switch (_currentStep) {
      case 0:
        return 'Kirim Kode';
      case 1:
        return 'Verifikasi';
      case 2:
        return 'Atur Ulang Kata Sandi';
      case 3:
        return 'Kembali ke Halaman Masuk';
      default:
        return 'Lanjut';
    }
  }

  String _getStepDescription() {
    switch (_currentStep) {
      case 0:
        return 'Masukkan alamat email Anda untuk menerima kode reset kata sandi';
      case 1:
        return 'Masukkan kode 4 digit yang telah kami kirim ke email Anda';
      case 2:
        return 'Buat kata sandi baru yang kuat dan mudah diingat';
      case 3:
        return '';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: _currentStep < 3
            ? IconButton(
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: colorScheme.onSurface,
                ),
                onPressed: _currentStep > 0
                    ? _previousStep
                    : () => Navigator.pop(context),
                tooltip: 'Kembali',
              )
            : null,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildStepIndicator(),

            const SizedBox(height: 24),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Logo
                        if (_currentStep != 3) ...[
                          const AppIcon(height: 64, width: 64),
                          const SizedBox(height: 24),
                        ],

                        Text(
                          _stepTitles[_currentStep],
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: colorScheme.onSurface,
                          ),
                        ),

                        if (_currentStep != 3) ...[
                          const SizedBox(height: 8),
                          Text(
                            _getStepDescription(),
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                              height: 1.5,
                            ),
                          ),
                        ],

                        const SizedBox(height: 32),

                        _buildCurrentStep(),

                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: AppButton(
                text: _getButtonText(),
                variant: ButtonVariant.primary,
                size: ButtonSize.large,
                isLoading: _isLoading,
                onPressed: _handleStepAction,
                isFullWidth: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
