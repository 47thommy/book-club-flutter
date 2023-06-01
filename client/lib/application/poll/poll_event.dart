import 'package:client/domain/poll/poll_form.dart';
import 'package:equatable/equatable.dart';

abstract class PollEvent extends Equatable {
  const PollEvent();

  @override
  List<Object?> get props => [];
}

class PollCreate extends PollEvent {
  final PollForm poll;
  final int groupId;

  const PollCreate(this.poll, this.groupId);

  @override
  List<Object?> get props => [poll];

  @override
  String toString() => 'Poll create { poll: $poll }';
}

class PollDelete extends PollEvent {
  final int pollId;
  final int groupId;

  const PollDelete(this.pollId, this.groupId);

  @override
  List<Object?> get props => [pollId];

  @override
  String toString() => 'poll delete { poll_id: $pollId }';
}
