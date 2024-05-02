import 'package:flutter/material.dart';
import 'package:quizlet_clone/view/intro/intro_page.dart';
import 'package:quizlet_clone/view/splash/splash_screen.dart';

import '../view/home/home_page.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/splash':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/intro':
        return MaterialPageRoute(builder: (_) => const IntroPage());
      case '/home':
      // Extracting arguments from settings
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => HomePage(accountData: args['accountData']),
        );
      default:
      // If route not found, navigate to intro page
        return null;
    }
  }
}