import 'package:client/block_observer.dart';
import 'package:client/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:client/user/repository/user_repository.dart';

import 'application/auth/auth_bloc.dart';
import 'application/auth/auth_event.dart';

void main() async {
  BlocOverrides.runZoned(() => runApp(App(userRepository: UserRepository())),
      blocObserver: SimpleBlocObserver());
}

class App extends StatelessWidget {
  final UserRepository _userRepository;

  const App({super.key, required userRepository})
      : _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: _userRepository,
        child: BlocProvider(
          create: (context) =>
              AuthenticationBloc(userRepository: _userRepository)
                ..add(AppStarted()),
          child: MaterialApp.router(
            theme: ThemeData(),
            darkTheme: ThemeData.dark(),
            themeMode: ThemeMode.system,
            routerConfig: router,
          ),
        ));
  }
}
