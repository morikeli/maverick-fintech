import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<UserModel?> login(String email, String password) async {
    final result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = result.user;
    if (user != null) {
      return UserModel(uid: user.uid, email: user.email!);
    }
    return null;
  }

  Future<UserModel?> signup(String firstName, String lastName, String email, String mobileNumber, String password) async {
    final result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = result.user;
    if (user != null) {
      final userData = {
        'uid': user.uid,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'mobileNumber': mobileNumber,
        'createdAt': FieldValue.serverTimestamp(),
      };

      // Save additional user data in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set(userData);


      // create a default wallet for the user
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('wallet')
          .doc('balance')
          .set({'amount': 500.0}); // default balance

      return UserModel(uid: user.uid, email: user.email!);
    }
    return null;
  }

  Future<void> resetPassword(String email) =>
      _auth.sendPasswordResetEmail(email: email);

  Future<void> logout() async {
    await _auth.signOut();
    Get.deleteAll();
  }
}
