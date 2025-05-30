import 'package:flashfeed/src/config/app_routes.dart';
import 'package:flashfeed/src/presentation/widgets/text_field.dart';
import 'package:flashfeed/src/presentation/widgets/button.dart';
import 'package:flashfeed/src/presentation/widgets/app_text.dart';
import 'package:flashfeed/src/presentation/widgets/spacing.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Spacing.vertical(Spacing.xl),
                      FlutterLogo(size: 50),
                      Spacing.vertical(Spacing.md),
                      const AppText(
                        text: 'Sign Up For Free',
                        variant: AppTextVariant.h2,
                        textAlign: TextAlign.center,
                      ),
                      Spacing.vertical(Spacing.sm),
                      const AppText(
                        text: 'Join us for less than 1 minute',
                        variant: AppTextVariant.caption,
                        textAlign: TextAlign.center,
                      ),
                      Spacing.vertical(Spacing.lg),
                      AppTextField(
                        label: "Name",
                        placeholder: "Enter your email address",
                        controller: _nameController,
                        keyboardType: TextInputType.emailAddress,
                        required: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          if (value.length <= 6) {
                            return 'Name must be more than 6 characters';
                          }
                          return null;
                        },
                      ),
                      Spacing.vertical(Spacing.md),
                      AppTextField(
                        label: "Email",
                        placeholder: "Enter your email address",
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        required: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      Spacing.vertical(Spacing.md),
                      AppTextField(
                        label: "Password",
                        placeholder: "Enter your password",
                        controller: _passwordController,
                        obscureText: true,
                        required: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      Spacing.vertical(Spacing.md),
                      AppTextField(
                        label: "Confirm Password",
                        placeholder: "Confirm Password",
                        controller: _confirmPasswordController,
                        obscureText: true,
                        required: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      Spacing.vertical(Spacing.lg),
                      SizedBox(
                        width: double.infinity,
                        height: 44,
                        child: AppButton(
                          text: 'Sign Up',
                          onPressed: () {},
                          variant: ButtonVariant.primary,
                        ),
                      ),
                      Spacing.vertical(Spacing.md),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppText(
                                text: 'Already Have Account?',
                                variant: AppTextVariant.caption,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, AppRoutes.login);
                                },
                                style: ButtonStyle(
                                  overlayColor: WidgetStatePropertyAll(
                                    Colors.transparent,
                                  ),
                                  padding: WidgetStatePropertyAll(
                                    EdgeInsets.zero,
                                  ),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.blue,
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Spacing.vertical(Spacing.sm),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
