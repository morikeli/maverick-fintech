import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maverick_app/core/theme/colors.dart';

import '../../../controllers/dashboard_controller.dart';
import 'package:maverick_app/models/transaction_model.dart';

class RecentTransactionsWidget extends StatelessWidget {
  const RecentTransactionsWidget({super.key, required this.controller});

  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        itemCount: controller.recentTransactions.length,
        itemBuilder: (context, index) {
          final txn = controller.recentTransactions[index];
          return transactionRecordTile(txn, context);
        },
      ),
    );
  }

  ListTile transactionRecordTile(TransactionModel txn, BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20.0,
        backgroundImage: AssetImage('assets/imgs/8.jpg'),
      ),
      title: Text(
        txn.counterparty,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16.0),
      ),
      subtitle: transactionType(txn, context),
      trailing: transactionDateAndAmount(txn, context),
    );
  }

  Text transactionType(TransactionModel txn, BuildContext context) {
    return Text(
      txn.type == "send"
          ? "Sent"
          : "Received", // show "Sent" for sent transactions and "Received" for received transactions
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
