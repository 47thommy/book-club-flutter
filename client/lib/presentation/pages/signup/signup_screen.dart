import 'package:client/application/signup/signup_bloc.dart';
import 'package:client/application/signup/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'signup_form.dart';

class SignupPage extends StatelessWidget {
  static const routeName = "signup";

  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state is SignupLoading) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Creating your account...",
                    style: TextStyle(color: Colors.green))));
          } else if (state is SignupFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.error.message,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.error))));
          }
        },
        child: const Scaffold(
          body: SignupForm(),
        ));
  }
}
