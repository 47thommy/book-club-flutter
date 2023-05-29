import 'package:client/infrastructure/role/permission_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'role_dto.freezed.dart';
part 'role_dto.g.dart';

@freezed
class RoleDto with _$RoleDto {
  const RoleDto._();

  static const empty = RoleDto(id: -1, name: '', permissions: []);

  const factory RoleDto(
      {required int id,
      required String name,
      required List<PermissionDto> permissions}) = _RoleDto;

  factory RoleDto.fromJson(Map<String, dynamic> json) =>
      _$RoleDtoFromJson(json);
}
