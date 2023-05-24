import 'package:flutter/material.dart';
import 'package:client/user/screens/signup/signup_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:client/user/blocs/blocs.dart';
import 'login_form.dart';

class LoginPage extends StatelessWidget {
  static const routeName = "login";

  const LoginPage({super.key}); 

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(listener: (context, state) {
      if (state is UserAuthenticated) {
        context.goNamed("home");
      } else if (state is UserOperationFailure) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Invalid credentials.",
                style: TextStyle(color: Theme.of(context).colorScheme.error))));
      }
    }, child: Scaffold(
      body: LoginForm(
        onSignupButtonPressed: () {
          context.goNamed(SignupPage.routeName);
        },
      ),
    ));
  }
}
