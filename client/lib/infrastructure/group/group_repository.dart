import 'dart:async';

import 'package:client/infrastructure/auth/exceptions.dart';
import 'package:client/infrastructure/group/dto/group_dto.dart';
import 'package:client/infrastructure/common/exception.dart';
import 'package:client/infrastructure/group/data_providers/group_api.dart';
import 'package:client/infrastructure/group/data_providers/group_local.dart';
import 'package:client/utils/either.dart';
import 'package:client/utils/failure.dart';
import 'dart:developer';

class GroupRepository {
  final GroupCacheClient _cache;
  final GroupApi _groupApi;

  GroupRepository({GroupCacheClient? cache, GroupApi? api})
      : _cache = cache ?? GroupCacheClient(),
        _groupApi = api ?? GroupApi();

  Future<Either<GroupDto>> getGroup(
    int id,
    String token,
  ) async {
    // remote
    try {
      final group = await _groupApi.getGroup(id, token);
      return Either(value: group);
    }

    // cache
    on TimeoutException catch (_) {
      return await _cache.get(id);
    }

    //
    on BCHttpException catch (error) {
      return Either(failure: Failure(error.message));
    } on AuthenticationFailure catch (error) {
      return Either(failure: Failure(error));
    } catch (error) {
      return Either(failure: Failure(error.toString()));
    }
  }

  Future<Either<List<GroupDto>>> getGroups(String token) async {
    // remote
    try {
      final groups = await _groupApi.getGroups(token);
      for (var group in groups) {
        await _cache.save(group);
      }
      return Either(value: groups);
    }

    // cache
    on TimeoutException catch (_) {
      return await _cache.getAll();
    }

    //
    on BCHttpException catch (error) {
      return Either(failure: Failure(error.message));
    } on AuthenticationFailure catch (error) {
      return Either(failure: Failure(error));
    } catch (error) {
      return Either(failure: Failure(error.toString()));
    }
  }

  Future<Either<List<GroupDto>>> getJoinedGroups(String token) async {
    // remote
    try {
      final groups = await _groupApi.getJoinedGroups(token);
      for (var group in groups) {
        await _cache.save(group, true);
      }
      return Either(value: groups);
    }

    // cache
    on TimeoutException catch (_) {
      return await _cache.getJoined();
    }

    //
    on BCHttpException catch (error) {
      return Either(failure: Failure(error.message));
    } on AuthenticationFailure catch (error) {
      return Either(failure: Failure(error));
    } catch (error) {
      return Either(failure: Failure(error.toString()));
    }
  }

  Future<Either<GroupDto>> createGroup(GroupDto group, String token) async {
    try {
      final grp = await _groupApi.createGroup(group: group, token: token);
      return Either(value: grp);
    } on TimeoutException catch (_) {
      return Either(failure: const Failure("Connection timed out"));
    } on BCHttpException catch (error) {
      return Either(failure: Failure(error.message));
    } on AuthenticationFailure catch (error) {
      return Either(failure: Failure(error));
    } catch (error) {
      return Either(failure: Failure(error.toString()));
    }
  }

  Future<Either<GroupDto>> updateGroup(GroupDto group, String token) async {
    try {
      final grp = await _groupApi.updateGroup(group: group, token: token);

      return Either(value: grp);
    } on TimeoutException catch (_) {
      return Either(failure: const Failure("Connection timed out"));
    } on BCHttpException catch (error) {
      return Either(failure: Failure(error.message));
    } on AuthenticationFailure catch (error) {
      return Either(failure: Failure(error));
    } catch (error) {
      return Either(failure: Failure(error.toString()));
    }
  }

  Future<Either<GroupDto>> joinGroup(GroupDto group, String token) async {
    try {
      await _groupApi.join(group: group, token: token);
      return Either(value: group);
    } on TimeoutException catch (_) {
      return Either(failure: const Failure("Connection timed out"));
    } on BCHttpException catch (error) {
      return Either(failure: Failure(error.message));
    } on AuthenticationFailure catch (error) {
      return Either(failure: Failure(error));
    } catch (error) {
      return Either(failure: Failure(error.toString()));
    }
  }

  Future<Either<GroupDto>> leaveGroup(GroupDto group, String token) async {
    try {
      await _groupApi.leave(group: group, token: token);
      return Either(value: group);
    } on TimeoutException catch (_) {
      return Either(failure: const Failure("Connection timed out"));
    } on BCHttpException catch (error) {
      return Either(failure: Failure(error.message));
    } on AuthenticationFailure catch (error) {
      return Either(failure: Failure(error));
    } catch (error) {
      return Either(failure: Failure(error.toString()));
    }
  }

  Future<Either<GroupDto>> addMember(
      GroupDto group, int userId, String token) async {
    try {
      await _groupApi.addMember(group, userId, token);
      return Either(value: group);
    } on TimeoutException catch (_) {
      return Either(failure: const Failure("Connection timed out"));
    } on BCHttpException catch (error) {
      return Either(failure: Failure(error.message));
    } on AuthenticationFailure catch (error) {
      return Either(failure: Failure(error));
    } catch (error) {
      return Either(failure: Failure(error.toString()));
    }
  }

  Future<Either<GroupDto>> removeMember(
      GroupDto group, int userId, String token) async {
    try {
      await _groupApi.removeMember(group, userId, token);
      return Either(value: group);
    } on TimeoutException catch (_) {
      return Either(failure: const Failure("Connection timed out"));
    } on BCHttpException catch (error) {
      return Either(failure: Failure(error.message));
    } on AuthenticationFailure catch (error) {
      return Either(failure: Failure(error));
    } catch (error) {
      return Either(failure: Failure(error.toString()));
    }
  }
}
