import 'dart:developer';

import 'package:client/application/group/group.dart';
import 'package:client/application/role/role_bloc.dart';
import 'package:client/application/role/role_event.dart';
import 'package:client/application/role/role_state.dart';
import 'package:client/domain/core/validator.dart';
import 'package:client/domain/role/role.dart';
import 'package:client/domain/role/role_form.dart';
import 'package:client/domain/user/user.dart';
import 'package:client/infrastructure/group/group_repository.dart';
import 'package:client/infrastructure/role/dto/permission_dto.dart';
import 'package:client/infrastructure/role/dto/role_dto.dart';
import 'package:client/infrastructure/role/role_repository.dart';
import 'package:client/infrastructure/user/dto/user_dto.dart';
import 'package:client/infrastructure/user/user_repository.dart';
import 'package:client/presentation/pages/common/page_mode.dart';
import 'package:client/presentation/pages/common/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RoleAssignPage extends StatefulWidget {
  static const routeName = 'role-assign';

  final User user;
  final int groupId;

  const RoleAssignPage(this.user, this.groupId, {super.key});

  @override
  State<RoleAssignPage> createState() => _RoleAssignPageState();
}

class _RoleAssignPageState extends State<RoleAssignPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => RoleBloc(
              roleRepository: context.read<RoleRepository>(),
              userRepository: context.read<UserRepository>(),
            ),

        //
        // body
        child: BlocListener<RoleBloc, RoleState>(
          listener: (context, state) {
            // on role update
            if (state is RoleAssigned) {
              showSuccess(context, 'Role assigned to @${widget.user.username}');
              context.pop();
              context.read<GroupBloc>().add(LoadGroupDetail(widget.groupId));
            }

            // on error
            else if (state is RoleOperationFailure) {
              showFailure(context, state.error.failure.toString());
            }
          },
          child: BlocProvider(
              create: (context) => GroupBloc(
                  groupRepository: context.read<GroupRepository>(),
                  userRepository: context.read<UserRepository>()),

              //
              child: BlocBuilder<GroupBloc, GroupState>(
                  builder: (context, state) => body(context))),
        ));
  }

  Widget body(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Assign Role'),
        ),
        body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                child: Text(widget.user.firstName),
              ),
              DropdownButtonExample([Role.empty])
            ]));
  }
}

class DropdownButtonExample extends StatefulWidget {
  final List<Role> list;
  const DropdownButtonExample(this.list, {super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  late Role role;

  @override
  void initState() {
    role = widget.list[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var items = widget.list.map<DropdownMenuItem<Role>>((Role value) {
      return DropdownMenuItem<Role>(
        value: value,
        child: Text(value.name),
      );
    }).toList();

    return DropdownButton<Role>(
      value: role,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      onChanged: (Role? value) {
        // This is called when the user selects an item.
        setState(() {
          role = value!;
        });
      },
      items: items,
    );
  }
}
