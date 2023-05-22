import 'package:client/block_observer.dart';
import 'package:client/user/blocs/blocs.dart';
import 'package:client/user/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './router.dart';

void main() {
  final UserRepository userRepository = UserRepository();

  BlocOverrides.runZoned(() => runApp(_InitHome(userRepository)),
      blocObserver: SimpleBlocObserver());
}

class _InitHome extends StatelessWidget {
  final UserRepository userRepository;

  const _InitHome(this.userRepository);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: userRepository,
        child: BlocProvider<UserBloc>(
            create: (context) => UserBloc(userRepository),
            child: MaterialApp.router(
              theme: ThemeData(),
              darkTheme: ThemeData.dark(),
              themeMode: ThemeMode.system,
              routerConfig: router,
            )));
  }
}
