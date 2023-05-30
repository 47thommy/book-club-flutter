import 'package:client/infrastructure/auth/exceptions.dart';
import 'package:client/infrastructure/meeting/dto/meeting_dto.dart';
import 'package:client/infrastructure/common/exception.dart';
import 'package:client/infrastructure/meeting/data_providers/meeting_api.dart';
import 'package:client/infrastructure/meeting/data_providers/meeting_local.dart';
import 'package:client/utils/either.dart';
import 'package:client/utils/failure.dart';

class MeetingRepository {
  final MeetingCacheClient _cache;
  final MeetingApi _meetingApi;

  MeetingRepository({MeetingCacheClient? cache, MeetingApi? api})
      : _cache = cache ?? MeetingCacheClient(),
        _meetingApi = api ?? MeetingApi();

  Future<Either<MeetingDto>> getMeeting(int id, String token) async {
    try {
      final meeting = await _meetingApi.getMeeting(id, token);
      return Either(value: meeting);
    } on BCHttpException catch (error) {
      return Either(failure: Failure(error.message));
    } on AuthenticationFailure catch (error) {
      return Either(failure: Failure(error.message));
    } catch (error) {
      return Either(failure: Failure(error.toString()));
    }
  }

  Future<Either<MeetingDto>> createMeeting(
      MeetingDto meeting, String token) async {
    try {
      final mtng =
          await _meetingApi.createMeeting(meeting: meeting, token: token);
      return Either(value: mtng);
    } on BCHttpException catch (error) {
      return Either(failure: Failure(error.message));
    } on AuthenticationFailure catch (error) {
      return Either(failure: Failure(error.message));
    } catch (error) {
      return Either(failure: Failure(error.toString()));
    }
  }

  Future<Either<MeetingDto>> updateMeeting(MeetingDto meeting, String token) async {
    try {
      final mtng = await _meetingApi.updateMeeting(meeting: meeting, token: token);
      return Either(value: mtng);
    } on BCHttpException catch (error) {
      return Either(failure: Failure(error.message));
    } on AuthenticationFailure catch (error) {
      return Either(failure: Failure(error.message));
    } catch (error) {
      return Either(failure: Failure(error.toString()));
    } 
  }

  Future<Either<MeetingDto>> deleteMeeting(
      MeetingDto meeting, String token) async {
    try {
      final mtng =
          await _meetingApi.deleteMeeting(meeting: meeting, token: token);
      return Either(value: mtng);
    } on BCHttpException catch (error) {
      return Either(failure: Failure(error.message));
    } on AuthenticationFailure catch (error) {
      return Either(failure: Failure(error.message));
    } catch (error) {
      return Either(failure: Failure(error.toString()));
    }
  }
}
