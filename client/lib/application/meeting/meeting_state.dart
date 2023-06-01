import 'package:client/domain/meeting/meeting.dart';
import 'package:client/utils/failure.dart';
import 'package:equatable/equatable.dart';

abstract class MeetingState extends Equatable {
  const MeetingState();

  @override
  List<Object?> get props => [];
}

class MeetingInit extends MeetingState {}

class MeetingCreated extends MeetingState {
  final Meeting meeting;
  final int groupId;

  const MeetingCreated(this.meeting, this.groupId);

  @override
  List<Object?> get props => [meeting];
}

class MeetingUpdated extends MeetingState {
  final Meeting meeting;

  const MeetingUpdated(this.meeting);

  @override
  List<Object?> get props => [meeting];
}

class MeetingDeleted extends MeetingState {
  final int meetingId;

  const MeetingDeleted(this.meetingId);

  @override
  List<Object?> get props => [meetingId];
}

class MeetingOperationFailure extends MeetingState {
  final Failure error;

  const MeetingOperationFailure(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'MeetingOperationFailure { error: $error }';
}
