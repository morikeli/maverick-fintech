import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maverick_app/widgets/appbar.dart';
import '../../controllers/profile_controller.dart';
import 'widgets/edit_profile_form.dart';

class EditProfileScreen extends StatelessWidget {
  static String routeName = '/edit-profile';
  EditProfileScreen({super.key});

  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: sharedAppBar(context, 'Edit profile', true),
      body: EditProfileForm(controller: profileController),
    );
  }
}
