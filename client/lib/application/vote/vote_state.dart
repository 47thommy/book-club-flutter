import 'package:client/domain/vote/vote.dart';
import 'package:client/utils/failure.dart';
import 'package:equatable/equatable.dart';

abstract class VoteState extends Equatable {
  const VoteState();

  @override
  List<Object?> get props => [];
}

class VoteInit extends VoteState {}

class VoteCreated extends VoteState {
  final Vote vote;
  final int pollId;

  const VoteCreated(this.vote, this.pollId);

  @override
  List<Object?> get props => [vote];
}

class VoteDeleted extends VoteState {
  final int voteId;

  const VoteDeleted(this.voteId);

  @override
  List<Object?> get props => [voteId];
}

class VoteOperationFailure extends VoteState {
  final Failure error;

  const VoteOperationFailure(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'VoteOperationFailure { error: $error }';
}
