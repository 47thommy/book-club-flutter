import "package:path/path.dart";
import "package:sqflite/sqflite.dart";
import 'package:client/common/constants.dart' as consts;

class DatabaseHelper {
  final int version = 1;

  // Table names
  static const fileTable = 'images';
  static const bookTable = 'book';
  static const groupTable = 'grouptable';
  static const meetingTable = 'meeting';
  static const scheduleTable = 'schedule';
  static const readinglistTable = 'readinglist';

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

  Future<void> _onCreate(Database db, int version) async {
    // image cache
    await db.execute('''
      CREATE TABLE $fileTable (
        image_url TEXT PRIMARY KEY,
        data BLOB
      )''');

    // groups cache
    await db.execute('''
      CREATE TABLE $groupTable (
        id INTEGER PRIMARY KEY,
        detail TEXT,  
        joined INTEGER              
      )''');

    // Reading list cache
    await db.execute('''
      CREATE TABLE $readinglistTable (
        id INTEGER PRIMARY KEY                
      )''');
  
    // Meeting cache
    await db.execute('''
      CREATE TABLE $meetingTable (
        id INTEGER PRIMARY KEY,
        details TEXT
      )''');
      
    // Book cache
    await db.execute('''
      CREATE TABLE $bookTable (
        id INTEGER PRIMARY KEY        
      )''');
  }

  Future<void> dropDatabase() async {
    var path = join(await getDatabasesPath(), consts.databaseName);
    await _database?.close();
    _database = null;
    deleteDatabase(path);
  }
}
