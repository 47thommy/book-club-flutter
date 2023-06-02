import 'package:client/domain/meeting/meeting.dart';
import 'package:equatable/equatable.dart';

abstract class MeetingEvent extends Equatable {
  const MeetingEvent();

  @override
  List<Object?> get props => [];
}

class MeetingCreate extends MeetingEvent {
  final Meeting meeting;
  final int groupId;

  const MeetingCreate(this.meeting, this.groupId);

  @override
  List<Object?> get props => [meeting];

  @override
  String toString() => 'meeting create { meeting: $meeting }';
}

class MeetingUpdate extends MeetingEvent {
  final Meeting meeting;
  final int groupId;

  const MeetingUpdate(this.meeting, this.groupId);

  @override
  List<Object?> get props => [meeting, groupId];

  @override
  String toString() => 'meeting update { meeting: ${meeting.id} }';
}

class MeetingDelete extends MeetingEvent {
  final int meetingId;
  final int groupId;

  const MeetingDelete(this.meetingId, this.groupId);

  @override
  List<Object?> get props => [meetingId, groupId];

  @override
  String toString() => 'meeting delete { meeting_id: $meetingId }';
}
