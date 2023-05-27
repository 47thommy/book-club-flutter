import "package:path/path.dart";
import "package:sqflite/sqflite.dart";
import 'package:client/common/constants.dart' as consts;

class DatabaseHelper {
  final int version = 1;

  static final DatabaseHelper instance = DatabaseHelper._private();

  DatabaseHelper._private();

  factory DatabaseHelper() {
    return instance;
  }

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    var path = join(await getDatabasesPath(), consts.databaseName);
    return await openDatabase(path, onCreate: _onCreate, version: version);
  }

  Future _onCreate(Database db, int version) async {
    // image cache
    await db.execute('''
      CREATE TABLE $filetable (
        image_url TEXT PRIMARY KEY,
        data BLOB
      )''');
  }

  // Table names
  static const filetable = 'images';
}
