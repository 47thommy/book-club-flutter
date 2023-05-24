import 'package:client/group/blocs/blocs.dart';
import 'package:client/group/screens/groups_screen.dart';
import 'package:client/user/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:client/user/screens/screens.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = "splashscreen";

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserUnauthenticated) {
            context.goNamed(LoginPage.routeName);
          } else if (state is UserAuthenticated) {
            context.read<GroupBloc>().add(GroupLoad(state.user.token!));
            context.goNamed(HomePage.routeName);
          }
        },
        child: Scaffold(
          body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                Image.asset("assets/logo/logo.png"),
                const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Book club",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    )),
              ])),
        ));
  }
}
