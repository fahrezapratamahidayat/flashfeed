import 'package:flashfeed/src/config/app_routes.dart';
import 'package:flashfeed/src/core/services/auth_service.dart';
import 'package:flashfeed/src/presentation/widgets/intro_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _completeIntroduction() async {
    // Set flag bahwa user sudah melihat introduction
    await SharedPreferences.getInstance().then(
      (prefs) => prefs.setBool('seen_intro', true),
    );

    // Navigasi ke login atau langsung ke home jika ada auto-login
    if (await AuthService.hasCredentials()) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              IntroPage(
                title: "Welcome to News App",
                description: "Get the latest news updates",
                image: 'assets/images/intro1.png',
              ),
              IntroPage(
                title: "Customize Your Feed",
                description: "Choose your favorite categories",
                image: 'assets/images/intro2.png',
              ),
              IntroPage(
                title: "Stay Updated",
                description: "Real-time notifications",
                image: 'assets/images/intro3.png',
              ),
            ],
          ),

          Positioned(
            bottom: 40,
            right: 20,
            child: _currentPage == 2
                ? ElevatedButton(
                    onPressed: _completeIntroduction,
                    child: Text("Get Started"),
                  )
                : TextButton(
                    onPressed: () {
                      _pageController.animateToPage(
                        2,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    child: Text("Skip"),
                  ),
          ),
        ],
      ),
    );
  }
}
