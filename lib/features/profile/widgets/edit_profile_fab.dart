import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/colors.dart';
import '../edit_profile.dart';

class EditProfileFAB extends StatelessWidget {
  const EditProfileFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Get.to(
        () => EditProfileScreen(),
        transition: Transition.leftToRightWithFade,
        duration: Duration(milliseconds: 1500),
      ),
      child: Icon(BootstrapIcons.person_gear, color: kIconLightColor),
    );
  }
}
