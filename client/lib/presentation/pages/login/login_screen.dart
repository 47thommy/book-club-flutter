import 'package:client/application/login/login_bloc.dart';
import 'package:client/application/login/login_state.dart';
import 'package:client/presentation/pages/common/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_form.dart';

class LoginPage extends StatelessWidget {
  static const routeName = "login";

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            showSuccess(context, "Logging in...");
          } else if (state is LoginFailure) {
            showFailure(context, state.error.toString());
          }
        },
        child: const Scaffold(body: LoginForm()));
  }
}
