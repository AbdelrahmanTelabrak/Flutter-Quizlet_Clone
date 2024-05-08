import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/authentication/account_data.dart';

class UserSharedPreferences {
  static const String _keyAccountData = 'userData';
  static bool _logged = false;

  static Future<void> saveAccountData(AccountDataModel accountData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonData = jsonEncode(accountData.toJson());
    await prefs.setString(_keyAccountData, jsonData);
    await prefs.setBool('logged', true);
    _logged = true;
  }

  static Future<AccountDataModel?> getAccountData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString(_keyAccountData);
    if (jsonData != null) {
      final Map<String, dynamic> decodedData = jsonDecode(jsonData);
      return AccountDataModel.fromJson(decodedData);
    }
    return null;
  }

  static Future<void> removeAccountData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyAccountData);
    await prefs.setBool('logged', false);
    _logged = false;
  }
}
