import 'package:flashfeed/src/presentation/pages/introduction_screen.dart';
import 'package:flashfeed/src/presentation/pages/login_screen.dart';
import 'package:flashfeed/src/presentation/pages/register_screen.dart';
import 'package:flashfeed/src/presentation/pages/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const splash = '/';
  static const introduction = '/intro';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const articleDetail = '/article/:id';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case introduction:
        return MaterialPageRoute(builder: (_) => IntroductionScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
