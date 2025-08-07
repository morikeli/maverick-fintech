import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/colors.dart';
import '../../controllers/dashboard_controller.dart';
import 'widgets/home_screen_body_widget.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeScreenBodyWidget(controller: controller),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Send money',
        onPressed: () => Get.toNamed('/send-money'),
        child: Icon(Icons.upload, color: kIconLightColor),
      ),
    );
  }
}
