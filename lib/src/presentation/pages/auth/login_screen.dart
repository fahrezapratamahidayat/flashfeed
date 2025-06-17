import 'package:flashfeed/src/config/app_routes.dart';
import 'package:flashfeed/src/presentation/widgets/button.dart';
import 'package:flashfeed/src/presentation/widgets/app_logo.dart';
import 'package:flashfeed/src/presentation/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(
    text: "fahrezapratamah@gmail.com",
  );
  final _passwordController = TextEditingController(text: "12345678");
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool _rememberMe = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      // Simulasi proses login
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                // Header
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                // Logo
                Center(child: AppIcon(height: 72, width: 72)),

                const SizedBox(height: 24),

                // Judul dan Subtitle
                Text(
                  'Selamat Datang Kembali',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 8),

                Text(
                  'Masuk ke akun Anda untuk melanjutkan',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                // Form Login
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Email Field
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

                      const SizedBox(height: 20),

                      // Password Field
                      AppTextField(
                        label: "Kata Sandi",
                        placeholder: "Masukkan kata sandi Anda",
                        controller: _passwordController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        obscureText: !_isPasswordVisible,
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Kata sandi tidak boleh kosong';
                          }
                          if (value.length < 6) {
                            return 'Kata sandi minimal 6 karakter';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),

                      const SizedBox(height: 16),

                      // Remember Me & Forgot Password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Remember Me
                          Row(
                            children: [
                              SizedBox(
                                height: 24,
                                width: 24,
                                child: Checkbox(
                                  value: _rememberMe,
                                  onChanged: (value) {
                                    setState(() {
                                      _rememberMe = value ?? true;
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
                              const SizedBox(width: 8),
                              Text(
                                'Ingat saya',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),

                          // Forgot Password
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.forgotPassword,
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'Lupa Kata Sandi?',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Login Button
                      AppButton(
                        text: 'Masuk',
                        variant: ButtonVariant.primary,
                        size: ButtonSize.large,
                        isLoading: _isLoading,
                        onPressed: _handleLogin,
                        isFullWidth: true,
                      ),

                      const SizedBox(height: 24),

                      // Divider
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: colorScheme.outlineVariant,
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'Atau',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: colorScheme.outlineVariant,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Social Login Buttons
                      AppButton(
                        text: 'Masuk dengan Google',
                        variant: ButtonVariant.outline,
                        size: ButtonSize.large,
                        prefixIcon: FaIcon(
                          FontAwesomeIcons.google,
                          size: 18,
                          color: colorScheme.onSurface,
                        ),
                        onPressed: () {},
                        isFullWidth: true,
                      ),

                      const SizedBox(height: 16),

                      AppButton(
                        text: 'Masuk dengan Apple',
                        variant: ButtonVariant.outline,
                        size: ButtonSize.large,
                        prefixIcon: FaIcon(
                          FontAwesomeIcons.apple,
                          size: 18,
                          color: colorScheme.onSurface,
                        ),
                        onPressed: () {},
                        isFullWidth: true,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Sign Up Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Belum punya akun? ',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.register);
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Daftar',
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
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
