// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BookDto _$$_BookDtoFromJson(Map<String, dynamic> json) => _$_BookDto(
      id: json['id'] as int,
      title: json['title'] as String,
      author: json['author'] as String,
      description: json['description'] as String,
      pageCount: json['pageCount'] as int,
      genre: json['genre'] as String,
    );

Map<String, dynamic> _$$_BookDtoToJson(_$_BookDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'author': instance.author,
      'description': instance.description,
      'pageCount': instance.pageCount,
      'genre': instance.genre,
    };
