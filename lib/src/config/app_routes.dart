import 'package:flashfeed/src/presentation/pages/articel_detail_screen.dart';
import 'package:flashfeed/src/presentation/pages/explore_screen.dart';
import 'package:flashfeed/src/presentation/pages/forgot_password_screen.dart';
import 'package:flashfeed/src/presentation/pages/home_screen.dart';
import 'package:flashfeed/src/presentation/pages/introduction_screen.dart';
import 'package:flashfeed/src/presentation/pages/login_screen.dart';
import 'package:flashfeed/src/presentation/pages/not_found_screen.dart';
import 'package:flashfeed/src/presentation/pages/profile_screen.dart';
import 'package:flashfeed/src/presentation/pages/register_screen.dart';
import 'package:flashfeed/src/presentation/pages/saved_screen.dart';
import 'package:flashfeed/src/presentation/pages/splash_screen.dart';
import 'package:flashfeed/src/presentation/pages/trending_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const splash = '/';
  static const introduction = '/intro';
  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = 'forgotPassword';
  static const home = '/home';
  static const articleDetail = '/article/:id';
  static const profile = '/profile';
  static const explore = '/explore';
  static const trending = '/trending';
  static const saved = '/saved';

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
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case articleDetail:
        final articleId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => ArticleDetailPage(articleId: articleId),
        );
      case profile:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case explore:
        return MaterialPageRoute(builder: (_) => ExploreScreen());
      case trending:
        return MaterialPageRoute(builder: (_) => TrendingScreen());
      case saved:
        return MaterialPageRoute(builder: (_) => SavedScreen());

      default:
        return MaterialPageRoute(builder: (_) => NotFoundScreen());
    }
  }
}
