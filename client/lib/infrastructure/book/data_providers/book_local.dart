import 'dart:convert';
import 'dart:developer';

import 'package:client/data/local/database_helper.dart';
import 'package:client/infrastructure/book/dto/book_dto.dart';

import 'package:client/utils/either.dart';
import 'package:client/utils/failure.dart';
import 'package:sqflite/sqflite.dart';

class BookCacheClient {
  final _storage = DatabaseHelper();

  Future<Either<BookDto>> get(int id) async {
    final db = await _storage.database;
    final result = await db
        .query(DatabaseHelper.bookTable, where: 'id = ?', whereArgs: [id]);

    if (result.isEmpty) return Either(failure: const Failure('Not Found'));

    final bookJson = jsonDecode(result[0]['detail'] as String);

    return Either(value: BookDto.fromJson(bookJson));
  }

  Future<void> save(BookDto book) async {
    final db = await _storage.database;

    final bookEncoded = jsonEncode(book.toJson());

    await db.insert(
        DatabaseHelper.meetingTable, {'id': book.id, 'detail': bookEncoded},
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
