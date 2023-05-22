import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../login/login_screen.dart';
import 'signup_form.dart';

class SignupPage extends StatelessWidget {
  static const routeName = "signup";

  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignupForm(
        onLoginButtonPressed: () {
          context.goNamed(LoginPage.routeName);
        },
      ),
    );
  }
}
