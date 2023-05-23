import "package:path/path.dart";
import "package:sqflite/sqflite.dart";
import "constants.dart" as consts;

class DbHelper {
  final int version = 1;

  static final DbHelper _dbHelper = DbHelper._();

  DbHelper._();

  factory DbHelper() {
    return _dbHelper;
  }

  Database? db;

  Future<Database> openDb() async {
    var dbPath = join(await getDatabasesPath(), consts.databaseName);

    db ??= await openDatabase(dbPath, onCreate: (database, version) {
      database.execute(
          'CREATE TABLE IF NOT EXISTS user(id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, token TEXT)');
    }, version: version);

    return db!;
  }

  Future testDb() async {
    print("<<<<test db");
    var db = await openDb();
    await db.execute("DELETE FROM user WHERE 1=1");
    await db.execute(
        'INSERT INTO user VALUES (0, "User", "Name", "Email", "token")');

    List users = await db.rawQuery('select * from user');

    await db.execute("DELETE FROM user WHERE 1=1");

    users = await db.rawQuery('select * from user');
    print(users);
  }

  Future showDb() async {
    var db = await openDb();
    List users = await db.rawQuery('select * from user');
    print(users);
  }
}
