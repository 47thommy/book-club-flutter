import 'package:client/domain/meeting/meeting.dart';
import 'package:client/domain/meeting/meeting_repository_interface.dart';
import 'package:client/infrastructure/auth/exceptions.dart';
import 'package:client/infrastructure/meeting/dto/meeting_dto.dart';
import 'package:client/infrastructure/common/exception.dart';
import 'package:client/infrastructure/meeting/data_providers/meeting_api.dart';
import 'package:client/infrastructure/meeting/data_providers/meeting_local.dart';
import 'package:client/infrastructure/meeting/dto/meeting_mapper.dart';
import 'package:client/utils/either.dart';
import 'package:client/utils/failure.dart';

class MeetingRepository implements IMeetingRepository {
  final MeetingCacheClient _cache;
  final MeetingApi _meetingApi;

  MeetingRepository({MeetingCacheClient? cache, MeetingApi? api})
      : _cache = cache ?? MeetingCacheClient(),
        _meetingApi = api ?? MeetingApi();

  Future<Either<Meeting>> getMeeting(int id, String token) async {
    try {
      final meeting = await _meetingApi.getMeeting(id, token);
      return Either(value: meeting.toMeeting());
    } on BCHttpException catch (error) {
      return Either(failure: Failure(error.message));
    } on AuthenticationFailure catch (error) {
      return Either(failure: Failure(error.message));
    } catch (error) {
      return Either(failure: Failure(error.toString()));
    }
  }

  @override
  Future<Either<Meeting>> createMeeting(
      Meeting meeting, int groupId, String token) async {
    try {
      final mtng = await _meetingApi.createMeeting(
          meeting: meeting.toMeetingDto(), groupId: groupId, token: token);
      return Either(value: mtng.toMeeting());
    } on BCHttpException catch (error) {
      return Either(failure: Failure(error.message));
    } on AuthenticationFailure catch (error) {
      return Either(failure: Failure(error.message));
    } catch (error) {
      return Either(failure: Failure(error.toString()));
    }
  }

  @override
  Future<Either<Meeting>> updateMeeting(
      Meeting meeting, int groupId, String token) async {
    try {
      final mtng = await _meetingApi.updateMeeting(
          meeting: meeting.toMeetingDto(), groupId: groupId, token: token);
      return Either(value: mtng.toMeeting());
    } on BCHttpException catch (error) {
      return Either(failure: Failure(error.message));
    } on AuthenticationFailure catch (error) {
      return Either(failure: Failure(error.message));
    } catch (error) {
      return Either(failure: Failure(error.toString()));
    }
  }

  @override
  Future<Either<bool>> deleteMeeting(
      int meetingId, int groupId, String token) async {
    try {
      await _meetingApi.deleteMeeting(
          meetingId: meetingId, groupId: groupId, token: token);
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
