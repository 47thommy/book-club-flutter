import 'package:client/user/data_providers/data_providers.dart';
import 'package:client/user/models/user.dart';
import 'package:sqflite/sqflite.dart';

import '../../utils/db.dart';

class LocalUserDataProvider {
  final _tableName = "user";

  final dbHelper = DbHelper();

  Future<User> getLoggedInUser() async {
    final db = await dbHelper.openDb();

    final result = await db.query(_tableName);

    if (result.isEmpty) throw Exception("User not logged in.");

    final user = User.fromJson(result[0]);

    return user;
  }

  Future<int> saveUser(User user) async {
    final db = await dbHelper.openDb();

    // we should clear previous user while logging new one
    await db.delete(_tableName);

    final id = await db.insert(_tableName, user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    return id;
  }
}
