import 'dart:developer';

import 'package:client/application/group/group.dart';
import 'package:client/application/role/role_bloc.dart';
import 'package:client/application/role/role_event.dart';
import 'package:client/application/role/role_state.dart';
import 'package:client/domain/core/validator.dart';
import 'package:client/domain/role/role.dart';
import 'package:client/domain/role/role_form.dart';
import 'package:client/infrastructure/group/group_repository.dart';
import 'package:client/infrastructure/role/dto/permission_dto.dart';
import 'package:client/infrastructure/role/dto/role_dto.dart';
import 'package:client/infrastructure/role/role_repository.dart';
import 'package:client/infrastructure/user/user_repository.dart';
import 'package:client/presentation/pages/common/page_mode.dart';
import 'package:client/presentation/pages/common/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RoleDetailPage extends StatefulWidget {
  static const routeName = 'role-detail';

  final RoleDto role;
  final PageMode mode;
  final int groupId;

  const RoleDetailPage(this.role, this.groupId,
      {super.key, this.mode = PageMode.edit});

  @override
  State<RoleDetailPage> createState() => _RoleDetailPageState();
}

class _RoleDetailPageState extends State<RoleDetailPage> {
  final _formKey = GlobalKey<FormState>();
  final rolePermissions = <int>{};
  final roleNameController = TextEditingController();

  @override
  void initState() {
    for (var permission in widget.role.permissions) {
      rolePermissions.add(permission.id);
    }
    roleNameController.text = widget.role.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => RoleBloc(
            roleRepository: context.read<RoleRepository>(),
            userRepository: context.read<UserRepository>(),
            groupRepository: context.read<GroupRepository>()),

        //
        // body
        child: BlocConsumer<RoleBloc, RoleState>(
          listener: (context, state) {
            // on role update
            if (state is RoleUpdated) {
              showSuccess(context, 'Role updated');
              context.pop();
              context.read<GroupBloc>().add(LoadGroupDetail(widget.groupId));
            }

            // on role create
            else if (state is RoleCreated) {
              showSuccess(context, 'Role created');
              context.pop();
              context.read<GroupBloc>().add(LoadGroupDetail(widget.groupId));
            }

            // on error
            else if (state is RoleOperationFailure) {
              showFailure(context, state.error.failure.toString());
            }
          },
          builder: (context, state) {
            return body(context);
          },
        ));
  }

  Widget body(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(roleNameController.text),
        ),
        body: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  //
                  // Role name field
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      enabled: !Role.defaults.contains(widget.role.name),
                      decoration: const InputDecoration(labelText: 'Role name'),
                      controller: roleNameController,
                      validator: (value) {
                        final result = validateNotEmpty(value!, 'Role');
                        if (result != null) {
                          return result.failure!.toString();
                        }
                        return null;
                      },
                    ),
                  ),

                  //
                  // ------------ Permission edit section -------------  //
                  const Text(
                    'What can members with this role do?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),

                  //
                  // Permissions
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: PermissionDto.all.length,
                      itemBuilder: (context, index) {
                        final permission = PermissionDto.all[index];
                        final permitted =
                            rolePermissions.contains(permission.id);

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              permission.name,
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                if (widget.role.name == Role.owner) return;
                                setState(() {
                                  if (permitted) {
                                    rolePermissions.remove(permission.id);
                                  } else {
                                    rolePermissions.add(permission.id);
                                  }
                                });
                              },
                              color: permitted ? Colors.green : Colors.red,
                              icon: Icon(permitted ? Icons.check : Icons.close),
                            ),
                          ],
                        );
                      }),

                  //
                  // Save or create button
                  if (widget.role.name != Role.owner)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();

                                final form = RoleForm(
                                    id: widget.role.id,
                                    name: roleNameController.text,
                                    permissionIds: rolePermissions.toList());

                                if (widget.mode == PageMode.create) {
                                  context
                                      .read<RoleBloc>()
                                      .add(RoleCreate(form, widget.groupId));
                                } else {
                                  context
                                      .read<RoleBloc>()
                                      .add(RoleUpdate(form, widget.groupId));
                                }
                              }
                            },
                            child: Text(widget.mode == PageMode.create
                                ? 'Create role'
                                : 'Save role')),
                      ),
                    )
                ],
              )),
        )));
  }
}
