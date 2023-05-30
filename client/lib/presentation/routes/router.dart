import 'package:client/infrastructure/role/dto/role_dto.dart';
import 'package:client/presentation/app.dart';
import 'package:client/presentation/roles_permissions/role_detail.dart';
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
            name: GroupDetailPage.routeName,
            path: '/${GroupDetailPage.routeName}/:gid',
            builder: (context, state) {
              final groupId = int.parse(state.pathParameters['gid']!);
              return GroupDetailPage(gid: groupId);
            }),
        GoRoute(
            name: GroupEditPage.routeName,
            path: '/${GroupEditPage.routeName}/:gid',
            builder: (context, state) {
              final groupId = int.parse(state.pathParameters['gid']!);
              return GroupEditPage(gid: groupId);
            }),
        GoRoute(
            name: RoleDetailPage.routeName,
            path: '/${RoleDetailPage.routeName}',
            builder: (context, state) {
              final role = state.extra as RoleDto;
              return RoleDetailPage(role);
            }),
      ]),
]);
