import 'package:client/application/group/group.dart';
import 'package:client/infrastructure/group/group_repository.dart';
import 'package:client/infrastructure/user/user_repository.dart';
import 'package:client/presentation/pages/group/widgets/groups_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsScreen extends StatelessWidget {
  static const String routeName = 'groups';

  const GroupsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GroupBloc>(
      create: (context) {
        return GroupBloc(
            // repos
            userRepository: context.read<UserRepository>(),
            groupRepository: context.read<GroupRepository>())
          ..add(LoadGroups());
      },
      child: const GroupsPage(),
    );
  }
}
