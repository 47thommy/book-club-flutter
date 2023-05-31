import 'package:client/infrastructure/role/dto/role_dto.dart';
import 'package:client/presentation/app.dart';
import 'package:client/presentation/pages/profile/profile.dart';
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
        //
        // Profile screen
        GoRoute(
            name: ProfilePage.routeName,
            path: '/${ProfilePage.routeName}',
            builder: (context, state) => const ProfilePage()),

        //
        // Groups screen
        GoRoute(
            name: GroupsScreen.routeName,
            path: '/${GroupsScreen.routeName}',
            builder: (context, state) => const GroupsScreen()),

        //
        // Group detail screen
        GoRoute(
            name: GroupDetailPage.routeName,
            path: '/${GroupDetailPage.routeName}/:gid',
            builder: (context, state) {
              final groupId = int.parse(state.pathParameters['gid']!);
              return GroupDetailPage(gid: groupId);
            }),

        //
        // Group setting screen
        GoRoute(
            name: GroupEditPage.routeName,
            path: '/${GroupEditPage.routeName}/:gid',
            builder: (context, state) {
              final groupId = int.parse(state.pathParameters['gid']!);
              return GroupEditPage(gid: groupId);
            }),

        //
        // Role edit screen
        GoRoute(
            name: RoleDetailPage.routeName,
            path: '/${RoleDetailPage.routeName}/:gid',
            builder: (context, state) {
              final role = state.extra as RoleDto;
              final groupId = int.parse(state.pathParameters['gid']!);
              final create = state.queryParameters.containsKey('create');
              return RoleDetailPage(role, groupId,
                  mode: create ? PageMode.create : PageMode.edit);
            }),
      ]),
]);
