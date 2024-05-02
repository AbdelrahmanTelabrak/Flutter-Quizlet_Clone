import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'common/router.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ChangeNotifier();
    return MaterialApp(
      initialRoute: '/splash',
      onGenerateRoute: AppRouter.generateRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins'
      ),
      // home: const IntroPage(),
    );
  }
}

class LoginPageTest extends StatefulWidget {
  @override
  _LoginPageTestState createState() => _LoginPageTestState();
}

class _LoginPageTestState extends State<LoginPageTest> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              SizedBox(height: 20.0),
              MaterialButton(
                onPressed: () async {
                  // Perform login functionality here
                  String username = _usernameController.text;
                  String password = _passwordController.text;
                  // For demonstration, simply print the credentials
                  print('Username: $username');
                  print('Password: $password');
                  try {
                    final credential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: username,
                      password: password,
                    );
                    print('Token id: ${credential.user!.getIdToken()}');
                    String? userId  = await credential.user!.getIdToken();
                    print('User Token: ${userId}');
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text('Register'),
              ),
              MaterialButton(
                onPressed: () async {
                  // Perform login functionality here
                  String username = _usernameController.text;
                  String password = _passwordController.text;
                  // For demonstration, simply print the credentials
                  print('Username: $username');
                  print('Password: $password');
                  try {
                    final credential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: username, password: password);
                    String? userId  = credential.user!.uid;
                    print('User Token: ${userId}');
                    print('Logged in Successfully');
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      print('No user found for that email.');
                    } else if (e.code == 'wrong-password') {
                      print('Wrong password provided for that user.');
                    }
                  }
                },
                child: Text('Login'),
              ),
              MaterialButton(
                onPressed: () async {
                  // Perform login functionality here
                  String username = _usernameController.text;
                  String password = _passwordController.text;
                  // For demonstration, simply print the credentials
                  print('Username: $username');
                  print('Password: $password');
                  await FirebaseAuth.instance.signOut();
                },
                child: Text('SignOut'),
              ),
              MaterialButton(
                onPressed: () async {
                  // Perform login functionality here
                  String username = _usernameController.text;
                  String password = _passwordController.text;

                  final user = <String, dynamic>{
                    "email": username,
                    "last": password,
                  };
                  final db = FirebaseFirestore.instance;
                  // Add a new document with a generated ID
                  db.collection("users").add(user).then(
                      (DocumentReference doc) =>
                          print('DocumentSnapshot added with ID: ${doc.id}'));
                },
                child: Text('FireStore'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
