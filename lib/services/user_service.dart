import '../models/user_model.dart';
import 'db_service.dart';

class UserService {
  Future<UserModel?> getUser() async {
    final db = await DBService.database;
    final res = await db.query('user', where: 'uid = ?', whereArgs: [1]);

    if (res.isNotEmpty) return UserModel.fromMap(res.first);
    return null;
  }

  Future<void> updateUser(UserModel user) async {
    final db = await DBService.database;
    final exists = await getUser();
    if (exists == null) {
      await db.insert('user', user.toMap());
    } else {
      await db.update('user', user.toMap(), where: 'uid = ?', whereArgs: [user.uid]);
    }
  }
}
