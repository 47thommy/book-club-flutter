import 'package:client/presentation/app.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:client/presentation/pages/group/group.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(navigatorKey: _rootNavigatorKey, routes: [
  GoRoute(path: '/', builder: (context, state) => const AppScaffold()),
  ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => Home(child: child),
      routes: [
        GoRoute(
            name: GroupsScreen.routeName,
            path: '/${GroupsScreen.routeName}',
            builder: (context, state) => const GroupsScreen()),
        GoRoute(
            name: GroupDetailScreen.routeName,
            path: '/${GroupDetailScreen.routeName}/:gid',
            builder: (context, state) {
              final groupId = int.parse(state.pathParameters['gid']!);
              return GroupDetailScreen(gid: groupId);
            }),
      ]),
]);
