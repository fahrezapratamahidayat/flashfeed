import 'package:flashfeed/src/config/app_routes.dart';
import 'package:flashfeed/src/presentation/widgets/app_logo.dart'; // Asumsikan ini adalah widget logo Anda
import 'package:flashfeed/src/presentation/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _textFadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // Animasi Fade-in untuk logo
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.0,
          0.5,
          curve: Curves.easeIn,
        ), // Muncul di 0-50% durasi
      ),
    );

    // Animasi Scale-up untuk logo
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.0,
          0.5,
          curve: Curves.elasticOut,
        ), // Efek elastis saat membesar
      ),
    );

    // Animasi Fade-in untuk teks "FlashFeed"
    _textFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.5,
          1.0,
          curve: Curves.easeIn,
        ), // Muncul setelah logo (50-100% durasi)
      ),
    );

    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Mulai animasi
    _animationController.forward();

    // Tunggu animasi selesai ATAU minimal 3 detik (mana yang lebih lama)
    // Durasi animasi logo adalah 1000ms, teks muncul setelahnya. Total animasi sekitar 2000ms.
    // Future.delayed asli adalah 3 detik. Kita bisa sesuaikan.
    await Future.delayed(
      const Duration(seconds: 3),
    ); // Total durasi splash screen

    // Hentikan controller jika belum selesai untuk menghindari error
    if (mounted) {
      _animationController.stop();
    }

    final prefs = await SharedPreferences.getInstance();
    final seenIntro = prefs.getBool('seen_intro') ?? false;

    if (!mounted) return; // Pastikan widget masih ada di tree

    if (!seenIntro) {
      Navigator.pushReplacementNamed(context, AppRoutes.introduction);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: const AppIcon(width: 100, height: 100),
              ),
            ),
            Spacing.horizontal(Spacing.lg),
            FadeTransition(
              opacity: _textFadeAnimation,
              child: const Text(
                'FlashFeed',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.5,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black26,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
