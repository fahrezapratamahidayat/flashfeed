import 'package:flashfeed/src/config/app_routes.dart';
import 'package:flashfeed/src/core/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginScreen({super.key});

  Future<void> _login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        final user = await AuthService.loginWithEmail(
          _emailController.text,
          _passwordController.text,
        );

        if (context.mounted && user != null) {
          Navigator.pushReplacementNamed(context, AppRoutes.home);
        }
      } catch (e) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "Email"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _login(context),
                child: Text("Login"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.register);
                },
                child: Text("Don't have an account? Register"),
              ),
              TextButton(
                onPressed: () {
                  // Skip login (optional)
                  Navigator.pushReplacementNamed(context, AppRoutes.home);
                },
                child: Text("Continue as Guest"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
