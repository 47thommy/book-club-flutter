import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:client/common/constants.dart';
import 'package:client/domain/book/book.dart';
import 'package:client/domain/book/book_form.dart';
import 'package:client/domain/book/book_repository_interface.dart';
import 'package:client/infrastructure/auth/exceptions.dart';
import 'package:client/infrastructure/book/dto/book_dto.dart';
import 'package:client/infrastructure/book/dto/book_mapper.dart';
import 'package:client/infrastructure/common/exception.dart';
import 'package:client/utils/either.dart';
import 'package:http/http.dart' as http;

import 'package:client/common/constants.dart' as consts;

class BookApi implements IBookRepository {
  late http.Client _client;

  final baseUrl = '${consts.apiUrl}/book';

  BookApi({http.Client? client}) {
    _client = client ?? http.Client();
  }

  Future<BookDto> getBook(int id, String token) async {
    final bookUri = Uri.parse('$baseUrl?id=$id');

    final http.Response response = await _client.get(
      bookUri,
      headers: <String, String>{
        "Content-Type": "application/json",
        'token': token
      },
    ).timeout(connectionTimeoutLimit);

    if (response.statusCode == HttpStatus.ok) {
      final json = jsonDecode(response.body);

      return BookDto.fromJson(json);
    } else if (response.statusCode == HttpStatus.notFound) {
      throw BCHttpException.notFound();
    } else if (response.statusCode == HttpStatus.unauthorized) {
      throw Exception("Unauthorized");
    }
    throw const BCHttpException();
  }

  @override
  Future<Either<Book>> createBook(Book book, int groupId, String token) async {
    final bookUri = Uri.parse(baseUrl);

    final http.Response response = await _client
        .post(bookUri,
            headers: <String, String>{
              "Content-Type": "application/json",
              'token': token,
            },
            body: jsonEncode(book.toBookDto().toJson()))
        .timeout(connectionTimeoutLimit);

    if (response.statusCode == HttpStatus.created) {
      final json = jsonDecode(response.body);

      return Either(value: BookDto.fromJson(json).toBook());
    } else if (response.statusCode == HttpStatus.unauthorized) {
      throw AuthenticationFailure.sessionExpired();
    }
    throw const BCHttpException();
  }

  @override
  Future<Either<Book>> updateBook(Book book, int groupId, String token) async {
    final bookUri = Uri.parse('$baseUrl/${book.id}');

    final http.Response response = await _client
        .put(bookUri,
            headers: <String, String>{
              "Content-Type": "application/json",
              'token': token
            },
            body: jsonEncode(book.toBookDto().toJson()))
        .timeout(connectionTimeoutLimit);

    if (response.statusCode == HttpStatus.ok) {
      final json = jsonDecode(response.body);

      return Either(value: BookDto.fromJson(json).toBook());
    } else if (response.statusCode == HttpStatus.unauthorized) {
      throw AuthenticationFailure.sessionExpired();
    }
    throw const BCHttpException();
  }

  Future<Either<bool>> deleteBook(int bookId, int groupId, String token) async {
    final bookuri = Uri.parse('$baseUrl/$bookId');
    final http.Response response = await _client.delete(
      bookuri,
      headers: <String, String>{
        "Content-Type": "application/json",
        'token': token
      },
    ).timeout(connectionTimeoutLimit);

    if (response.statusCode == HttpStatus.ok) {
      final json = jsonDecode(response.body);

      return Either(value: true);
    } else if (response.statusCode == HttpStatus.unauthorized) {
      throw AuthenticationFailure.sessionExpired();
    } else if (response.statusCode == HttpStatus.notFound) {
      throw BCHttpException.notFound();
    }
    throw const BCHttpException();
  }
}
