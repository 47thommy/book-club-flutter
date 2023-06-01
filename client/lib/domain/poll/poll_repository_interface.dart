import 'package:client/domain/poll/poll.dart';
import 'package:client/domain/poll/poll_form.dart';
import 'package:client/utils/either.dart';

abstract class IPollRepository {
  Future<Either<Poll>> createPoll(PollForm poll, int groupId, String token);

  Future<Either<bool>> deletePoll(int pollId, int groupId, String token);
}
