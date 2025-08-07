
import 'package:flutter/material.dart';

import '../../../controllers/dashboard_controller.dart';

class RecentTransactionComponent extends StatelessWidget {
  const RecentTransactionComponent({
    super.key,
    required this.controller,
  });

  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        itemCount: controller.recentTransactions.length,
        itemBuilder: (context, index) {
          final txn = controller.recentTransactions[index];
          return ListTile(
            leading: Icon(
              txn.type == "send"
                  ? Icons.arrow_upward
                  : Icons.arrow_downward,
            ),
            title: Text(
              "${txn.type.toUpperCase()} - ${txn.counterparty}",
            ),
            subtitle: Text(txn.date.toLocal().toString().split(' ')[0]),
            trailing: Text("${txn.currency} ${txn.amount}"),
          );
        },
      ),
    );
  }
}
