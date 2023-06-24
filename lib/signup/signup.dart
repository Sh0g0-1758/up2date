import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:up2date/components/textfield.dart';
import 'package:up2date/components/button.dart';
import 'package:up2date/auth/google.dart';

class SignUpPage extends StatefulWidget {
  final Function()? onTap;
  const SignUpPage({super.key, required this.onTap});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  void signUserUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      if (passwordController.text == passwordConfirmController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
        showErrrorMessage("Passwords don't match");
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == "email-already-in-use") {
        showErrrorMessage("This email already exists, try signing In");
      } else if (e.code == "invalid-password") {
        showErrrorMessage("Please enter a password of at least 6 characters");
      } else if (e.code == "invalid-email") {
        showErrrorMessage("Pls enter a valid Email address");
      } else if (e.code == "weak-password") {
        showErrrorMessage(
            "Please enter a strong password of at least 6 characters");
      } else {
        showErrrorMessage(e.message.toString());
      }
    }
  }

  void showErrrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Center(
              child: Text(
            message,
            style: TextStyle(color: Colors.white),
          )),
        );
      },
    );
  }

  void GoogleSignIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    await Authservice().signInWithGoogle();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const Icon(
                    Icons.lock,
                    size: 100,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "up2date",
                    style: TextStyle(color: Colors.grey[700], fontSize: 50),
                  ),
                  const SizedBox(height: 25),
                  MyTextField(
                    controller: emailController,
                    obscureText: false,
                    hintText: "Email",
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: passwordController,
                    obscureText: true,
                    hintText: "Password",
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: passwordConfirmController,
                    obscureText: true,
                    hintText: "Confirm Your Password",
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 47),
                  MyButton(
                    onTap: signUserUp,
                    message: "Sign UP",
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        )),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            "or continue with",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                        Expanded(
                            child: Divider(
                          thickness: 1.0,
                          color: Colors.grey[400],
                        ))
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                      onTap: GoogleSignIn,
                      child: Image.asset(
                        'lib/images/google.png',
                        height: 72,
                      )),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account ?"),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          "Login now",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        resizeToAvoidBottomInset: false);
  }
}
