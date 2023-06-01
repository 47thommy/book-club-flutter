import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// part 'book_dto.freezed.dart';
// part 'book_dto.g.dart';

class BookDto extends Equatable {
  final int id;
  final String title;
  final String author;
  final String description;
  final int pageCount;
  final String genre;

  const BookDto({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.pageCount,
    required this.genre,
  });

  factory BookDto.fromJson(Map<String, dynamic> json) {
    return BookDto(
        id: json['id'],
        title: json['title'],
        author: json['author'],
        description: json['description'],
        pageCount: json['pageCount'],
        genre: json['genre']);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'author': author,
      'description': description,
      'pageCount': pageCount,
      'genre': genre
    };
  }

  @override
  List<Object?> get props => [id, title, author, description, pageCount, genre];
}


// @freezed
// class BookDto with _$BookDto {
//   const BookDto._();

//   const factory BookDto(
//       {required int id,
//       required String title,
//       required String author,
//       required String description,
//       required int pageCount,
//       required String genre,}) = _BookDto;

//   factory BookDto.fromJson(Map<String, dynamic> json) => _$BookDtoFromJson(json);
// }
 