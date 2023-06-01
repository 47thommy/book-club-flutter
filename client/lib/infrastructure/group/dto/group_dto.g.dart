// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GroupDto _$$_GroupDtoFromJson(Map<String, dynamic> json) => _$_GroupDto(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      creator: UserDto.fromJson(json['creator'] as Map<String, dynamic>),
      members: (json['members'] as List<dynamic>)
          .map((e) => UserDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      roles: (json['roles'] as List<dynamic>)
          .map((e) => RoleDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      polls: (json['polls'] as List<dynamic>)
          .map((e) => PollDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_GroupDtoToJson(_$_GroupDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'creator': instance.creator,
      'members': instance.members,
      'roles': instance.roles,
      'polls': instance.polls,
    };
