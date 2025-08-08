import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<UserModel?> login(String email, String password) async {
    final result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    final user = result.user;
    if (user != null) {
      return UserModel(uid: user.uid, email: user.email!);
    }
    return null;
  }

  Future<UserModel?> signup(String email, String password) async {
    final result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    final user = result.user;
    if (user != null) {
      return UserModel(uid: user.uid, email: user.email!);
    }
    return null;
  }

  Future<void> resetPassword(String email) => _auth.sendPasswordResetEmail(email: email);
}
