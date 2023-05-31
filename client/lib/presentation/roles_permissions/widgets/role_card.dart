import 'package:client/application/group/group_bloc.dart';
import 'package:client/application/group/group_event.dart';
import 'package:client/application/role/role_bloc.dart';
import 'package:client/application/role/role_event.dart';
import 'package:client/application/role/role_state.dart';
import 'package:client/domain/role/role.dart';
import 'package:client/infrastructure/group/group_repository.dart';
import 'package:client/infrastructure/role/dto/role_dto.dart';
import 'package:client/infrastructure/role/role_repository.dart';
import 'package:client/infrastructure/user/user_repository.dart';
import 'package:client/presentation/pages/common/snackbar.dart';
import 'package:client/presentation/roles_permissions/role_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RoleCard extends StatelessWidget {
  final RoleDto role;
  final int groupId;

  const RoleCard(this.role, this.groupId, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => RoleBloc(
            roleRepository: context.read<RoleRepository>(),
            userRepository: context.read<UserRepository>(),
            groupRepository: context.read<GroupRepository>()),

        //
        // consumer
        child: BlocConsumer<RoleBloc, RoleState>(listener: (context, state) {
          if (state is RoleDeleted) {
            showSuccess(context, 'Role deleted');
            context.read<GroupBloc>().add(LoadGroupDetail(groupId));
          } else if (state is RoleOperationFailure) {
            showFailure(context, state.error.failure.toString());
          }
        },

            // card body
            builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(role.name),

              //
              // for owner roles only view permission
              if (role.name == Role.owner)
                IconButton(
                  iconSize: 16,
                  onPressed: () {
                    context
                        .pushNamed(RoleDetailPage.routeName,
                            pathParameters: {'gid': groupId.toString()},
                            extra: role)
                        .then((value) => context
                            .read<GroupBloc>()
                            .add(LoadGroupDetail(groupId)));
                  },
                  icon: const Icon(Icons.visibility),
                ),

              //
              // for other roles delete and editing is allowed
              // (if current user is owner of group)
              if (role.name != Role.owner)
                Row(
                  children: [
                    IconButton(
                      iconSize: 16,
                      onPressed: () {
                        context
                            .pushNamed(RoleDetailPage.routeName,
                                pathParameters: {'gid': groupId.toString()},
                                extra: role)
                            .then((value) => context
                                .read<GroupBloc>()
                                .add(LoadGroupDetail(groupId)));
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        context
                            .read<RoleBloc>()
                            .add(RoleDelete(role.id, groupId));
                      },
                      icon: const Icon(Icons.remove),
                    ),
                  ],
                ),
            ],
          );
        }));
  }
}
