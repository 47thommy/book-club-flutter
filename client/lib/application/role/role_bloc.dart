import 'package:client/domain/role/role_repository_interface.dart';
import 'package:client/infrastructure/user/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer';

import 'role_event.dart';
import 'role_state.dart';

class RoleBloc extends Bloc<RoleEvent, RoleState> {
  final IRoleRepository roleRepository;

  final UserRepository userRepository;

  RoleBloc({
    required this.roleRepository,
    required this.userRepository,
  }) : super(RoleInit()) {
    //
    // Role create
    on<RoleCreate>((event, emit) async {
      final token = await userRepository.getToken();

      final result =
          await roleRepository.createRole(event.role, event.groupId, token);

      if (result.hasError) {
        emit(RoleOperationFailure(result.failure!));
      } else {
        emit(RoleCreated(result.value!, event.groupId));
      }
    });

    //
    // Role update
    on<RoleUpdate>((event, emit) async {
      final token = await userRepository.getToken();

      final result =
          await roleRepository.updateRole(event.role, event.groupId, token);

      if (result.hasError) {
        emit(RoleOperationFailure(result.failure!));
      } else {
        emit(RoleUpdated(result.value!));
      }
    });

    //
    // Role delete
    on<RoleDelete>((event, emit) async {
      final token = await userRepository.getToken();

      final result =
          await roleRepository.deleteRole(event.roleId, event.groupId, token);

      if (result.hasError) {
        emit(RoleOperationFailure(result.failure!));
      } else {
        emit(RoleDeleted(event.roleId));
      }
    });
  }
}
