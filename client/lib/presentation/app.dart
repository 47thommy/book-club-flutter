import 'package:client/application/auth/auth.dart';
import 'package:client/application/file/file_bloc.dart';
import 'package:client/application/login/login.dart';
import 'package:client/application/signup/signup.dart';
import 'package:client/presentation/pages/group/group.dart';
import 'package:client/presentation/pages/login/login_screen.dart';
import 'package:client/presentation/pages/signup/signup_screen.dart';
import 'package:client/presentation/pages/splash/splash_screen.dart';
import 'package:client/infrastructure/user/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final userRepository = context.read<UserRepository>();
    final authBloc = context.read<AuthenticationBloc>();

    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
      if (state is Authenticated) {
        context.goNamed(GroupsScreen.routeName);
      }
    }, builder: (context, state) {
      if (state is AuthenticationUninitialized) {
        return const SplashScreen();
      } else if (state is SignupPageLoad) {
        return BlocProvider(
            create: (context) => LoginBloc(
                userRepository: userRepository, authenticationBloc: authBloc),
            child: BlocProvider(
                create: (context) {
                  return SignupBloc(
                      userRepository: userRepository,
                      loginBloc: context.read<LoginBloc>());
                },
                child: const SignupPage()));
      } else if (state is Unauthenticated || state is LoginPageLoad) {
        return BlocProvider(
            create: (context) => LoginBloc(
                userRepository: userRepository, authenticationBloc: authBloc),
            child: const LoginPage());
      }

      return const SplashScreen();
    });
  }
}

class Home extends StatefulWidget {
  const Home({super.key, required this.child});

  final Widget child;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _calculateSelectedIndex(context),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: onTap,
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.black45,
            icon: Icon(Icons.group),
            label: 'Groups',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black45,
            icon: Icon(Icons.meeting_room),
            label: 'Meetings',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black45,
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black45,
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouter.of(context).location;
    // if (location.endsWith(HomePage.routeName)) {
    //   return 0;
    // }
    // if (location.endsWith(ReadingListPage.routeName)) {
    //   return 1;
    // }
    // if (location.endsWith(GroupDetailPage.routeName)) {
    //   return 2;
    // }
    // if (location.endsWith(ProfilePage.routeName)) {
    //   return 3;
    // }
    return 0;
  }

  void onTap(int value) {
    print(value);
    switch (value) {
      case 0:
        return context.goNamed(GroupsScreen.routeName);
      // case 1:
      //   return context.goNamed(ReadingListPage.routeName);
      // case 2:
      //   return context.goNamed(GroupDetailPage.routeName);
      case 3:
        return context.go("/");
      default:
        return context.goNamed("sample");
    }
  }
}
