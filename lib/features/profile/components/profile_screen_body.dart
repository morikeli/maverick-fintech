import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/theme_controller.dart';
import '../../../core/theme/colors.dart';
import 'custom_list_tile.dart';

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({super.key, required this.themeController});

  final ThemeController themeController;
  final AuthController authController = Get.put(AuthController());

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
      bool isDark = themeController.isDarkMode;

      return ListView(
        padding: EdgeInsets.all(12.0),
        children: [
          // 1. profile picture
          userProfilePicture(context),

          // 2. username
          SizedBox(height: 8.0),
          userNameAndLocation(context),
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
                onChanged: (value) => themeController.toggleTheme(value),
              ),
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
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: kButtonDarkColor,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Text('Edit profile'),
          ),
        ),
        SizedBox(width: 12.0),

        // 2. Reset PIN btn
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: kButtonDarkColor,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Text('Reset PIN'),
          ),
        ),
      ],
    );
  }

  Center userNameAndLocation(BuildContext context) {
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
