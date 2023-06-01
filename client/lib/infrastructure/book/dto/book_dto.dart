import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_dto.freezed.dart';
part 'book_dto.g.dart';

@freezed
class BookDto with _$BookDto {
  const BookDto._();

  const factory BookDto(
      {required int id,
      required String title,
      required String author,
      required String description,
      required int pageCount,
      required String genre,}) = _BookDto;

  factory BookDto.fromJson(Map<String, dynamic> json) => _$BookDtoFromJson(json);
}
 