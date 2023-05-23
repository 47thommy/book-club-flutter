import 'package:client/profile.dart';
import 'package:client/reading_list.dart';
import 'package:client/user/blocs/blocs.dart';
import 'package:client/user/blocs/user_bloc.dart';
import 'package:client/user/screens/screens.dart';
import 'package:client/group/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'init.dart';

final GoRouter router = GoRouter(routes: [
  GoRoute(path: '/', builder: (context, state) => const Init()),
  GoRoute(
      name: SplashScreen.routeName,
      path: '/splashscreen',
      builder: (context, state) => const SplashScreen()),
  GoRoute(
      name: LoginPage.routeName,
      path: '/login',
      builder: (context, state) => const LoginPage()),
  GoRoute(
      name: SignupPage.routeName,
      path: '/signup',
      builder: (context, state) => const SignupPage()),
  GoRoute(
      name: HomePage.routeName,
      path: '/home',
      builder: (context, state) => HomePage()),
  GoRoute(
      name: ReadingListPage.routeName,
      path: '/reading-list',
      builder: (context, state) => ReadingListPage()),
  GoRoute(
      name: ProfilePage.routeName,
      path: '/profile',
      builder: (context, state) => ProfilePage()),
]);
