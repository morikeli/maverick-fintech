import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maverick_app/core/theme/colors.dart';

import '../../../controllers/dashboard_controller.dart';
import '../../../models/transaction_model.dart';
import '../../../core/helpers/currency_formatter.dart';
import '../../../widgets/loading_widget.dart';

class RecentTransactionsWidget extends StatelessWidget {
  const RecentTransactionsWidget({super.key, required this.controller});

  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final transactions = controller.recentTransactions;

      if (controller.isLoading.value) {
        return Center(child: LoadingWidget.newtonCradleMedium());
      }

      if (transactions.isEmpty) {
        return Center(
          child: ListView(
            children: [
              Icon(BootstrapIcons.receipt_cutoff, size: 30.0),
              Text(
                'No transaction records found',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final txn = transactions[index];
          return transactionRecordTile(txn, context);
        },
      );
    });
  }

  ListTile transactionRecordTile(TransactionModel txn, BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20.0,
        backgroundImage: AssetImage('assets/imgs/8.jpg'),
      ),
      title: Text(
        txn.counterparty,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14.0),
      ),
      subtitle: transactionType(txn, context),
      trailing: transactionDateAndAmount(txn, context),
    );
  }

  Text transactionType(TransactionModel txn, BuildContext context) {
    return Text(
      // show "Sent" for sent transactions and "Received" for received transactions
      txn.type == "send" ? "Sent" : "Received",
      style: Theme.of(context).textTheme.labelSmall,
    );
  }

  Column transactionDateAndAmount(TransactionModel txn, BuildContext context) {
    return Column(
      children: [
        Text(
          CurrencyHelper.formatTransactionAmount(
            amount: txn.amount,
            currency: txn.currency,
            isSent: txn.type == "send",
            abbreviated: true, // apply formatting & abbreviation
          ),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: txn.type == "send"
                ? kSentTransactionColor
                : kRecievedTransactionColor,
          ),
        ),
        Text(
          DateFormat.yMMMd().format(txn.date),
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }
}
