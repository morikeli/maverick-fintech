import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBService {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB('wallet.db');
    return _db!;
  }

  static Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  static Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE transactions (
        uid INTEGER PRIMARY KEY AUTOINCREMENT,
        type TEXT,
        amount REAL,
        contact TEXT,
        timestamp TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE user (
        uid INTEGER PRIMARY KEY,
        firstName TEXT,
        lastName TEXT,
        email TEXT,
        mobileNumber TEXT
      )
    ''');
  }
}
