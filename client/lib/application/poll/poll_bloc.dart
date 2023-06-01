import 'package:client/domain/poll/poll_repository_interface.dart';
import 'package:client/infrastructure/group/group_repository.dart';
import 'package:client/infrastructure/user/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer';

import 'poll_event.dart';
import 'poll_state.dart';

class PollBloc extends Bloc<PollEvent, PollState> {
  final IPollRepository pollRepository;
  final GroupRepository groupRepository;
  final UserRepository userRepository;

  PollBloc(
      {required this.pollRepository,
      required this.userRepository,
      required this.groupRepository})
      : super(PollInit()) {
    //
    // Poll create
    on<PollCreate>((event, emit) async {
      final token = await userRepository.getToken();

      final result =
          await pollRepository.createPoll(event.poll, event.groupId, token);

      if (result.hasError) {
        emit(PollOperationFailure(result.failure!));
      } else {
        emit(PollCreated(result.value!, event.groupId));
      }
    });

    //
    // Poll delete
    on<PollDelete>((event, emit) async {
      final token = await userRepository.getToken();

      final result = await pollRepository.deletePoll(event.pollId, token);

      if (result.hasError) {
        emit(PollOperationFailure(result.failure!));
      } else {
        emit(PollDeleted(event.pollId));
      }
    });
  }
}
