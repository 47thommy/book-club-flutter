import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_role.freezed.dart';
part 'user_role.g.dart';

@freezed
class RoleDto with _$RoleDto {
  const RoleDto._();

  const factory RoleDto(
    {required int id, required String name}) = _RoleDto;

  factory RoleDto.fromJson(Map<String, dynamic> json) =>
      _$RoleDtoFromJson(json);
}
