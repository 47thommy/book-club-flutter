import 'package:client/domain/meeting/meeting_repository_interface.dart';
import 'package:client/infrastructure/user/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer';

import 'meeting_event.dart';
import 'meeting_state.dart';

class MeetingBloc extends Bloc<MeetingEvent, MeetingState> {
  final IMeetingRepository meetingRepository;

  final UserRepository userRepository;

  MeetingBloc({
    required this.meetingRepository,
    required this.userRepository,
  }) : super(MeetingInit()) {
    //
    // Meeting create
    on<MeetingCreate>((event, emit) async {
      final token = await userRepository.getToken();

      final result =
          await meetingRepository.createMeeting(event.meeting, event.groupId, token);

      if (result.hasError) {
        emit(MeetingOperationFailure(result.failure!));
      } else {
        emit(MeetingCreated(result.value!, event.groupId));
      }
    });

    //
    // Meeting update
    on<MeetingUpdate>((event, emit) async {
      final token = await userRepository.getToken();

      final result =
          await meetingRepository.updateMeeting(event.meeting, event.groupId, token);

      if (result.hasError) {
        emit(MeetingOperationFailure(result.failure!));
      } else {
        emit(MeetingUpdated(result.value!));
      }
    });

    //
    // Meeting delete
    on<MeetingDelete>((event, emit) async {
      final token = await userRepository.getToken();

      final result =
          await meetingRepository.deleteMeeting(event.meetingId, event.groupId, token);

      if (result.hasError) {
        emit(MeetingOperationFailure(result.failure!));
      } else {
        emit(MeetingDeleted(event.meetingId));
      }
    });
  }
}
