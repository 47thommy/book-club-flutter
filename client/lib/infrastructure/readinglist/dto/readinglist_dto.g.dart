// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'readinglist_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ReadinglistDto _$$_ReadinglistDtoFromJson(Map<String, dynamic> json) =>
    _$_ReadinglistDto(
      id: json['id'] as int,
      book: BookDto.fromJson(json['book'] as Map<String, dynamic>),
      group: GroupDto.fromJson(json['group'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ReadinglistDtoToJson(_$_ReadinglistDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'book': instance.book,
      'group': instance.group,
    };
