import 'package:flutter/material.dart';
import 'package:client/signup/signup_page.dart';
import 'login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginForm(
        onSignupButtonPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignupPage()),
          );
        },
      ),
    );
  }
}
