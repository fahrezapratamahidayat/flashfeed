import 'dart:math' as math;

import 'package:flashfeed/src/config/app_routes.dart';
import 'package:flashfeed/src/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _mainController;
  late final AnimationController _particleController;
  late final AnimationController _pulseController;

  late final Animation<double> _logoFadeAnimation;
  late final Animation<double> _logoScaleAnimation;
  late final Animation<double> _logoRotationAnimation;
  late final Animation<double> _textSlideAnimation;
  late final Animation<double> _textFadeAnimation;
  late final Animation<double> _taglineFadeAnimation;
  late final Animation<double> _backgroundAnimation;
  late final Animation<double> _glowAnimation;
  late final Animation<double> _particleAnimation;
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    );

    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    )..repeat();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _setupAnimations();
    _initializeApp();
  }

  void _setupAnimations() {
    _backgroundAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.3, curve: Curves.easeInOut),
      ),
    );

    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.2, 0.5, curve: Curves.easeOut),
      ),
    );

    _logoScaleAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.2, 0.6, curve: Curves.elasticOut),
      ),
    );

    _logoRotationAnimation = Tween<double>(begin: -0.5, end: 0.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.2, 0.7, curve: Curves.easeOutBack),
      ),
    );

    _glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.4, 0.8, curve: Curves.easeInOut),
      ),
    );

    _textFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.5, 0.75, curve: Curves.easeOut),
      ),
    );

    _textSlideAnimation = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.5, 0.75, curve: Curves.easeOutCubic),
      ),
    );

    _taglineFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.65, 0.9, curve: Curves.easeOut),
      ),
    );

    _particleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _particleController, curve: Curves.linear),
    );

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  Future<void> _initializeApp() async {
    _mainController.forward();

    await Future.delayed(const Duration(milliseconds: 3800));

    if (mounted) {
      _mainController.stop();
      _particleController.stop();
      _pulseController.stop();
    }

    final prefs = await SharedPreferences.getInstance();
    final seenIntro = prefs.getBool('seen_intro') ?? false;
    final authToken = prefs.getString('auth_token');

    if (!mounted) return;

    if (!seenIntro) {
      Navigator.pushReplacementNamed(context, AppRoutes.introduction);
    } else if (authToken != null) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  @override
  void dispose() {
    _mainController.dispose();
    _particleController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([
          _mainController,
          _particleController,
          _pulseController,
        ]),
        builder: (context, child) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.5,
                colors: [
                  colorScheme.onSecondaryFixedVariant.withValues(alpha: 0.9),
                  colorScheme.onSecondaryFixedVariant,
                  colorScheme.onSecondaryFixedVariant.withValues(alpha: 0.8),
                  Colors.black.withValues(alpha: 0.2),
                ],
                stops: [
                  0.0,
                  0.4 * _backgroundAnimation.value,
                  0.7 * _backgroundAnimation.value,
                  1.0,
                ],
              ),
            ),
            child: Stack(
              children: [
                ...List.generate(20, (index) => _buildParticle(index, size)),
                SafeArea(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildAnimatedLogo(colorScheme),
                        SizedBox(height: 32 * _logoScaleAnimation.value),
                        _buildAnimatedText(theme),
                        SizedBox(height: 16 * _textFadeAnimation.value),
                        SizedBox(height: 80 * _taglineFadeAnimation.value),
                        _buildLoadingIndicator(colorScheme),
                      ],
                    ),
                  ),
                ),
                _buildGlowOverlay(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildParticle(int index, Size size) {
    final random = math.Random(index);
    final startX = random.nextDouble() * size.width;
    final startY = random.nextDouble() * size.height;
    final endX = startX + (random.nextDouble() - 0.5) * 100;
    final endY = startY - random.nextDouble() * 200;

    final currentX = startX + (endX - startX) * _particleAnimation.value;
    final currentY = startY + (endY - startY) * _particleAnimation.value;

    return Positioned(
      left: currentX,
      top: currentY,
      child: Opacity(
        opacity: (0.3 * (1 - _particleAnimation.value)).clamp(0.0, 1.0),
        child: Container(
          width: random.nextDouble() * 4 + 1,
          height: random.nextDouble() * 4 + 1,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.6),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.white.withValues(alpha: 0.3),
                blurRadius: 2,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedLogo(ColorScheme colorScheme) {
    return Transform.rotate(
      angle: _logoRotationAnimation.value,
      child: Transform.scale(
        scale: _logoScaleAnimation.value * _pulseAnimation.value,
        child: FadeTransition(
          opacity: _logoFadeAnimation,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ...List.generate(
                3,
                (index) => Container(
                  width: 140 + (index * 25),
                  height: 140 + (index * 25),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(
                        alpha: 0.1 - (index * 0.03),
                      ),
                      width: 2,
                    ),
                  ),
                ),
              ),
              Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [Colors.white, Colors.grey.shade50, Colors.white],
                    stops: const [0.0, 0.7, 1.0],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 30 * _glowAnimation.value,
                      spreadRadius: 10 * _glowAnimation.value,
                      offset: const Offset(0, 15),
                    ),
                    BoxShadow(
                      color: colorScheme.primary.withValues(alpha: 0.4),
                      blurRadius: 50 * _glowAnimation.value,
                      spreadRadius: 20 * _glowAnimation.value,
                      offset: const Offset(0, 0),
                    ),
                    BoxShadow(
                      color: Colors.white.withValues(alpha: 0.8),
                      blurRadius: 15,
                      spreadRadius: -5,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white,
                        Colors.grey.shade100,
                        Colors.white,
                      ],
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.flash_on,
                      color: colorScheme.primary,
                      size: 100,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedText(ThemeData theme) {
    return Transform.translate(
      offset: Offset(0, _textSlideAnimation.value),
      child: FadeTransition(
        opacity: _textFadeAnimation,
        child: Text(
          'FlashFeed',
          style: theme.textTheme.displayMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            letterSpacing: 2.0,
            fontSize: 42,
            shadows: [
              Shadow(
                blurRadius: 15.0,
                color: Colors.black.withValues(alpha: 0.3),
                offset: const Offset(0, 4),
              ),
              Shadow(
                blurRadius: 30.0,
                color: Colors.black.withValues(alpha: 0.1),
                offset: const Offset(0, 8),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator(ColorScheme colorScheme) {
    return FadeTransition(
      opacity: _taglineFadeAnimation,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 35,
                  height: 35,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      colorScheme.primary,
                    ),
                    strokeWidth: 3,
                    strokeCap: StrokeCap.round,
                  ),
                ),
              ],
            ),
          ),
          Transform.scale(
            scale: _pulseAnimation.value,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: colorScheme.onSecondaryFixed,
                  width: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlowOverlay() {
    return Positioned.fill(
      child: FadeTransition(
        opacity: _glowAnimation,
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 0.5,
              colors: [
                Colors.white.withValues(alpha: 0.05),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
