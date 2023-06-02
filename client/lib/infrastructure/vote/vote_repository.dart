import 'dart:developer';

import 'package:client/domain/vote/vote.dart';

import 'package:client/infrastructure/auth/exceptions.dart';
import 'package:client/infrastructure/common/exception.dart';
import 'package:client/infrastructure/vote/data_providers/vote_api.dart';
import 'package:client/infrastructure/vote/dto/vote_dto.dart';
import 'package:client/utils/either.dart';
import 'package:client/utils/failure.dart';

class VoteRepository {
  final VoteApi _voteApi;

  VoteRepository({VoteApi? api}) : _voteApi = api ?? VoteApi();

  Future<Either<Vote>> createVote(
      VoteDto vote, int pollId, String token) async {
    try {
      final newVote = await _voteApi.createVote(pollId, vote, token);
      return Either(value: newVote);
    } on BCHttpException catch (error) {
      return Either(failure: Failure(error.message));
    } on AuthenticationFailure catch (error) {
      return Either(failure: Failure(error.message));
    } catch (error) {
      return Either(failure: Failure(error.toString()));
    }
  }

  Future<Either<bool>> deleteVote(int voteId, String token) async {
    try {
      await _voteApi.deleteVote(voteId, token);
      return Either(value: true);
    } on BCHttpException catch (error) {
      return Either(failure: Failure(error.message));
    } on AuthenticationFailure catch (error) {
      return Either(failure: Failure(error.message));
    } catch (error) {
      return Either(failure: Failure(error.toString()));
    }
  }
}
