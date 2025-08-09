import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../controllers/profile_controller.dart';
import '../../../core/theme/colors.dart';
import 'custom_list_tile.dart';

class ProfileScreenBody extends StatelessWidget {
  ProfileScreenBody({super.key});

  final AuthController authController = Get.put(AuthController());
  final ProfileController profileController = Get.put(ProfileController());

  void confirmLogout() {
    Get.defaultDialog(
      title: 'Logout',
      middleText: 'Are you sure you want to logout?',
      textConfirm: 'Logout',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      onConfirm: () async {
        await authController.logout();
        Get.offAllNamed('/login');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool isDark = profileController.isDarkMode.value;
      final userName = profileController.userName.value;

      return ListView(
        padding: EdgeInsets.all(12.0),
        children: [
          // 1. profile picture
          userProfilePicture(context),

          // 2. username
          SizedBox(height: 8.0),
          userNameAndLocation(context, userName),
          SizedBox(height: 8.0),
          editProfileAndResetPINBtns(),
          SizedBox(height: 8.0),
          CustomListTileWidget(
            leadingIcon: BootstrapIcons.person_add,
            titleText: 'Invite friends',
            subtitleText: 'Get \$5 for every 4 referrals',
            trailingIcon: BootstrapIcons.chevron_right,
          ),

          // 3. Options header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              'Account & settings',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 16.0,
                color: kTextSecondaryColor,
              ),
            ),
          ),

          // 4. Account list tile
          CustomListTileWidget(
            leadingIcon: BootstrapIcons.person,
            titleText: 'Account',
            subtitleText: 'User info, saved passwords',
            trailingIcon: BootstrapIcons.chevron_right,
          ),

          // 5. linked banks list tile
          CustomListTileWidget(
            leadingIcon: BootstrapIcons.link,
            titleText: 'Linked banks',
            subtitleText: 'Manage your connected bank accounts',
            trailingIcon: BootstrapIcons.chevron_right,
          ),

          // 6. notifications list tile
          CustomListTileWidget(
            leadingIcon: BootstrapIcons.bell,
            titleText: 'Notifications',
            subtitleText: 'Control alerts and app notifications',
            trailingIcon: BootstrapIcons.chevron_right,
          ),

          // 7. privacy & security list tile
          CustomListTileWidget(
            leadingIcon: BootstrapIcons.shield,
            titleText: 'Privacy & Security',
            subtitleText: 'Manage privacy settings and security',
            trailingIcon: BootstrapIcons.chevron_right,
          ),

          // 8. light/dark mode toggle switch
          ListTile(
            leading: Icon(isDark ? BootstrapIcons.moon : BootstrapIcons.sun),
            title: Text(isDark ? 'Light mode' : 'Dark mode'),
            trailing: Transform.scale(
              scale: .8,
              child: Switch(
                value: isDark,
                onChanged: (value) => profileController.toggleTheme(),
              ),
            ),
          ),

          // Danger zone header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              'Danger zone',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 16.0,
                color: kTextSecondaryColor,
              ),
            ),
          ),
          // 9. Logout button
          ElevatedButton(
            onPressed: () async => confirmLogout(),
            style: ElevatedButton.styleFrom(backgroundColor: kDangerColor, padding: EdgeInsets.symmetric(horizontal: 12.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(BootstrapIcons.door_open), Text('Logout')],
            ),
          ),
        ],
      );
    });
  }

  Row editProfileAndResetPINBtns() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // 1. Edit profile btn
        Expanded(
          child: ElevatedButton(onPressed: () {}, child: Text('Edit profile')),
        ),
        SizedBox(width: 12.0),

        // 2. Reset PIN btn
        Expanded(
          child: ElevatedButton(onPressed: () {}, child: Text('Reset PIN')),
        ),
      ],
    );
  }

  Center userNameAndLocation(BuildContext context, String userName) {
    return Center(
      child: Column(
        children: [
          Text('Test user', style: Theme.of(context).textTheme.bodyLarge),
          Text('Nairobi, Kenya', style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }

  Center userProfilePicture(BuildContext context) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            radius: MediaQuery.of(context).size.width * .16,
            backgroundImage: AssetImage('assets/imgs/8.jpg'),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: IconButton.filled(
              onPressed: () {},
              icon: Icon(
                BootstrapIcons.camera,
                color: kIconLightColor,
                size: 20.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
