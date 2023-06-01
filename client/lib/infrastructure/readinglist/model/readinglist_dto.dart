import 'package:equatable/equatable.dart';
import 'package:client/infrastructure/book/dto/book_dto.dart';
import 'package:client/infrastructure/group/dto/group_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// part 'readinglist_dto.freezed.dart';
// part 'readinglist_dto.g.dart';

class ReadingListDto extends Equatable {
  final int id;
  final BookDto book;
  final GroupDto group;

  const ReadingListDto({
    required this.id,
    required this.book,
    required this.group,
  });

  factory ReadingListDto.fromJson(Map<String, dynamic> json) {
    return ReadingListDto(
        id: json['id'], 
        
        book: BookDto.fromJson(json['book'] as Map<String, dynamic>),
        
         group: GroupDto.fromJson(json['group'] as Map<String, dynamic>));
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'id': id, 'book': book, 'group': group};
  }

  @override
  List<Object?> get props => [id, book, group];
}

// @freezed
// class ReadingListDto with _$ReadinglistDto {
//   const ReadingListDto._();

//   const factory ReadingListDto(
//       {required int id,
//       required BookDto book,
//       required GroupDto group}) = _ReadinglistDto;

//   factory ReadingListDto.fromJson(Map<String, dynamic> json) =>
//       _$ReadinglistDtoFromJson(json);
// }
