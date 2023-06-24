import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:up2date/components/textfield.dart';
import 'package:up2date/components/button.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  void showErrrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Center(
              child: Text(
            message,
            style: const TextStyle(color: Colors.white),
          )),
        );
      },
    );
  }

  final emailController = TextEditingController();
  Future SendResetEmail() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      showErrrorMessage("Password Reset link sent !");
      print("hey boi");
    } on FirebaseAuthException catch (e) {
      showErrrorMessage(e.message.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.grey[700]),
      backgroundColor: Colors.grey[300],
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Enter your email and we will send you a password reset link",
                style: TextStyle(color: Colors.grey[700], fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              MyTextField(
                controller: emailController,
                obscureText: false,
                hintText: "Email",
              ),
              const SizedBox(
                height: 20,
              ),
              MyButton(onTap: SendResetEmail, message: "Reset Password")
            ]),
          ),
        ),
      ),
    );
  }
}
