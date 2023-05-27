import 'package:client/domain/groups/group_dto.dart';
import 'package:client/infrastructure/common/exception.dart';
import 'package:client/infrastructure/group/data_providers/group_api.dart';
import 'package:client/infrastructure/group/data_providers/group_local.dart';
import 'package:client/utils/either.dart';
import 'package:client/utils/failure.dart';

class GroupRepository {
  final GroupCacheClient _cache;
  final GroupApi _groupApi;

  GroupRepository({GroupCacheClient? cache, GroupApi? api})
      : _cache = cache ?? GroupCacheClient(),
        _groupApi = api ?? GroupApi();

  Future<Either<GroupDto>> getGroup(int id, String token) async {
    try {
      final group = await _groupApi.getGroup(id, token);
      return Either(value: group);
    } on BCHttpException catch (error) {
      return Either(failure: Failure(error.message));
    } catch (error) {
      return Either(failure: Failure(error.toString()));
    }
  }

  Future<Either<List<GroupDto>>> getGroups(String token) async {
    try {
      final groups = await _groupApi.getGroups(token);
      return Either(value: groups);
    } on BCHttpException catch (error) {
      return Either(failure: Failure(error.message));
    } catch (error) {
      return Either(failure: Failure(error.toString()));
    }
  }

  Future<Either<List<GroupDto>>> getJoinedGroups(String token) async {
    try {
      final groups = await _groupApi.getJoinedGroups(token);
      return Either(value: groups);
    } on BCHttpException catch (error) {
      return Either(failure: Failure(error.message));
    } catch (error) {
      return Either(failure: Failure(error.toString()));
    }
  }

  Future<Either<GroupDto>> createGroup(GroupDto group, String token) async {
    try {
      final grp = await _groupApi.createGroup(group: group, token: token);
      return Either(value: grp);
    } on BCHttpException catch (error) {
      return Either(failure: Failure(error.message));
    } catch (error) {
      return Either(failure: Failure(error.toString()));
    }
  }
}
