import 'package:client/domain/role/role_repository_interface.dart';
import 'package:client/infrastructure/group/group_repository.dart';
import 'package:client/infrastructure/user/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer';

import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({
    required this.userRepository,
  }) : super(ProfileInit()) {
    //
    // Profile update
    on<ProfileUpdate>((event, emit) async {
      final token = await userRepository.getToken();

      final result = await userRepository.updateUser(event.profile, token);

      if (result.hasError) {
        emit(UserOperationFailure(result.failure!));
      } else {
        await userRepository.getLoggedInUser();
        emit(ProfileUpdated(result.value!));
      }
    });

    //
    // Profile delete
    on<UserDelete>((event, emit) async {
      final token = await userRepository.getToken();

      final result = await userRepository.deleteUser(event.userId, token);

      if (result.hasError) {
        emit(UserOperationFailure(result.failure!));
      } else {
        emit(UserDeleted(event.userId));
      }
    });
  }
}
