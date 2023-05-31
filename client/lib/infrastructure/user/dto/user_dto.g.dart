// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserDto _$$_UserDtoFromJson(Map<String, dynamic> json) => _$_UserDto(
      id: json['id'] as int,
      email: json['email'] as String,
      username: json['username'] as String,
      bio: json['bio'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      role: json['role'] == null
          ? RoleDto.empty
          : RoleDto.fromJson(json['role'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_UserDtoToJson(_$_UserDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'username': instance.username,
      'bio': instance.bio,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'role': instance.role,
    };
