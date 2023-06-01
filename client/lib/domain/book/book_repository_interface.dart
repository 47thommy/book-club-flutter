import 'package:client/domain/book/book.dart';
import 'package:client/utils/either.dart';

abstract class IBookRepository {
  Future<Either<Book>> createBook(Book book, int groupId, String token);
  Future<Either<Book>> updateBook(Book book, int groupId, String token);
  Future<Either<bool>> deleteBook(int bookId, int groupId, String token);
}
