import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizlet_clone/model/authentication/birthdate_creator.dart';

class AccountDataModel {
  String? uid;
  String? profilePic;
  BirthDateCreator? birthDate;
  String? email;
  String? username;
  String? password;

  String? accountType;

  AccountDataModel(
      {this.uid,
      this.birthDate,
      this.email,
      this.username,
      this.password,
      this.profilePic,
      this.accountType = 'student'});

  factory AccountDataModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return AccountDataModel(
      uid: data?['uid'],
      username: data?['username'],
      email: data?['email'],
      password: data?['password'],
      profilePic: data?['profilePic'],
      birthDate: BirthDateCreator.parseDateString(data?['birthDate']),
      accountType: data?['accountType'],
    );
  }

  AccountDataModel.fromJson(Map<String, dynamic> data)
      : uid = data['uid'],
        username = data['username'],
        email = data['email'],
        password = data['password'],
        profilePic = data['profilePic'],
        birthDate = BirthDateCreator.parseDateString(data['birthDate']),
        accountType = data['accountType'];

  Map<String, dynamic> toJson() {
    return {
      if (uid != null) "uid": uid,
      if (username != null) "username": username,
      if (email != null) "email": email,
      if (password != null) "password": password,
      if (profilePic != null) "profilePic": profilePic,
      if (birthDate != null) "birthDate": birthDate?.fullBirthDate(),
      if (accountType != null) "accountType": accountType,
    };
  }

  @override
  String toString() {
    return 'AccountDataModel{uid: $uid, profilePic: $profilePic, birthDate: $birthDate, email: $email, username: $username, password: $password, accountType: $accountType}';
  }
}
