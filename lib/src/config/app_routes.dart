import 'package:flashfeed/src/core/utils/auth_wrapper.dart';
import 'package:flashfeed/src/pages/my_news_screen.dart';
import 'package:flashfeed/src/pages/news_details_screen.dart';
import 'package:flashfeed/src/pages/create_news_screen.dart';
import 'package:flashfeed/src/pages/edit_news_screen.dart';
import 'package:flashfeed/src/pages/explore_screen.dart';
import 'package:flashfeed/src/pages/auth/forgot_password_screen.dart';
import 'package:flashfeed/src/pages/main_screen.dart';
import 'package:flashfeed/src/pages/introduction_screen.dart';
import 'package:flashfeed/src/pages/auth/login_screen.dart';
import 'package:flashfeed/src/pages/not_found_screen.dart';
import 'package:flashfeed/src/pages/profile_screen.dart';
import 'package:flashfeed/src/pages/auth/register_screen.dart';
import 'package:flashfeed/src/pages/saved_screen.dart';
import 'package:flashfeed/src/pages/splash_screen.dart';
import 'package:flashfeed/src/pages/trending_screen.dart';
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
  static const myArticles = "/myArticles";
  static const createArticle = "/createArticle";
  static const updateArticle = "/updateArticle";

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
        return MaterialPageRoute(
          builder: (_) => AuthWrapper(child: MainScreen()),
        );
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
      case myArticles:
        return MaterialPageRoute(builder: (_) => MyNewsScreen());
      case createArticle:
        return MaterialPageRoute(builder: (_) => CreateNewsScreen());
      case updateArticle:
        final articleId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => UpdateNewsScreen(articleId: articleId),
        );
      default:
        return MaterialPageRoute(builder: (_) => NotFoundScreen());
    }
  }
}
