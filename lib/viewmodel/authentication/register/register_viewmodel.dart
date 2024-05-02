import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizlet_clone/model/authentication/birthdate_creator.dart';
import 'package:quizlet_clone/model/authentication/account_data.dart';
import 'package:quizlet_clone/view/widgets/commons.dart';

import '../../../repository/authentication/auth_repo.dart';

class RegisterViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final AccountDataModel accountData = AccountDataModel();
  final BirthDateCreator birthDate = BirthDateCreator();

  bool isTeacher = false;
  final AuthenticationRepository _repository = AuthenticationRepository();

  Future<void> register(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(mainSnackBar('Processing Data'));
      // Check if the user is a teacher
      if (isTeacher) {
        accountData.accountType = 'teacher';
      }
      accountData.birthDate = birthDate;

      try {
        // Creates a new User in the system
        final credential = await _repository.createUserWithEmailAndPassword(
            accountData.email!, accountData.password!);
        accountData.uid = credential.user!.uid;
        // Store the user's data in FireStore
        await _repository.storeUserData(accountData);
        Navigator.pushReplacementNamed(
          context,
          '/home',
          arguments: {
            'accountData': accountData, // Pass your data here
          },
        );
      } on FirebaseAuthException catch (e) {
        _handleAuthException(e);
      } catch (e) {
        print(e);
      }
    }
  }

  void _handleAuthException(FirebaseAuthException e) {
    if (e.code == 'weak-password') {
      mainSnackBar('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      mainSnackBar('The account already exists for that email.');
    }
  }

  void changeType() {
    isTeacher = !isTeacher;
  }

  void updateEmail(String email) {
    accountData.email = email;
    notifyListeners();
  }

  void updateUsername(String username) {
    accountData.username = username;
    notifyListeners();
  }

  void updatePassword(String password) {
    accountData.password = password;
    notifyListeners();
  }

  void updateMonth(String? month) {
    birthDate.month = month;
    notifyListeners();
  }

  void updateDay(String? day) {
    birthDate.day = day;
    notifyListeners();
  }

  void updateYear(String? year) {
    birthDate.year = year;
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

  String? validateUsername(dynamic value) {
    if (value.isEmpty) {
      return 'Please enter your username';
    }
    return null;
  }

  String? validateMonth(dynamic value) {
    if (value == null || value.isEmpty) {
      return '*';
    }
    return null;
  }

  String? validateDay(dynamic value) {
    if (value == null || value.isEmpty) {
      return '*';
    }
    return null;
  }

  String? validateYear(dynamic value) {
    if (value == null || value.isEmpty) {
      return '*';
    }
    return null;
  }
}
