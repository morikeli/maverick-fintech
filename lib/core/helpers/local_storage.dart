import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
          'CREATE TABLE pin(uid TEXT PRIMARY KEY, value TEXT)',
        );
        await db.execute(
          'CREATE TABLE user_info(uid TEXT PRIMARY KEY, firstName TEXT, lastName TEXT, email TEXT, mobileNumber TEXT)',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute("ALTER TABLE user_info ADD COLUMN firstName TEXT");
          await db.execute("ALTER TABLE user_info ADD COLUMN lastName TEXT");
          await db.execute(
            "ALTER TABLE user_info ADD COLUMN mobileNumber TEXT",
          );
        }
      },
    );
  }

  /// Hash PIN before storing
  static String _hashPin(String pin) {
    final bytes = utf8.encode(pin);
    final hash = sha512.convert(bytes); // hash password using SHA512
    return hash.toString();
  }

  static Future<void> savePin(String uid, String pin) async {
    final dbClient = await db;
    final hashedPin = _hashPin(pin);
    await dbClient.insert(
      'pin',
      {'uid': uid, 'value': hashedPin}, // use 'uid' instead of 'id'
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<String?> getPin(String uid) async {
    final dbClient = await db;
    final result = await dbClient.query(
      'pin',
      where: 'uid = ?',
      whereArgs: [uid],
    );
    if (result.isNotEmpty) {
      return result.first['value'] as String;
    }
    return null;
  }

  static Future<bool> verifyPin(String uid, String pin) async {
    final storedHashedPin = await getPin(uid);
    if (storedHashedPin == null) return false;
    return storedHashedPin == _hashPin(pin);
  }

  static Future<void> updatePin(String uid, String pin) async {
    final dbClient = await db;
    final hashedPin = _hashPin(pin);
    await dbClient.update(
      'pin',
      {'value': hashedPin},
      where: 'uid = ?',
      whereArgs: [uid],
    );
  }

  static Future<void> saveUserInfo(
    String id,
    String firstName,
    String lastName,
    String email,
    String mobileNumber,
  ) async {
    final dbClient = await db;
    await dbClient.insert('user_info', {
      'uid': id,
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
      where: 'uid = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) return result.first;
    return null;
  }
}
