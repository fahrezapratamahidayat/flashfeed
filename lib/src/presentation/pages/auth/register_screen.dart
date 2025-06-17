import 'package:flashfeed/src/config/app_routes.dart';
import 'package:flashfeed/src/presentation/widgets/text_field.dart';
import 'package:flashfeed/src/presentation/widgets/button.dart';
import 'package:flashfeed/src/presentation/widgets/app_logo.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;
  bool _agreeToTerms = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }

  void _handleRegister() {
    if (_formKey.currentState?.validate() ?? false) {
      if (!_agreeToTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Anda harus menyetujui syarat dan ketentuan'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      setState(() {
        _isLoading = true;
      });

      // Simulasi proses registrasi
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });

        // Navigasi ke halaman login setelah berhasil registrasi
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      });
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: colorScheme.onSurface),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Kembali',
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo
                  Center(child: AppIcon(height: 64, width: 64)),

                  const SizedBox(height: 24),

                  // Judul dan Subtitle
                  Text(
                    'Buat Akun Baru',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Daftar dalam waktu kurang dari 1 menit',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 32),

                  // Nama Lengkap
                  AppTextField(
                    label: "Nama Lengkap",
                    placeholder: "Masukkan nama lengkap Anda",
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    prefixIcon: Icon(
                      Icons.person_outline_rounded,
                      color: colorScheme.onSurfaceVariant,
                      size: 20,
                    ),
                    variant: TextFieldVariant.outlined,
                    size: TextFieldSize.medium,
                    required: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama tidak boleh kosong';
                      }
                      if (value.length < 3) {
                        return 'Nama minimal 3 karakter';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),

                  const SizedBox(height: 16),

                  // Email
                  AppTextField(
                    label: "Email",
                    placeholder: "Masukkan alamat email Anda",
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: colorScheme.onSurfaceVariant,
                      size: 20,
                    ),
                    variant: TextFieldVariant.outlined,
                    size: TextFieldSize.medium,
                    required: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email tidak boleh kosong';
                      }
                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value)) {
                        return 'Format email tidak valid';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),

                  const SizedBox(height: 16),

                  // Password
                  AppTextField(
                    label: "Kata Sandi",
                    placeholder: "Masukkan kata sandi Anda",
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
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
                      onPressed: _togglePasswordVisibility,
                      tooltip: _isPasswordVisible
                          ? 'Sembunyikan kata sandi'
                          : 'Tampilkan kata sandi',
                    ),
                    variant: TextFieldVariant.outlined,
                    size: TextFieldSize.medium,
                    required: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Kata sandi tidak boleh kosong';
                      }
                      if (value.length < 8) {
                        return 'Kata sandi minimal 8 karakter';
                      }
                      if (!RegExp(r'[A-Z]').hasMatch(value)) {
                        return 'Kata sandi harus memiliki minimal 1 huruf kapital';
                      }
                      if (!RegExp(r'[0-9]').hasMatch(value)) {
                        return 'Kata sandi harus memiliki minimal 1 angka';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),

                  const SizedBox(height: 16),

                  // Konfirmasi Password
                  AppTextField(
                    label: "Konfirmasi Kata Sandi",
                    placeholder: "Masukkan ulang kata sandi Anda",
                    controller: _confirmPasswordController,
                    obscureText: !_isConfirmPasswordVisible,
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
                      onPressed: _toggleConfirmPasswordVisibility,
                      tooltip: _isConfirmPasswordVisible
                          ? 'Sembunyikan kata sandi'
                          : 'Tampilkan kata sandi',
                    ),
                    variant: TextFieldVariant.outlined,
                    size: TextFieldSize.medium,
                    required: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Konfirmasi kata sandi tidak boleh kosong';
                      }
                      if (value != _passwordController.text) {
                        return 'Konfirmasi kata sandi tidak sesuai';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),

                  const SizedBox(height: 20),

                  // Syarat dan Ketentuan
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: Checkbox(
                          value: _agreeToTerms,
                          onChanged: (value) {
                            setState(() {
                              _agreeToTerms = value ?? false;
                            });
                          },
                          activeColor: colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: RichText(
                            text: TextSpan(
                              text: 'Saya menyetujui ',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Syarat & Ketentuan',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: ' dan ',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Kebijakan Privasi',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Tombol Daftar
                  AppButton(
                    text: 'Daftar',
                    variant: ButtonVariant.primary,
                    size: ButtonSize.large,
                    isLoading: _isLoading,
                    onPressed: _handleRegister,
                    isFullWidth: true,
                  ),

                  const SizedBox(height: 24),

                  // Link ke Login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sudah punya akun? ',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.login,
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Masuk',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
