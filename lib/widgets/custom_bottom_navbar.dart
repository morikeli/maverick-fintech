import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import '../core/theme/colors.dart';


class CustomBottomNavBar extends StatelessWidget {
  final void Function(int) onTabClicked;
  final int activeTab;

  const CustomBottomNavBar({
    super.key,
    required this.onTabClicked,
    required this.activeTab,
  });

  @override
  Widget build(BuildContext context) {
    return GNav(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      onTabChange: onTabClicked,
      rippleColor: Colors.grey, // tab button ripple color when pressed
      hoverColor: Colors.white38, // tab button hover color
      duration: Duration(milliseconds: 300), // tab animation duration
      gap: 8, // the tab button gap between icon and text
      color: Colors.grey, // unselected icon color
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0), // navigation bar padding
      textStyle: Theme.of(context).textTheme.labelSmall,
      tabs: [
        GButton(
          icon: activeTab == 0 ? BootstrapIcons.grid_1x2_fill : BootstrapIcons.grid_1x2,
          text: 'Home',
        ),
        GButton(
          icon: BootstrapIcons.cash_coin,
          text: 'Send money',
          textColor: kTextLightColor,
        ),
        GButton(
          icon: BootstrapIcons.list_ul,
          text: 'Transactions',
          textColor: kTextLightColor,
        ),
        GButton(
          leading: Center(
            child: CircleAvatar(
              radius: 14.0,
              backgroundImage: AssetImage('assets/imgs/5.jpg'),
            ),
          ),
          icon: BootstrapIcons.person_circle,
          text: 'Profile',
          textColor: kTextLightColor,
        ),
      ],
    );
  }
}
