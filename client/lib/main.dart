import 'package:client/block_observer.dart';
import 'package:client/group/blocs/blocs.dart';
import 'package:client/group/repository/group_repository.dart';
import 'package:client/user/blocs/blocs.dart';
import 'package:client/user/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './router.dart';
import 'package:client/profile.dart';
import 'package:client/reading_list.dart';
import 'user/screens/screens.dart';
import 'home.dart';
import 'schedule.dart';

void main() {
  BlocOverrides.runZoned(() => runApp(const BookclubApp()),
      blocObserver: SimpleBlocObserver());
}

class BookclubApp extends StatelessWidget {
  const BookclubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<UserRepository>(
              create: (context) => UserRepository()),
          RepositoryProvider<GroupRepository>(
              create: (context) => GroupRepository()),
        ],
        child: MultiBlocProvider(
            providers: [
              BlocProvider<UserBloc>(
                create: (context) => UserBloc(context.read<UserRepository>())
                  ..add(const UserLoad()),
              ),
              BlocProvider<GroupBloc>(
                  create: (context) =>
                      GroupBloc(context.read<GroupRepository>()))
            ],
            child: MaterialApp.router(
              theme: ThemeData(),
              darkTheme: ThemeData.dark(),
              themeMode: ThemeMode.system,
              routerConfig: router,
            )));
  }
}
