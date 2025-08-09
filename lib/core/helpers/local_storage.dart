import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDB {
  static Database? _db;

  static Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  static Future<Database> initDb() async {
    final path = join(await getDatabasesPath(), 'app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, _) async {
        await db.execute(
          'CREATE TABLE pin(id INTEGER PRIMARY KEY, value TEXT)',
        );
        await db.execute(
          'CREATE TABLE user_info(id TEXT PRIMARY KEY, name TEXT, email TEXT)',
        );
      },
    );
  }

  static Future<void> savePin(String pin) async {
    final dbClient = await db;
    await dbClient.insert('pin', {
      'id': 1,
      'value': pin,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<String?> getPin() async {
    final dbClient = await db;
    final result = await dbClient.query('pin', where: 'id = ?', whereArgs: [1]);
    if (result.isNotEmpty) {
      return result.first['value'] as String;
    }
    return null;
  }

  static Future<void> saveUserInfo(String id, String firstName, String lastName, String email, String mobileNumber) async {
    final dbClient = await db;
    await dbClient.insert('user_info', {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'mobileNumber': mobileNumber,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<Map<String, dynamic>?> getUserInfo(String id) async {
    final dbClient = await db;
    final result = await dbClient.query(
      'user_info',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) return result.first;
    return null;
  }

  static Future<void> updatePin(String pin) async {
    final dbClient = await db;
    await dbClient.update(
      'pin',
      {'value': pin},
      where: 'id = ?',
      whereArgs: [1],
    );
  }
}
