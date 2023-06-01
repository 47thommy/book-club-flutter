import 'package:client/domain/role/role.dart';
import 'package:client/domain/role/role_form.dart';
import 'package:client/domain/role/role_repository_interface.dart';
import 'package:client/infrastructure/auth/exceptions.dart';
import 'package:client/infrastructure/common/exception.dart';
import 'package:client/infrastructure/role/data_providers/role_api.dart';
import 'package:client/utils/either.dart';
import 'package:client/utils/failure.dart';

class RoleRepository implements IRoleRepository {
  final RoleApi _roleApi;

  RoleRepository({RoleApi? api}) : _roleApi = api ?? RoleApi();

  @override
  Future<Either<Role>> createRole(
      RoleForm role, int groupId, String token) async {
    try {
      final newRole = await _roleApi.createRole(groupId, role, token);
      return Either(value: newRole);
    } on BCHttpException catch (error) {
      return Either(failure: Failure(error.message));
    } on AuthenticationFailure catch (error) {
      return Either(failure: Failure(error.message));
    } catch (error) {
      return Either(failure: Failure(error.toString()));
    }
  }

  @override
  Future<Either<Role>> updateRole(
      RoleForm role, int groupId, String token) async {
    try {
      final updatedRole = await _roleApi.updateRole(groupId, role, token);
      return Either(value: updatedRole);
    } on BCHttpException catch (error) {
      return Either(failure: Failure(error.message));
    } on AuthenticationFailure catch (error) {
      return Either(failure: Failure(error.message));
    } catch (error) {
      return Either(failure: Failure(error.toString()));
    }
  }

  @override
  Future<Either<bool>> deleteRole(int roleId, int groupId, String token) async {
    try {
      await _roleApi.deleteRole(groupId, roleId, token);
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
