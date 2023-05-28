import 'package:client/domain/role/permission.dart';
import 'package:client/infrastructure/role/permission_dto.dart';

extension PermissionMapper on Permission {
  PermissionDto toPermissionDto() {
    return PermissionDto(
      id: id,
      name: name,
    );
  }
}

extension PermissionDtoMapper on PermissionDto {
  Permission toPermission() {
    return Permission(
      id: id,
      name: name,
    );
  }
}
