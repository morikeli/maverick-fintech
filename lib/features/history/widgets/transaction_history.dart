import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/history_controller.dart';
import 'history_list_tile_widget.dart';

class TransactionHistoryWidget extends StatelessWidget {
  const TransactionHistoryWidget({super.key, required this.controller});

  final HistoryController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Expanded(
        child: ListView.builder(
          itemCount: controller.filteredTransactions.length,
          itemBuilder: (context, index) {
            // if filters are applied show filtered transactions
            if (controller.filteredTransactions.isNotEmpty) {
              final txn = controller.filteredTransactions[index];
              return HistoryListTileWidget(txn: txn);
            }

            final txn = controller.filteredTransactions[index];
            return HistoryListTileWidget(txn: txn);
          },
        ),
      );
    });
  }
}
