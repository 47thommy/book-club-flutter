import 'dart:convert';

import 'package:client/data/local/database_helper.dart';
import 'package:client/infrastructure/readinglist/dto/readinglist_dto.dart';

import 'package:client/utils/either.dart';
import 'package:client/utils/failure.dart';
import 'package:sqflite/sqflite.dart';

class ReadingListCacheClient {
  final _storage = DatabaseHelper();

  Future<Either<ReadingListDto>> get(int id) async {
    final db = await _storage.database;
    final result = await db.query(DatabaseHelper.readinglistTable,
        where: 'id = ?', whereArgs: [id]);

    if (result.isEmpty) return Either(failure: const Failure('Not Found'));

    final readingListJson = jsonDecode(result[0]['detail'] as String);

    return Either(value: ReadingListDto.fromJson(readingListJson));
  }

  Future<void> save(ReadingListDto readingList) async {
    final db = await _storage.database;

    final readingListEncoded = jsonEncode(readingList.toJson());

    await db.insert(DatabaseHelper.readinglistTable,
        {'id': readingList.id, 'detail': readingListEncoded},
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
