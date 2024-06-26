import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quizlet_clone/common/providers/user_data_provider.dart';
import 'package:quizlet_clone/model/authentication/account_data.dart';
import 'package:quizlet_clone/view/intro/intro_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(milliseconds: 1500), () => _initializeObject());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Image.asset('assets/images/app_logo.png'),
        ),
      ),
    );
  }

  Future<void> _initializeObject() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('logged') == null || !prefs.getBool('logged')!) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => IntroPage(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    } else {
      final userData = prefs.getString('userData');
      print('Stored User data: \n ${json.decode(userData!)}');
      final accountData = AccountDataModel.fromJson(json.decode(userData));
      // accountData.username = 'Abdelrahman Elabrak';
      Provider.of<UserDataProvider>(context, listen: false).setUserData(accountData);
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => HomePage(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    }
  }
}
