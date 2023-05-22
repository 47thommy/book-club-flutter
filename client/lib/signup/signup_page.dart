import 'package:flutter/material.dart';
import 'signup.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignupForm(
        onLoginButtonPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
