import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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


  Future<void> uploadProfilePicture(String uid) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return; // User cancelled

    isLoading.value = true;

    try {
      File file = File(pickedFile.path);

      // Upload to Firebase Storage
      final ref = FirebaseStorage.instance
          .ref()
          .child('profile_pictures')
          .child('$uid.jpg');

      await ref.putFile(file);

      // Get the download URL
      final imageUrl = await ref.getDownloadURL();

      // Save to Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'profilePicture': imageUrl,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Update in-memory user model
      user.value = user.value?.copyWith(profilePicture: imageUrl);

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
