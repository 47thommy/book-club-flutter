import 'package:equatable/equatable.dart';

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
