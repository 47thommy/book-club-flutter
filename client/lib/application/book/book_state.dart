import 'package:client/domain/book/book.dart';
import 'package:client/utils/failure.dart';
import 'package:equatable/equatable.dart';

abstract class BookState extends Equatable {
  const BookState();

  @override
  List<Object?> get props => [];
}

class BookInit extends BookState {}

class BookCreated extends BookState {
  final Book book;
  final int groupId;

  const BookCreated(this.book, this.groupId);

  @override
  List<Object?> get props => [book];
}

class BookUpdated extends BookState {
  final Book book;

  const BookUpdated(this.book);

  @override
  List<Object?> get props => [book];
}

class BookDeleted extends BookState {
  final int bookId;

  const BookDeleted(this.bookId);

  @override
  List<Object?> get props => [bookId];
}

class BookOperationFailure extends BookState {
  final Failure error;

  const BookOperationFailure(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'BookOperationFailure { error: $error }';
}
