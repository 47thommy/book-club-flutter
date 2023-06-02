import 'dart:convert';
import 'dart:developer';

import 'package:client/data/local/database_helper.dart';
import 'package:client/infrastructure/meeting/dto/meeting_dto.dart';

import 'package:client/utils/either.dart';
import 'package:client/utils/failure.dart';
import 'package:sqflite/sqflite.dart';

class MeetingCacheClient {
  final _storage = DatabaseHelper();

  Future<Either<MeetingDto>> get(int id) async {
    final db = await _storage.database;
    final result = await db
        .query(DatabaseHelper.meetingTable, where: 'id = ?', whereArgs: [id]);

    if (result.isEmpty) return Either(failure: const Failure('Not Found'));

    final meetingJson = jsonDecode(result[0]['detail'] as String);

    return Either(value: MeetingDto.fromJson(meetingJson));
  }

  Future<void> save(MeetingDto meeting) async {
    final db = await _storage.database;

    final meetingEncoded = jsonEncode(meeting.toJson());

    await db.insert(DatabaseHelper.meetingTable,
        {'id': meeting.id, 'detail': meetingEncoded},
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
