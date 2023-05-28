import 'package:client/application/signup/signup_bloc.dart';
import 'package:client/application/signup/signup_state.dart';
import 'package:client/presentation/pages/common/snackbar.dart';
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
            showSuccess(context, "Creating your account...");
          } else if (state is SignupFailure) {
            showFailure(context, state.error.toString());
          }
        },
        child: const Scaffold(
          body: SignupForm(),
        ));
  }
}
