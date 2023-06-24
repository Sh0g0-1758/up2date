import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:up2date/mainPage/mainPage.dart';
import 'package:up2date/login/login.dart';
import 'package:up2date/signup/signup.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MainPage(
              Title: "Home",
            );
          } else {
            if (showLoginPage) {
              return LoginPage(
                onTap: togglePages,
              );
            } else {
              return SignUpPage(
                onTap: togglePages,
              );
            }
          }
        },
      ),
    );
  }
}
