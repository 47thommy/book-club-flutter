import 'package:client/domain/poll/poll.dart';
import 'package:client/utils/failure.dart';
import 'package:equatable/equatable.dart';

abstract class PollState extends Equatable {
  const PollState();

  @override
  List<Object?> get props => [];
}

class PollInit extends PollState {}

class PollCreated extends PollState {
  final Poll poll;
  final int groupId;

  const PollCreated(this.poll, this.groupId);

  @override
  List<Object?> get props => [poll];
}

class PollDeleted extends PollState {
  final int pollId;

  const PollDeleted(this.pollId);

  @override
  List<Object?> get props => [pollId];
}

class PollOperationFailure extends PollState {
  final Failure error;

  const PollOperationFailure(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'PollOperationFailure { error: $error }';
}
