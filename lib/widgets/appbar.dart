import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:maverick_app/core/theme/colors.dart';

AppBar sharedAppBar(BuildContext context, String appBarTitle) => AppBar(
  automaticallyImplyLeading: false,
  backgroundColor: kAppBarColor,
  centerTitle: true,
  title: Text(appBarTitle, style: Theme.of(context).textTheme.titleMedium,),
  actions: [
    Row(
      children: [
        Stack(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(BootstrapIcons.bell_fill, color: kIconLightColor, size: 20.0),
            ),
            Positioned(
              right: 16,
              top: 16,
              child: Badge(
                backgroundColor: kNotificationBadgeColor,
                smallSize: 8.0,
                largeSize: 16.0,
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
