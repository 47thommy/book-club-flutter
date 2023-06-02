import 'package:client/domain/vote/vote.dart';
import 'package:equatable/equatable.dart';

abstract class VoteEvent extends Equatable {
  const VoteEvent();

  @override
  List<Object?> get props => [];
}

class VoteCreate extends VoteEvent {
  final Vote vote;
  final int pollId;

  const VoteCreate(this.vote, this.pollId);

  @override
  List<Object?> get props => [vote];

  @override
  String toString() => 'Vote create { vote: $vote }';
}

class VoteDelete extends VoteEvent {
  final int voteId;
  final int groupId;

  const VoteDelete(this.voteId, this.groupId);

  @override
  List<Object?> get props => [voteId];

  @override
  String toString() => 'vote delete { vote_id: $voteId }';
}
