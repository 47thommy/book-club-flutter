import 'package:client/infrastructure/group/group_repository.dart';
import 'package:client/infrastructure/user/user_repository.dart';
import 'package:client/infrastructure/vote/dto/vote_mapper.dart';
import 'package:client/infrastructure/vote/vote_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer';

import 'vote_event.dart';
import 'vote_state.dart';

class VoteBloc extends Bloc<VoteEvent, VoteState> {
  final VoteRepository voteRepository;
  final UserRepository userRepository;

  VoteBloc({
    required this.voteRepository,
    required this.userRepository,
  }) : super(VoteInit()) {
    //
    // Vote create
    on<VoteCreate>((event, emit) async {
      final token = await userRepository.getToken();

      final result = await voteRepository.createVote(
          event.vote.toVoteDto(), event.pollId, token);

      if (result.hasError) {
        emit(VoteOperationFailure(result.failure!));
      } else {
        emit(VoteCreated(result.value!, event.pollId));
      }
    });

    //
    // Vote delete
    on<VoteDelete>((event, emit) async {
      final token = await userRepository.getToken();

      final result = await voteRepository.deleteVote(event.voteId, token);

      if (result.hasError) {
        emit(VoteOperationFailure(result.failure!));
      } else {
        emit(VoteDeleted(event.voteId));
      }
    });
  }
}
