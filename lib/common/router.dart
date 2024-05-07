import 'package:flutter/material.dart';
import 'package:quizlet_clone/view/intro/intro_page.dart';
import 'package:quizlet_clone/view/quiz/quiz_page.dart';
import 'package:quizlet_clone/view/splash/splash_screen.dart';

import '../view/home/home_page.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/splash':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/intro':
        return MaterialPageRoute(builder: (_) => const IntroPage());
      case 'quiz_page':
      // Extracting arguments from settings
        final args = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => QuizPage(quizId: args),
        );
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomePage());
      default:
      // If route not found, navigate to intro page
        return null;
    }
  }
}