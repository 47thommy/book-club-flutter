// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MeetingDto _$$_MeetingDtoFromJson(Map<String, dynamic> json) =>
    _$_MeetingDto(
      id: json['id'] as int,
      description: json['description'] as String,
      time: json['time'] as String,
      location: json['location'] as String,
      creator: UserDto.fromJson(json['creator'] as Map<String, dynamic>),
      group: GroupDto.fromJson(json['group'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_MeetingDtoToJson(_$_MeetingDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'time': instance.time,
      'location': instance.location,
      'creator': instance.creator,
      'group': instance.group,
    };
