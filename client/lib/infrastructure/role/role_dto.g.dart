// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RoleDto _$$_RoleDtoFromJson(Map<String, dynamic> json) => _$_RoleDto(
      id: json['id'] as int,
      name: json['name'] as String,
      permissions: (json['permissions'] as List<dynamic>)
          .map((e) => PermissionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_RoleDtoToJson(_$_RoleDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'permissions': instance.permissions,
    };
