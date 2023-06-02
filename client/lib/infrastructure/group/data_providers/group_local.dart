import 'dart:convert';
import 'dart:developer';

import 'package:client/data/local/database_helper.dart';

import 'package:client/infrastructure/group/dto/group_dto.dart';

import 'package:client/utils/either.dart';
import 'package:client/utils/failure.dart';
import 'package:sqflite/sqflite.dart';

class GroupCacheClient {
  final _storage = DatabaseHelper();

  Future<Either<GroupDto>> get(int id) async {
    final db = await _storage.database;
    final result = await db
        .query(DatabaseHelper.groupTable, where: 'id = ?', whereArgs: [id]);

    if (result.isEmpty) return Either(failure: const Failure('Not found'));

    final groupJson = jsonDecode(result[0]['detail'] as String);

    return Either(value: GroupDto.fromJson(groupJson));
  }

  Future<Either<List<GroupDto>>> getAll() async {
    final db = await _storage.database;
    final result = await db.query(DatabaseHelper.groupTable);

    if (result.isEmpty) return Either(failure: const Failure('Not found'));

    final value = result.map((row) {
      final groupJson = jsonDecode(row['detail'] as String);

      return GroupDto.fromJson(groupJson);
    }).toList();

    return Either(value: value);
  }

  Future<Either<List<GroupDto>>> getJoined() async {
    final db = await _storage.database;
    final result = await db
        .query(DatabaseHelper.groupTable, where: 'joined = ?', whereArgs: [1]);

    if (result.isEmpty) return Either(failure: const Failure('Not found'));

    final value = result.map((row) {
      final groupJson = jsonDecode(row['detail'] as String);
      return GroupDto.fromJson(groupJson);
    }).toList();

    return Either(value: value);
  }

  Future<void> save(GroupDto group, [bool joined = false]) async {
    final db = await _storage.database;

    final groupEncoded = jsonEncode(group.toJson());

    await db.insert(DatabaseHelper.groupTable,
        {'id': group.id, 'detail': groupEncoded, 'joined': joined ? 1 : 0},
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> clear() async {}
}
