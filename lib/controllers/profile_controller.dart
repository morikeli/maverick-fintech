import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/helpers/local_storage.dart';
import '../models/user_model.dart';

class ProfileController extends GetxController {
  Rxn<UserModel> user = Rxn<UserModel>();
  RxBool isLoading = false.obs;
  RxBool isDarkMode = false.obs;
  RxString userName = ''.obs;
  RxnString errorMessage = RxnString();

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    loadUser(FirebaseAuth.instance.currentUser!.uid);
  }

  Future<void> loadUser(String uid) async {
    // final data = await LocalDB.getUserInfo(uid);
    // if (data != null) {
    //   user.value = UserModel.fromMap(data);
    // }

    isLoading.value = true;

    try {
      // Get user profile (first + last name) from Firestore
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      if (doc.exists) {
        final data = doc.data()!;
        final firstName = data['firstName'] ?? '';
        final lastName = data['lastName'] ?? '';
        userName.value = "$firstName $lastName".trim();
        user.value = UserModel.fromMap(data);
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateUser(
    String uid,
    String firstName,
    String lastName,
    String email,
    String mobileNumber,
  ) async {
    isLoading.value = true;
    try {
      // update user info in local storage
      // await LocalDB.saveUserInfo(uid, firstName, lastName, email, mobileNumber);
      // user.value = UserModel(
      //   uid: uid,
      //   firstName: firstName,
      //   lastName: lastName,
      //   email: email,
      //   mobileNumber: mobileNumber,
      // );

      // Update Firestore user document
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'mobileNumber': mobileNumber,
        'updatedAt':
            FieldValue.serverTimestamp(), // optional for tracking updates
      });
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updatePin(String pin) async {
    await LocalDB.updatePin(pin);
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}
