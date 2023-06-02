import 'package:client/domain/meeting/meeting.dart';
import 'package:client/utils/either.dart';

abstract class IMeetingRepository {
  Future<Either<Meeting>> createMeeting(
      Meeting meeting, int groupId, String token);
  Future<Either<Meeting>> updateMeeting(
      Meeting meeting, int groupId, String token);
  Future<Either<bool>> deleteMeeting(int meetingId, int groupId, String token);
}
