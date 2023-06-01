import 'package:client/application/auth/auth_state.dart';
import 'package:client/application/file/file_bloc.dart';
import 'package:client/application/group/group.dart';
import 'package:client/application/user/user.dart';
import 'package:client/block_observer.dart';
import 'package:client/infrastructure/file/file_repository.dart';
import 'package:client/infrastructure/group/group_repository.dart';
import 'package:client/infrastructure/poll/poll_repository.dart';
import 'package:client/infrastructure/role/role_repository.dart';
import 'package:client/presentation/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:client/infrastructure/user/user_repository.dart';

import 'application/auth/auth_bloc.dart';
import 'application/auth/auth_event.dart';

void main() async {
  BlocOverrides.runZoned(
      () => runApp(

              // Repository providers
              MultiRepositoryProvider(
                  providers: [
                RepositoryProvider(create: (_) => GroupRepository()),
                RepositoryProvider(create: (_) => UserRepository()),
                RepositoryProvider(create: (_) => FileRepository()),
                RepositoryProvider(create: (_) => RoleRepository()),
                RepositoryProvider(create: (_) => PollRepository()),
              ],

                  // Bloc providers
                  child: MultiBlocProvider(
                    providers: [
                      // Authentication provider
                      BlocProvider(
                        create: (context) => AuthenticationBloc(
                            userRepository:
                                RepositoryProvider.of<UserRepository>(context))
                          ..add(AppStarted()),
                      ),

                      // File provider
                      BlocProvider(
                          create: (context) => FileBloc(
                              fileRepository:
                                  RepositoryProvider.of<FileRepository>(
                                      context))),

                      // Group provider
                      BlocProvider(
                          create: (context) => GroupBloc(
                              groupRepository:
                                  RepositoryProvider.of<GroupRepository>(
                                      context),
                              userRepository:
                                  RepositoryProvider.of<UserRepository>(
                                      context))),

                      // User provider
                      BlocProvider(
                          create: (context) => UserBloc(
                              userRepository:
                                  RepositoryProvider.of<UserRepository>(
                                      context))),
                    ],

                    // App
                    child:
                        BlocListener<AuthenticationBloc, AuthenticationState>(
                            listener: (context, state) {
                              if (state is UserSessionExpired) {
                                context
                                    .read<AuthenticationBloc>()
                                    .add(UserLoggedOut());
                              }
                            },
                            child: MaterialApp.router(
                              theme: ThemeData(),
                              darkTheme: ThemeData.dark(),
                              themeMode: ThemeMode.system,
                              routerConfig: router,
                            )),
                  ))),
      blocObserver: SimpleBlocObserver());
}
