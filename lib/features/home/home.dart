import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/dashboard_controller.dart';
import '../../widgets/loading_widget.dart';
import 'widgets/home_screen_body_widget.dart';
import 'widgets/send_money_fab.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: LoadingWidget.newtonCradleMedium());
      }
      
      return Scaffold(
        body: HomeScreenBodyWidget(controller: controller),
        floatingActionButton: SendMoneyFAB(),
      );
    });
  }
}
