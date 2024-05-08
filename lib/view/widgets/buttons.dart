import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:quizlet_clone/model/authentication/birthdate_creator.dart';
import 'package:quizlet_clone/repository/authentication/auth_repo.dart';
import 'package:quizlet_clone/view/widgets/texts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/providers/user_data_provider.dart';
import '../../model/authentication/account_data.dart';

Widget googleFullWidthButton(BuildContext context) {
  return MaterialButton(
    onPressed: () async {
      final authRepo = AuthenticationRepository();
      final UserCredential credential = await authRepo.signInWithGoogle();
      AccountDataModel userData = AccountDataModel(
        uid: credential.user!.uid,
        email: credential.user!.email,
        username: credential.user!.displayName,
        // birthDate: credential.user!.,
        profilePic: credential.user!.photoURL,
      );
      authRepo.storeUserData(userData);
      Provider.of<UserDataProvider>(context, listen: false).setUserData(userData);
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('logged', true);
      prefs.setString('userData', json.encode(userData.toJson()));
      Navigator.pushReplacementNamed(
        context,
        '/home',
        arguments: {
          'accountData': userData, // Pass your data here
        },
      );
    },
    minWidth: double.infinity,
    height: 50,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide(width: 2, color: Color(0x80a2a2a2)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/icons/google_icon.svg', width: 25, height: 25,),
        SizedBox(width: 10,),
        semiBoldText('Log in with Google', size: 14, color: const Color(0xff586380)),
      ],
    ),
  );
}

Widget filledFullWidthButton({required Function() onPressed, required Widget child, Color color = const Color(0xff4255FF)}) {
  return MaterialButton(
    onPressed: onPressed,
    minWidth: double.infinity,
    height: 50,
    color: color,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    child: child,
  );
}

Widget outlinedFullWidthButton({required Function() onPressed, required Widget child, Color color = const Color(0xff4255FF)}) {
  return MaterialButton(
    onPressed: onPressed,
    minWidth: double.infinity,
    height: 50,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide(width: 2, color: Color(0x80a2a2a2)),
    ),
    child: child,
  );
}