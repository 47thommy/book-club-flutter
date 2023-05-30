import 'package:client/infrastructure/role/role.dart';
import 'package:client/infrastructure/role/role_repository.dart';
import 'package:client/infrastructure/group/group_repository.dart';
import 'package:client/infrastructure/user/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer';

import 'role_event.dart';
import 'role_state.dart';

class RoleBloc extends Bloc<RoleEvent, RoleState> {
  final RoleRepository roleRepository;
  final GroupRepository groupRepository;
  final UserRepository userRepository;

  RoleBloc(
      {required this.roleRepository,
      required this.userRepository,
      required this.groupRepository})
      : super(RoleInit()) {
    //
    // Role create
    on<RoleCreate>((event, emit) async {
      final token = await userRepository.getToken();

      final result = await roleRepository.createRole(
          event.role.toRole(), event.groupId, token);

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
      log('ok');
      log(event.runtimeType.toString());
      final result =
          await roleRepository.updateRole(event.role.toRole(), token);

      if (result.hasError) {
        emit(RoleOperationFailure(result.failure!));
      } else {
        emit(RoleUpdated(result.value!));
      }
    });
  }
}
