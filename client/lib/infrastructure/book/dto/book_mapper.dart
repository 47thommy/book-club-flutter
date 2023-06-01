import 'package:client/domain/book/book.dart';
import 'package:client/infrastructure/book/dto/book_dto.dart';

extension BookMapper on Book {
  BookDto toBookDto() {
    return BookDto(
        id: id,
        title: title,
        description: description,
        author: author,
        genre: genre,
        pageCount: pageCount);
  }
}

extension BookDtoMapper on BookDto {
  Book toBook() {
    return Book(
        id: id,
        title: title,
        description: description,
        author: author,
        genre: genre,
        pageCount: pageCount);
  }
}
