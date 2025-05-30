import 'package:flashfeed/src/config/app_routes.dart';
import 'package:flashfeed/src/presentation/widgets/button.dart';
import 'package:flashfeed/src/presentation/widgets/app_logo.dart';
import 'package:flashfeed/src/presentation/widgets/text_field.dart';
import 'package:flashfeed/src/presentation/widgets/app_text.dart';
import 'package:flashfeed/src/presentation/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Spacing.vertical(Spacing.xl),
                      AppIcon(height: 56, width: 56),
                      Spacing.vertical(Spacing.md),
                      const AppText(
                        text: 'Let`s Sign In',
                        variant: AppTextVariant.h2,
                        textAlign: TextAlign.center,
                      ),
                      Spacing.vertical(Spacing.sm),
                      const AppText(
                        text: 'Sign in to your account to continue',
                        variant: AppTextVariant.caption,
                        textAlign: TextAlign.center,
                      ),
                      Spacing.vertical(Spacing.lg),
                      AppTextField(
                        label: "Email",
                        placeholder: "Enter your email address",
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
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
                      Spacing.vertical(Spacing.lg),
                      AppTextField(
                        label: "Password",
                        placeholder: "Enter your password",
                        controller: _passwordController,
                        keyboardType: TextInputType.text,
                        floatingLabel: true,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.forgotPassword,
                              );
                            },
                            style: ButtonStyle(
                              overlayColor: WidgetStatePropertyAll(
                                Colors.transparent,
                              ),
                              padding: WidgetStatePropertyAll(EdgeInsets.zero),
                            ),
                            child: AppText(
                              text: "Forgot Password?",
                              variant: AppTextVariant.caption,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      Spacing.vertical(Spacing.sm),
                      SizedBox(
                        width: double.infinity,
                        height: 44,
                        child: AppButton(
                          text: 'Login',
                          variant: ButtonVariant.primary,
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutes.home,
                            );
                          },
                        ),
                      ),
                      Spacing.vertical(Spacing.md),
                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.grey.shade300)),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Spacing.md,
                            ),
                            child: AppText(
                              text: "or",
                              variant: AppTextVariant.caption,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          Expanded(child: Divider(color: Colors.grey.shade300)),
                        ],
                      ),
                      Spacing.vertical(Spacing.md),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 44,
                            child: AppButton(
                              text: 'Sign In With Google',
                              variant: ButtonVariant.outline,
                              prefixIcon: FaIcon(FontAwesomeIcons.google),
                              size: ButtonSize.medium,
                              onPressed: () {},
                            ),
                          ),
                          Spacing.vertical(Spacing.md),
                          SizedBox(
                            height: 44,
                            child: AppButton(
                              text: 'Sign In With Apple',
                              variant: ButtonVariant.outline,
                              prefixIcon: FaIcon(FontAwesomeIcons.apple),
                              size: ButtonSize.medium,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                      Spacing.vertical(Spacing.sm),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppText(
                                text: 'Dont Have An account',
                                variant: AppTextVariant.caption,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.register,
                                  );
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
                                    'Sign Up',
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
