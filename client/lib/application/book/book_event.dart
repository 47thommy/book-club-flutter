import 'package:client/domain/book/book.dart';
import 'package:equatable/equatable.dart';

abstract class BookEvent extends Equatable {
  const BookEvent();

  @override
  List<Object?> get props => [];
}

class BookCreate extends BookEvent {
  final Book book;
  final int groupId;

  const BookCreate(this.book, this.groupId);

  @override
  List<Object?> get props => [book];

  @override
  String toString() => 'book create { book: $book }';
}

class BookUpdate extends BookEvent {
  final Book book;
  final int groupId;

  const BookUpdate(this.book, this.groupId);

  @override
  List<Object?> get props => [book, groupId];

  @override
  String toString() => 'book update { book: ${book.id} }';
}

class BookDelete extends BookEvent {
  final int bookId;
  final int groupId;

  const BookDelete(this.bookId, this.groupId);

  @override
  List<Object?> get props => [bookId, groupId];

  @override
  String toString() => 'book delete { book_id: $bookId }';
}
