
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/dashboard_controller.dart';
import 'header_component.dart';
import 'recent_transactions_components.dart';

class HomeScreenBodyComponent extends StatelessWidget {
  const HomeScreenBodyComponent({
    super.key,
    required this.controller,
  });

  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderComponent(controller: controller),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              "Recent Transactions",
              style: TextStyle(fontSize: 18),
            ),
          ),
          RecentTransactionComponent(controller: controller),
        ],
      );
    });
  }
}
