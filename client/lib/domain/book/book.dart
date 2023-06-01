import 'package:equatable/equatable.dart';

class Book extends Equatable {
  final int id;
  final String title;
  final String author;
  final String description;
  final int pageCount;
  final String genre;

  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.pageCount,
    required this.genre,
  });

  @override
  List<Object?> get props => [id, title, description, author, pageCount, genre];
}
