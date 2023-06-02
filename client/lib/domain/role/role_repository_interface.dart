import 'package:client/domain/role/role.dart';
import 'package:client/domain/role/role_form.dart';
import 'package:client/utils/either.dart';

abstract class IRoleRepository {
  Future<Either<Role>> createRole(RoleForm role, int groupId, String token);
  Future<Either<Role>> updateRole(RoleForm role, int groupId, String token);
  Future<Either<bool>> deleteRole(int roleId, int groupId, String token);
  Future<Either<bool>> assignRole(
      {required int roleId,
      required int userId,
      required int groupId,
      required String token});
}
