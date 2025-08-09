import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      final transactions = controller;
      final user = FirebaseAuth.instance.currentUser;

      if (transactions.allTransactions.isEmpty || transactions.filteredTransactions.isEmpty) {
        return Center(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .16),
              Icon(BootstrapIcons.receipt_cutoff, size: 30.0),
              const SizedBox(height: 8.0),
              Text(
                'No transaction records found',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        shrinkWrap: true, // Let it size itself based on items
        physics: const NeverScrollableScrollPhysics(), // prevent nested scroll conflict
        itemCount: transactions.filteredTransactions.length,
        itemBuilder: (context, index) {
          // if filters are applied show filtered transactions
          if (transactions.filteredTransactions.isNotEmpty) {
            final txn = transactions.filteredTransactions[index];
            return HistoryListTileWidget(txn: txn, currentUser: user);
          }

          final txn = transactions.allTransactions[index];
          return HistoryListTileWidget(txn: txn, currentUser: user);
        },
      );
    });
  }
}
