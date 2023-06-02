import 'dart:developer';

import 'package:client/domain/book/book.dart';
import 'package:client/domain/book/book_form.dart';
import 'package:client/domain/book/book_repository_interface.dart';
import 'package:client/infrastructure/auth/exceptions.dart';
import 'package:client/infrastructure/book/dto/book_mapper.dart';
import 'package:client/infrastructure/common/exception.dart';
import 'package:client/infrastructure/book/data_providers/book_api.dart';
import 'package:client/utils/either.dart';
import 'package:client/utils/failure.dart';

class BookRepository implements IBookRepository {
  final BookApi _bookApi;

  BookRepository({BookApi? api}) : _bookApi = api ?? BookApi();

  @override
  Future<Either<Book>> createBook(Book book, int groupId, String token) async {
    try {
      final newBook =
          await _bookApi.createBook(book.toBookDto(), groupId, token);

      return Either(value: newBook.toBook());
    } on BCHttpException catch (error) {
      return Either(failure: Failure(error.message));
    } on AuthenticationFailure catch (error) {
      return Either(failure: Failure(error.message));
    } catch (error) {
      return Either(failure: Failure(error.toString()));
    }
  }

  @override
  Future<Either<Book>> updateBook(Book book, int groupId, String token) async {
    try {
      final updatedBook =
          await _bookApi.updateBook(book.toBookDto(), groupId, token);
      return Either(value: updatedBook.toBook());
    } on BCHttpException catch (error) {
      return Either(failure: Failure(error.message));
    } on AuthenticationFailure catch (error) {
      return Either(failure: Failure(error.message));
    } catch (error) {
      return Either(failure: Failure(error.toString()));
    }
  }

  @override
  Future<Either<bool>> deleteBook(int bookId, int groupId, String token) async {
    try {
      await _bookApi.deleteBook(groupId, bookId, token);
      return Either(value: true);
    } on BCHttpException catch (error) {
      return Either(failure: Failure(error.message));
    } on AuthenticationFailure catch (error) {
      return Either(failure: Failure(error.message));
    } catch (error) {
      return Either(failure: Failure(error.toString()));
    }
  }
}
