import 'package:client/app_scaffold.dart';
import 'package:client/group/screens/group_details.dart';
import 'package:client/profile.dart';
import 'package:client/reading_list.dart';
import 'package:client/user/screens/screens.dart';
import 'package:client/group/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(navigatorKey: _rootNavigatorKey, routes: [
  GoRoute(
      name: SplashScreen.routeName,
      path: '/',
      builder: (context, state) => const SplashScreen()),
  GoRoute(
      name: LoginPage.routeName,
      path: '/${LoginPage.routeName}',
      builder: (context, state) => const LoginPage()),
  GoRoute(
      name: SignupPage.routeName,
      path: '/${SignupPage.routeName}',
      builder: (context, state) => const SignupPage()),
  GoRoute(
    name: GroupDetailPage.routeName,
    path: '/${GroupDetailPage.routeName}',
    builder: (context, state) => const GroupDetailPage(),
  ),
  ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => AppScaffold(child: child),
      routes: [
        GoRoute(
            name: HomePage.routeName,
            path: '/${HomePage.routeName}',
            builder: (context, state) => const HomePage()),
        GoRoute(
            name: ReadingListPage.routeName,
            path: '/${ReadingListPage.routeName}',
            builder: (context, state) => const ReadingListPage()),
        GoRoute(
            name: ProfilePage.routeName,
            path: '/${ProfilePage.routeName}',
            builder: (context, state) => ProfilePage()),
      ])
]);
