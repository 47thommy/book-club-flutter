import 'package:client/user/screens/screens.dart';
import 'package:client/user/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Init extends StatelessWidget {
  const Init({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(listener: (context, state) {
      if (state is UserLoading) {
        context.goNamed(SplashScreen.routeName);
      } else if (state is UserUnauthenticated) {
        context.goNamed(LoginPage.routeName);
      } else if (state is UserAuthenticated) {
        context.goNamed("home");
      }
    }, builder: (context, state) {
      BlocProvider.of<UserBloc>(context).add(const UserLoad());
      return const SplashScreen();
    });
  }
}
