import 'package:flutter/material.dart';
import 'package:flashfeed/src/config/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:flashfeed/src/providers/auth_provider.dart';

class AuthWrapper extends StatelessWidget {
  final Widget child;

  const AuthWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        if (!authProvider.isAuthenticated) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          });
          return Container();
        }
        return child;
      },
    );
  }
}
