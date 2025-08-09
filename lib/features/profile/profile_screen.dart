import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maverick_app/widgets/appbar.dart';

import '../../controllers/theme_controller.dart';
import 'components/profile_screen_body.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = '/profile';
  ProfileScreen({super.key});

  final ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: sharedAppBar(context, 'Profile', false),
      body: ProfileScreenBody(),
      floatingActionButton: EditProfileFAB(),
    );
  }
}
