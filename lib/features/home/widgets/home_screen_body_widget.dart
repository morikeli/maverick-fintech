import 'package:flutter/material.dart';

import '../../../controllers/dashboard_controller.dart';
import 'header_widget.dart';
import 'recent_transactions_widget.dart';

class HomeScreenBodyWidget extends StatelessWidget {
  const HomeScreenBodyWidget({super.key, required this.controller});

  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // 1. Header widget with wallet balance, currency type dropdown, avatar and greetings
        HeaderWidget(controller: controller),
        SizedBox(height: 20),
        // 2. Title for recent transactions
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text("Recent Transactions", style: TextStyle(fontSize: 18.0)),
        ),
        // 3. Recent transactions list
        RecentTransactionsWidget(controller: controller),
      ],
    );
  }
}
