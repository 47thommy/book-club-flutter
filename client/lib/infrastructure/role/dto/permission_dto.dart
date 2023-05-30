import 'package:client/domain/role/permission.dart';
import 'package:client/infrastructure/role/dto/permission_mapper.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'permission_dto.freezed.dart';
part 'permission_dto.g.dart';

@freezed
class PermissionDto with _$PermissionDto {
  const PermissionDto._();

  // static const empty = PermissionDto(id: -1, name: '');
  static final all =
      Permission.all.map((permission) => permission.toPermissionDto()).toList();

  const factory PermissionDto({required int id, required String name}) =
      _PermissionDto;

  factory PermissionDto.fromJson(Map<String, dynamic> json) =>
      _$PermissionDtoFromJson(json);
}
