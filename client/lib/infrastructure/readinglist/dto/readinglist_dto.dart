import 'package:client/infrastructure/book/dto/book_dto.dart';
import 'package:client/infrastructure/group/dto/group_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'readinglist_dto.freezed.dart';
part 'readinglist_dto.g.dart';

@freezed
class ReadingListDto with _$ReadinglistDto {
  const ReadingListDto._();

  const factory ReadingListDto(
      {required int id,
      required BookDto book,
      required GroupDto group}) = _ReadinglistDto;

  factory ReadingListDto.fromJson(Map<String, dynamic> json) =>
      _$ReadinglistDtoFromJson(json);
}
