import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:quizlet_clone/common/shared_preference/quizes_sp.dart';
import 'package:quizlet_clone/common/shared_preference/user_data_sp.dart';
import 'package:quizlet_clone/model/authentication/account_data.dart';

class UserDataProvider extends ChangeNotifier {

  AccountDataModel? accountData;

  void setUserData(AccountDataModel data){
    accountData = data;
  }
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    await UserSharedPreferences.removeAccountData();
    await MenuQuizzesSharedPreferences.removeSavedQuizzes();
    Navigator.pushReplacementNamed(context, '/intro');
  }
}