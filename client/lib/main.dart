import 'package:client/block_observer.dart';
import 'package:client/infrastructure/group/group_repository.dart';
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
              ],

                  // Bloc providers
                  child: BlocProvider(
                    create: (context) => AuthenticationBloc(
                        userRepository:
                            RepositoryProvider.of<UserRepository>(context))
                      ..add(AppStarted()),

                    // App
                    child: MaterialApp.router(
                      theme: ThemeData(),
                      darkTheme: ThemeData.dark(),
                      themeMode: ThemeMode.system,
                      routerConfig: router,
                    ),
                  ))),
      blocObserver: SimpleBlocObserver());
}
