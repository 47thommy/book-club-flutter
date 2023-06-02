import 'package:client/domain/user/user.dart';
import 'package:client/infrastructure/book/dto/book_dto.dart';
import 'package:client/infrastructure/group/dto/group_dto.dart';
import 'package:client/infrastructure/role/dto/role_dto.dart';
import 'package:client/infrastructure/user/dto/dto.dart';
import 'package:client/infrastructure/user/model/user_dto.dart';
import 'package:client/presentation/app.dart';
import 'package:client/presentation/pages/books/book_detail.dart';
import 'package:client/presentation/pages/books/book_list.dart';
import 'package:client/presentation/pages/common/page_mode.dart';
import 'package:client/presentation/pages/meeting/create_meeting.dart';
import 'package:client/presentation/pages/meeting/meeting_list.dart';
import 'package:client/presentation/pages/profile/profile.dart';
import 'package:client/presentation/pages/roles_permissions/role_assign.dart';
import 'package:client/presentation/pages/roles_permissions/role_detail.dart';
import 'package:client/presentation/pages/poll/poll_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:client/presentation/pages/group/group.dart';

import '../pages/poll/polls_list.dart';

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

        //
        // Polls list  screen
        GoRoute(
            name: PollsList.routeName,
            path: '/${PollsList.routeName}/:gid',
            builder: (context, state) {
              final groupId = int.parse(state.pathParameters['gid']!);
              return PollsList(groupId);
            }),

        //
        // Poll  screen
        GoRoute(
            name: PollCreateScreen.routeName,
            path: '/${PollCreateScreen.routeName}/:gid',
            builder: (context, state) {
              final groupId = int.parse(state.pathParameters['gid']!);
              return PollCreateScreen(groupId);
            }),

        //
        // Book  screen
        GoRoute(
            name: BookDescription.routeName,
            path: '/${BookDescription.routeName}/:gid',
            builder: (context, state) {
              final groupId = int.parse(state.pathParameters['gid']!);
              final book = state.extra as BookDto;
              final create = state.queryParameters.containsKey('create');
              return BookDescription(
                  book: book, groupId: groupId, mode: PageMode.create);
            }),

        //
        // Books list screen
        GoRoute(
            name: ReadingListScreen.routeName,
            path: '/${ReadingListScreen.routeName}/:gid',
            builder: (context, state) {
              final groupId = int.parse(state.pathParameters['gid']!);
              return ReadingListScreen(groupId);
            }),

        //
        // Meeting screen
        GoRoute(
            name: CreateScheduleForm.routeName,
            path: '/${CreateScheduleForm.routeName}/:gid',
            builder: (context, state) {
              final groupId = int.parse(state.pathParameters['gid']!);
              return CreateScheduleForm(groupId);
            }),

        //
        // Meeting list screen
        GoRoute(
            name: ScheduleListPage.routeName,
            path: '/${ScheduleListPage.routeName}/:gid',
            builder: (context, state) {
              final groupId = int.parse(state.pathParameters['gid']!);
              return ScheduleListPage(groupId);
            }),

        //
        // Role Assign screen
        GoRoute(
            name: RoleAssignPage.routeName,
            path: '/${RoleAssignPage.routeName}/:gid',
            builder: (context, state) {
              final groupId = int.parse(state.pathParameters['gid']!);
              final user = state.extra as User;
              return RoleAssignPage(user, groupId);
            }),
      ]),
]);
