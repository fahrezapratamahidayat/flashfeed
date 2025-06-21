import 'package:flashfeed/src/config/app_routes.dart';
import 'package:flashfeed/src/widgets/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  late AnimationController _fadeController;
  int _currentPage = 0;

  final List<IntroPageData> _pages = [
    IntroPageData(
      image:
          'https://images.unsplash.com/photo-1504711434969-e33886168f5c?q=80&w=1470&auto=format&fit=crop',
      title: 'Breaking News',
      description: 'Real-time updates from trusted sources worldwide',
      primaryColor: Color(0xFF6366F1),
    ),
    IntroPageData(
      image:
          'https://images.unsplash.com/photo-1432888622747-4eb9a8efeb07?q=80&w=1474&auto=format&fit=crop',
      title: 'Personal Feed',
      description: 'Smart recommendations tailored to your interests',
      primaryColor: Color(0xFFEC4899),
    ),
    IntroPageData(
      image:
          'https://images.unsplash.com/photo-1611224923853-80b023f02d71?q=80&w=1439&auto=format&fit=crop',
      title: 'Instant Alerts',
      description: 'Push notifications for stories that matter most',
      primaryColor: Color(0xFF06B6D4),
    ),
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
    );

    _fadeController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  Future<void> _completeIntroduction() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seen_intro', true);

    if (mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeIntroduction();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
              _fadeController.reset();
              _fadeController.forward();
            },
            itemCount: _pages.length,
            itemBuilder: (context, index) {
              return IntroPageWidget(
                data: _pages[index],
                fadeAnimation: _fadeController,
              );
            },
          ),
          _buildBottomContent(colorScheme),
        ],
      ),
    );
  }

  Widget _buildBottomContent(ColorScheme colorScheme) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withValues(alpha: 0.7),
              Colors.black,
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildContentCard(),
              SizedBox(height: 24),
              _buildActionButton(colorScheme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContentCard() {
    return FadeTransition(
      opacity: _fadeController,
      child: Column(
        children: [
          SizedBox(height: 24),
          Text(
            _pages[_currentPage].title,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Text(
            _pages[_currentPage].description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withValues(alpha: 0.8),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(ColorScheme colorScheme) {
    final isLastPage = _currentPage == _pages.length - 1;

    return GestureDetector(
      onTap: _nextPage,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isLastPage ? 'Get Started' : 'Continue',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 8),
            Icon(
              isLastPage ? Icons.check : Icons.arrow_forward,
              color: Colors.white,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class IntroPageData {
  final String image;
  final String title;
  final String description;
  final Color primaryColor;

  IntroPageData({
    required this.image,
    required this.title,
    required this.description,
    required this.primaryColor,
  });
}

class IntroPageWidget extends StatelessWidget {
  final IntroPageData data;
  final AnimationController fadeAnimation;

  const IntroPageWidget({
    super.key,
    required this.data,
    required this.fadeAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        FadeTransition(
          opacity: fadeAnimation,
          child: CachedNetworkImageWrapper(
            imageUrl: data.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.3),
                Colors.black.withValues(alpha: 0.7),
              ],
              stops: [0.0, 1.0],
            ),
          ),
        ),
      ],
    );
  }
}
