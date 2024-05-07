import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizlet_clone/common/providers/user_data_provider.dart';
import 'package:quizlet_clone/model/authentication/login_data.dart';
import 'package:quizlet_clone/view/widgets/commons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../repository/authentication/auth_repo.dart';

class LoginViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final LoginData loginData = LoginData();
  final AuthenticationRepository _repository = AuthenticationRepository();

  Future<void> login(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(mainSnackBar('Processing Data...'));
      try {
        final UserCredential credential = await _repository
            .signInWithEmailAndPassword(loginData.email!, loginData.password!);
        final accountData = await _repository.getUserData(credential.user!.uid);
        if (accountData != null) {
          Provider.of<UserDataProvider>(context, listen: false).setUserData(accountData);
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool('logged', true);
          prefs.setString('userData', json.encode(accountData.toJson()));
          Navigator.pushReplacementNamed(
            context,
            '/home',
            arguments: {
              'accountData': accountData, // Pass your data here
            },
          );
        } else {
          // Handle null account data
          ScaffoldMessenger.of(context)
              .showSnackBar(mainSnackBar('This User is not available...'));
        }
      } on FirebaseAuthException catch (e) {
        // Handle authentication exceptions
        _handleAuthException(context, e);
      } catch (e) {
        print(e);
      }
    }
  }

  void _handleAuthException(BuildContext context, FirebaseAuthException e) {
    String errorMessage = 'An error occurred';
    if (e.code == 'user-not-found') {
      errorMessage = 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
      errorMessage = 'Wrong password provided for that user.';
    }
    ScaffoldMessenger.of(context).showSnackBar(mainSnackBar(errorMessage));
  }

  void updateEmail(String email) {
    loginData.email = email;
    notifyListeners();
  }

  void updatePassword(String password) {
    loginData.password = password;
    notifyListeners();
  }

  String? validateEmail(dynamic value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else {
      String pattern = r'^[\w-\.]+@([\w-]+\.)[\w-]{2,4}$';
      RegExp regex = RegExp(pattern);
      if (!regex.hasMatch(value)) {
        return 'Incorrect email format..';
      }
      return null;
    }
  }

  String? validatePassword(dynamic value) {
    if (value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 8) {
      return 'Password should be at least 8 characters long';
    }
    return null;
  }
}
