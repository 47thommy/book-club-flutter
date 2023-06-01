import 'package:client/domain/poll/poll.dart';
import 'package:client/domain/poll/poll_form.dart';
import 'package:client/domain/poll/poll_repository_interface.dart';
import 'package:client/infrastructure/auth/exceptions.dart';
import 'package:client/infrastructure/common/exception.dart';
import 'package:client/infrastructure/poll/data_providers/poll_api.dart';
import 'package:client/utils/either.dart';
import 'package:client/utils/failure.dart';

class PollRepository implements IPollRepository {
  final PollApi _pollApi;

  PollRepository({PollApi? api}) : _pollApi = api ?? PollApi();

  @override
  Future<Either<Poll>> createPoll(
      PollForm poll, int groupId, String token) async {
    try {
      final newPoll = await _pollApi.createPoll(groupId, poll, token);
      return Either(value: newPoll);
    } on BCHttpException catch (error) {
      return Either(failure: Failure(error.message));
    } on AuthenticationFailure catch (error) {
      return Either(failure: Failure(error.message));
    } catch (error) {
      return Either(failure: Failure(error.toString()));
    }
  }

  @override
  Future<Either<bool>> deletePoll(int pollId, String token) async {
    try {
      await _pollApi.deletePoll(pollId, token);
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
