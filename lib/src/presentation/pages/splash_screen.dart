import 'package:flashfeed/src/config/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await Future.delayed(Duration(seconds: 3)); // Simulasi loading

    final prefs = await SharedPreferences.getInstance();
    final seenIntro = prefs.getBool('seen_intro') ?? false;

    if (!seenIntro) {
      Navigator.pushReplacementNamed(context, AppRoutes.introduction);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: FlutterLogo(size: 100)));
  }
}
