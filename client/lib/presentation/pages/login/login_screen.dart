import 'package:client/application/login/login_bloc.dart';
import 'package:client/application/login/login_state.dart';
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
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Logging in...",
                    style: TextStyle(color: Colors.green))));
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.error.message,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.error))));
          }
        },
        child: const Scaffold(body: LoginForm()));
  }
}
