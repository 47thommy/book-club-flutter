// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PollDto _$$_PollDtoFromJson(Map<String, dynamic> json) => _$_PollDto(
      id: json['id'] as int,
      question: json['question'] as String,
      options:
          (json['options'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_PollDtoToJson(_$_PollDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'options': instance.options,
    };
