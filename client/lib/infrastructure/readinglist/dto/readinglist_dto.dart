import 'package:client/infrastructure/book/dto/book_dto.dart';
import 'package:client/infrastructure/group/dto/group_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'readinglist_dto.freezed.dart';
part 'readinglist_dto.g.dart';

@freezed
class ReadinglistDto with _$ReadinglistDto {
  const ReadinglistDto._();

  const factory ReadinglistDto(
      {required int id,
      required BookDto book,
      required GroupDto group}) = _ReadinglistDto;

  factory ReadinglistDto.fromJson(Map<String, dynamic> json) => _$ReadinglistDtoFromJson(json);
}
