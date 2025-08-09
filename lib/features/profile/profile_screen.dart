import 'package:flutter/material.dart';
import 'package:maverick_app/widgets/appbar.dart';

import 'components/edit_profile_fab.dart';
import 'components/profile_screen_body.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = '/profile';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: sharedAppBar(context, 'Profile', false),
      body: ProfileScreenBody(),
      floatingActionButton: EditProfileFAB(),
    );
  }
}
