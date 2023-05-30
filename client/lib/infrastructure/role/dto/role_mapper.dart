import 'package:client/domain/role/permission.dart';
import 'package:client/domain/role/role.dart';
import 'package:client/infrastructure/role/role.dart';

extension RoleMapper on Role {
  RoleDto toRoleDto() {
    return RoleDto(
      id: id,
      name: name,
      permissions: permissions
          .map<PermissionDto>((permission) => permission.toPermissionDto())
          .toList(),
    );
  }
}

extension RoleDtoMapper on RoleDto {
  Role toRole() {
    return Role(
      id: id,
      name: name,
      permissions: permissions
          .map<Permission>((permissionDto) => permissionDto.toPermission())
          .toList(),
    );
  }
}
