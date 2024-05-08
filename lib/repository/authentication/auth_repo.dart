import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quizlet_clone/model/authentication/account_data.dart';

class AuthenticationRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  ///========================= LOGIN =========================
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<AccountDataModel?> getUserData(String userId) async {
    final ref = _db.collection("users").doc(userId).withConverter(
          fromFirestore: AccountDataModel.fromFirestore,
          toFirestore: (AccountDataModel accountData, _) =>
              accountData.toJson(),
        );
    final docSnap = await ref.get();
    return docSnap.data();
  }

  /// ==================================================

  ///========================= REGISTRATION =========================
  Future<UserCredential> createUserWithEmailAndPassword(String email, String password) async {
    return _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> storeUserData(AccountDataModel accountData) async {
    try {
      final userDocRef = _db.collection("users").doc(accountData.uid);
      await userDocRef.set(accountData.toJson());
      print("Document ${accountData.uid} successfully created!");
    } catch (error) {
      print("Failed to create document: $error");
    }
  }
  ///==================================================
}
