import 'package:flutter/material.dart';

import '../../../controllers/history_controller.dart';
import 'history_list_tile_widget.dart';

class TransactionHistoryWidget extends StatelessWidget {
  const TransactionHistoryWidget({super.key, required this.controller});

  final HistoryController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: controller.filteredTransactions.length,
        itemBuilder: (context, index) {
          final txn = controller.filteredTransactions[index];
          return HistoryListTileWidget(txn: txn);
        },
      ),
    );
  }
}
