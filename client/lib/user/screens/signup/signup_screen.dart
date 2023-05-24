import 'package:client/user/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../login/login_screen.dart';
import 'signup_form.dart';

class SignupPage extends StatelessWidget {
  static const routeName = "signup";

  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(listener: (context, state) {
      if (state is UserCreated) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Account created successfully!",
                style: TextStyle(color: Colors.green))));
      } else if (state is UserOperationFailure) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.error.toString(),
                style: TextStyle(color: Theme.of(context).colorScheme.error))));
      }
    }, child: Scaffold(
      body: SignupForm(
        onLoginButtonPressed: () {
          context.goNamed(LoginPage.routeName);
        },
      ),
    ));
  }
}
