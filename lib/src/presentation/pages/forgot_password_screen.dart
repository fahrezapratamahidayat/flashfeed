import 'package:flashfeed/src/presentation/widgets/button.dart';
import 'package:flashfeed/src/presentation/widgets/text_field.dart';
import 'package:flashfeed/src/presentation/widgets/spacing.dart';
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
  final _codeController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final List<TextEditingController> _pinControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _pinFocusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );

  int _currentStep = 0;
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final List<String> _stepTitles = [
    "Forgot Password",
    "Password Resend",
    "Set New Password",
    "",
  ];

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
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
                    ? Colors.blue
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildEmailStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Spacing.vertical(Spacing.sm),
        AppTextField(
          label: 'Email',
          autofocus: true,
          variant: TextFieldVariant.filled,
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Email can\'t be empty!';
            } else if (!RegExp(
              r'^[\w-.]+@([\w-]+\.)+[\w]{2,4}$',
            ).hasMatch(value)) {
              return 'Incorrect email format';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildCodeStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'we sent a code to',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
              ),
              Spacing.horizontal(Spacing.sm),
              Text(
                _emailController.text,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
            ],
          ),
        ),
        Spacing.vertical(Spacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(4, (index) {
            return SizedBox(
              width: 68,
              height: 64,
              child: TextFormField(
                controller: _pinControllers[index],
                focusNode: _pinFocusNodes[index],
                autofocus: index == 0,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 1,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  counterText: '',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
                onChanged: (value) {
                  if (value.length == 1 && index < 5) {
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
      ],
    );
  }

  Widget _buildPasswordStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'New Password',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        Spacing.vertical(Spacing.sm),
        AppTextField(
          controller: _newPasswordController,
          obscureText: _obscurePassword,
          autofocus: true,
          placeholder: 'New Password',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Password gak boleh kosong!';
            } else if (value.length < 8) {
              return 'Password minimal 8 karakter!';
            }
            return null;
          },
        ),
        Spacing.vertical(Spacing.md),
        Text(
          'Confirm Password',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        Spacing.vertical(Spacing.sm),
        AppTextField(
          placeholder: 'Confirm New Password',
          controller: _confirmPasswordController,
          obscureText: _obscureConfirmPassword,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Konfirmasi password gak boleh kosong!';
            } else if (value != _newPasswordController.text) {
              return 'Password tidak sama!';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildSuccessStep() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.check, color: Colors.green, size: 40),
        ),
        Spacing.vertical(Spacing.md),
        Text(
          'Password Successfully Changed!',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.green,
          ),
        ),
        Spacing.vertical(Spacing.sm),
        Text(
          'Password kamu berhasil diubah.\nSekarang kamu bisa login dengan New Password.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
            height: 1.4,
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
        return 'Reset Password';
      case 1:
        return 'Continue';
      case 2:
        return 'Reset Password';
      case 3:
        return 'Kembali ke Login';
      default:
        return 'Lanjut';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FlutterLogo(size: 50),
                      Spacing.vertical(Spacing.sm),
                      Text(
                        _stepTitles[_currentStep],
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (_currentStep == 0) ...[
                        Spacing.vertical(Spacing.sm),
                        Text(
                          'No Worries, we\'ll send you reset instructions',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            height: 1.4,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                      Spacing.vertical(Spacing.md),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            _buildCurrentStep(),
                            Spacing.vertical(Spacing.lg),
                            SizedBox(
                              width: double.infinity,
                              height: 44,
                              child: AppButton(
                                onPressed: _isLoading
                                    ? null
                                    : _handleStepAction,
                                text: _isLoading ? 'Loading' : _getButtonText(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Spacing.vertical(Spacing.xxl),
              _buildStepIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
